package CPP::Object::Result::CountryIncident;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

use strict;
use warnings;

use base 'DBIx::Class::Core';

__PACKAGE__->load_components("InflateColumn::DateTime", "TimeStamp::WithTimeZone");

=head1 NAME

CPP::Object::Result::CountryIncident

=cut

__PACKAGE__->table("country_incident");

=head1 ACCESSORS

=head2 incident

  data_type: 'integer'
  default_value: 0
  is_foreign_key: 1
  is_nullable: 0

=head2 country

  data_type: 'varchar'
  default_value: (empty string)
  is_foreign_key: 1
  is_nullable: 0
  size: 16

=cut

__PACKAGE__->add_columns(
  "incident",
  {
    data_type      => "integer",
    default_value  => 0,
    is_foreign_key => 1,
    is_nullable    => 0,
  },
  "country",
  {
    data_type => "varchar",
    default_value => "",
    is_foreign_key => 1,
    is_nullable => 0,
    size => 16,
  },
);
__PACKAGE__->set_primary_key("incident", "country");

=head1 RELATIONS

=head2 incident

Type: belongs_to

Related object: L<CPP::Object::Result::Incident>

=cut

__PACKAGE__->belongs_to(
  "incident",
  "CPP::Object::Result::Incident",
  { id => "incident" },
  { is_deferrable => 1, on_delete => "CASCADE", on_update => "CASCADE" },
);

=head2 country

Type: belongs_to

Related object: L<CPP::Object::Result::Country>

=cut

__PACKAGE__->belongs_to(
  "country",
  "CPP::Object::Result::Country",
  { id => "country" },
  { is_deferrable => 1, on_delete => "CASCADE", on_update => "CASCADE" },
);


# Created by DBIx::Class::Schema::Loader v0.07002 @ 2011-10-15 22:58:22
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:gx0S2Feb4vC3Bdjh+BD/Qw


# You can replace this text with custom content, and it will be preserved on regeneration
1;
