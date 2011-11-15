package CPP::View::Mason;

use strict;
use warnings;

use parent 'Catalyst::View::Mason';

__PACKAGE__->config(
	use_match          => 0,
	template_extension => '.html',
	escape_flags       => {},
);

=head1 NAME

CPP::View::Mason - Mason View Component for CPP

=head1 DESCRIPTION

Mason View Component for CPP

=head1 SEE ALSO

L<CPP>, L<HTML::Mason>

=head1 AUTHOR

arturo

=head1 LICENSE

This library is free software . You can redistribute it and/or modify it under
the same terms as perl itself.

=cut

1;
