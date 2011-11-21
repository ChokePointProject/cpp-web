#!/usr/bin/env perl
# Import Google Transparency Data
use strict;
use encoding 'utf8';
use FindBin;
use lib "$FindBin::Bin/../lib";
use warnings;
use Carp;
use Data::Dumper;
use Config::Any;
use XML::Simple;
use CPP::Object;
use WWW::Mechanize;
use JSON::XS;
use DateTime::Format::Strptime;

my($db,$seen,$URL);
my $config_dir = $FindBin::Bin.'/..';
my @config = glob('*.conf');
my $cfg = Config::Any->load_files({files => \@config, use_ext=>1});
for(@{$cfg}) {
	my($filename,$config)=%$_;
	if(my $section = $config->{'Model::DB'}) {
		$db = CPP::Object->connect($section->{connect_info});
	}
	if(my $url = $config->{DataSource}->{MLabs}) {
		$URL = $url;
	}
}
die("Can't connect to database") unless $db;

my $xs = XML::Simple->new();
my $json = JSON::XS->new();
my $strp = new DateTime::Format::Strptime(
                                pattern     => '%Y-%m-%d',
                                locale      => 'en_US',
                                time_zone   => 'GMT',
                        );
my $mech = WWW::Mechanize->new();

$mech->get($URL.'/countries.json');
my $js = $mech->content();
my $list = $json->decode($js);
foreach my $country_rec (@{$list}) {
	my $id = $country_rec->{code};
	next unless $id;
	print "Doing country=$id\n";
	my $country = $db->resultset('Country')->find($id);
	eval {
		$mech->get($URL.'content_removal_requests.json?country_code='.$id);
	};
	if($@) {
		warn($@);
	} else {
		my $data = $json->decode($mech->content());
		#print Dumper($data);
		foreach my $rec (@{$data}) {
			my $ts = $strp->parse_datetime($rec->{content_removal_request_period}->{period_start});
			my $ts_end = $strp->parse_datetime($rec->{content_removal_request_period}->{period_end});
			my @src;
			if($rec->{court_orders}) {
				push @src, $rec->{court_orders}." court order".($rec->{court_orders}==1?'':'s');
			}
			if($rec->{executive}) {
				push @src, $rec->{executive}." request".($rec->{executive}==1?'':'s')." from executive organs (Police, etc.)";
			}
			my $reason =$rec->{reason}->{name} eq 'Undefined' ? 'for unspecified reasons' : 'citing "'.$rec->{reason}->{name}.'" as the main reason';
			my $comp = $rec->{content_removal_request_period}->{percentage_complied} == 100 ? 'fully' : sprintf("by censoring %d%% of the requested items",$rec->{content_removal_request_period}->{percentage_complied});
			my $descr = sprintf("Between %s and %s, Google received %s to take down %s from %s %s. Google complied %s.",
				$ts->strftime("%Y-%m-%d"),
				$ts_end->strftime("%Y-%m-%d"),
				join(" and ",@src),
				$rec->{items}?$rec->{items}.' item'.($rec->{items}==1?'':'s').' ':' unspecified content ',
				$rec->{product}->{name},
				$reason,
				$comp,
			); 
			my $name = sprintf("%s takedown request by government body",$rec->{product}->{name});
			my $incident = $db->resultset('Incident')->create({
				'type' => '17',
				'ts' => $ts,
				'ts_end' => $ts_end,
				'name' => $name, 
				'descr' => $descr,
				'lat' => $country_rec->{latitude},
				'lon' => $country_rec->{longitude},
			});
			$country->add_to_country_incidents({
				incident => $incident,
			});
		}
	}
	eval {	
		$mech->get($URL.'user_data_requests.json?country_code='.$id);
	};
	if($@) {
		warn($@);
	} else {
		my $data = $json->decode($mech->content());
		foreach my $rec (@{$data}) {
			my $ts = $strp->parse_datetime($rec->{period_start});
			my $ts_end = $strp->parse_datetime($rec->{period_end});
			my $comp = $rec->{percentage_complied} == 100 ? 'fully' : sprintf("with %d%% of the requests",$rec->{percentage_complied});
			my $descr = sprintf("Between %s and %s, Google received %s%s. Google complied %s.",
				$ts->strftime("%Y-%m-%d"),
				$ts_end->strftime("%Y-%m-%d"),
				$rec->{requests}." user data request".($rec->{requests}==1?'':'s'),
				$rec->{accounts}?" for ".$rec->{accounts}." account".($rec->{accounts}==1?'':'s'):'',
				$comp,
			); 
			my $name = $rec->{requests}." user data request".($rec->{requests}==1?'':'s');
			my $incident = $db->resultset('Incident')->create({
				'type' => '18',
				'ts' => $ts,
				'ts_end' => $ts_end,
				'name' => $name, 
				'descr' => $descr,
				'lat' => $country_rec->{latitude},
				'lon' => $country_rec->{longitude},
			});
			$country->add_to_country_incidents({
				incident => $incident,
			});
		}
	}
}
