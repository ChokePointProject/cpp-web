package CPP::Controller::Country;
use Moose;
use namespace::autoclean;

BEGIN {extends 'Catalyst::Controller'; }

=head1 NAME

CPP::Controller::Country - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut


=head2 index

=cut

sub index :Path :Args(0) {
    my ( $self, $c ) = @_;

}

sub view: Path :Args(1) {
	my($self,$c,$id) = @_;
	my $country = $c->model('DB::Country')->find($id);
	if(!$country) {
	    $c->response->body( 'Page not found' );
	    $c->response->status(404);
	}
	$c->stash->{country} = $country;
}


=head1 AUTHOR

arturo

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

__PACKAGE__->meta->make_immutable;

1;
