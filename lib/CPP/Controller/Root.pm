package CPP::Controller::Root;
use Moose;
use namespace::autoclean;
use JSON;

BEGIN { extends 'Catalyst::Controller' }

#
# Sets the actions in this controller to be registered with no prefix
# so they function identically to actions created in MyApp.pm
#
__PACKAGE__->config(namespace => '');

=head1 NAME

CPP::Controller::Root - Root Controller for CPP

=head1 DESCRIPTION

[enter your description here]

=head1 METHODS

=head2 index

The root page (/)

=cut

sub index :Path :Args(0) {
    my ( $self, $c ) = @_;
}

=head2 default

Standard 404 error page

=cut

sub default :Path {
    my ( $self, $c ) = @_;
    $c->response->body( 'Page not found' );
    $c->response->status(404);
}

=head2 end

Attempt to render a view, if needed.

=cut

sub end : ActionClass('RenderView') {}

=head1 AUTHOR

arturo

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

our $json = JSON->new();

sub incidents :Local {
	my($self,$c) = @_;
	my($ret);
	foreach my $rec ($c->model('DB::Incident')->search({type=>15},{order_by=>'ts desc',rows=>50})->all) {
		my($data);
		map {$data->{$_} = $rec->$_} qw(lat lon);
		$data->{ts} = $rec->ts ? $rec->ts->strftime('%Y-%m-%d') : '';
		$data->{type} = $rec->type->id;
		$data->{name} = $rec->type->name;
		if(my @countries = $rec->countries()) {
			$data->{country} = $countries[0]->id;
		}
		
		push @{$ret}, $data;
	}
	$c->response->body($json->encode($ret));
}


sub incident_timeline :Local {
	my($self,$c) = @_;
	my($ret);
	foreach my $rec ($c->model('DB::Incident')->search({type=>15},{order_by=>'ts'})->all) {
		my($data);
		map {$data->{$_} = $rec->$_} qw(lat lon);
		my $ts = $rec->ts ? $rec->ts->strftime('%Y-%m-%d') : '';
		$data->{ts} = $ts;
		$data->{type} = $rec->type->id;
		$data->{name} = $rec->type->name;
		if(my @countries = $rec->countries()) {
			$data->{country} = $countries[0]->id;
		}
		if($ts) {
			push @{$ret->{$ts}}, $data;
		}
	}
	my $data;
	foreach my $ts (sort keys %{$ret}) {
		push @{$data}, {ts=>$ts,data=>$ret->{$ts}};
	}
	$c->response->body($json->encode($data));
}

sub about :Local {
	
}

__PACKAGE__->meta->make_immutable;

1;
