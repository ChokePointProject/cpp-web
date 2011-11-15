#!/usr/bin/perl
use lib 'lib/';
use strict;
# use warnings;
use Carp;
use FindBin;
use Data::Dumper;
use DBIx::Class::Schema::Loader qw(make_schema_at);
use Config::Any;

my $TABLE_INFO = {
};

my $PLURAL = {
};

sub table_name {
	my $id = shift;
	# print stderr "  table_name id=$id\n";
	my $ref = $TABLE_INFO->{$id};
	return $ref ? $ref->{name} : $id;
}

sub column_info {
      my ($table_name, $column_name, $column_info) = @_;
      # print STDERR "  column_info() table_name=$table_name column_name=$column_name ";
	my $ref = $TABLE_INFO->{$table_name};
	my $info = {};
	if($ref && $ref->{columns}->{uc($column_name)}) {
		$info->{accessor} = $ref->{columns}->{uc($column_name)};
	}
	if($column_info->{data_type}=~m,date,i) {
		$info->{'locale'} = 'es_MX';
		$info->{datetime_undef_if_invalid} = 1;
	}
	if(($column_name eq 'id') || ($info->{accessor} eq 'id')) {
		if(my $seq = $ref->{sequence}) {
#			$info->{auto_nextval} = 1;
			$info->{sequence} = $seq;
		}
	}
	if($column_name eq 'date_created') {
		$info->{set_on_create} = 1; 
	}
	if($column_name eq 'last_updated') {
		$info->{set_on_create} = 1; 
		$info->{set_on_update} = 1; 
	}
#	print STDERR Dumper($info);
	return $info;
}

my($schema_class,$connect_info);
my $config_dir = $FindBin::Bin.'/..';
print STDERR "config_dir=$config_dir\n";
my @config = glob('*.conf');
my $cfg = Config::Any->load_files({files => \@config, use_ext=>1});
for(@{$cfg}) {
	my($filename,$config)=%$_;
	print STDERR "Config file $filename\n";
	if(my $section = $config->{'Model::DB'}) {
		print STDERR Dumper($section);
		$schema_class = $section->{schema_class};
		$connect_info = $section->{connect_info};
	}
}

#print STDERR Dumper({schema_class=>$schema_class,connect_info=>\@connect_info});

my $schema_dir = $FindBin::Bin.'/../lib';
print STDERR "schema_dir=$schema_dir\n";


DBIx::Class::Schema::Loader->dump_to_dir($schema_dir)
    or croak "Cannot load DBIx::Class::Schema::Loader: $@";

my @loader_connect_info = ref($connect_info) eq 'HASH' ? (
	$connect_info->{dsn},
	$connect_info->{user},
	$connect_info->{password},
	$connect_info,
) : @{$connect_info||[]};
#my $num = 2; # argument number on the commandline for "dbi:..."
for(@loader_connect_info) {
    if(/^\s*[[{]/) {
	$_ = eval "$_";
	#croak "Perl syntax error in commandline argument $num: $@" if $@;
    }
#    $num++;
}
make_schema_at(
    $schema_class,
    { 
#    	debug=>1, 
	dump_directory => './lib',
    	components => [qw(InflateColumn::DateTime TimeStamp::WithTimeZone)],
	scalar(keys(%{$TABLE_INFO})) ? ( moniker_map => \&table_name, ) : (),
	custom_column_info => \&column_info,
	use_namespaces => 1,
	default_resultset_class => 'ResultSet',
	inflect_plural => $PLURAL,
    },
    \@loader_connect_info,
);


