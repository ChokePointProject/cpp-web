package CPP::Object::Result::IncidentType;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

use strict;
use warnings;

use base 'DBIx::Class::Core';

__PACKAGE__->load_components("InflateColumn::DateTime", "TimeStamp::WithTimeZone");

=head1 NAME

CPP::Object::Result::IncidentType

=cut

__PACKAGE__->table("incident_type");

=head1 ACCESSORS

=head2 id

  data_type: 'varchar'
  is_nullable: 0
  size: 16

=head2 name

  data_type: 'varchar'
  is_nullable: 0
  size: 255

=cut

__PACKAGE__->add_columns(
  "id",
  { data_type => "varchar", is_nullable => 0, size => 16 },
  "name",
  { data_type => "varchar", is_nullable => 0, size => 255 },
);
__PACKAGE__->set_primary_key("id");

=head1 RELATIONS

=head2 incidents

Type: has_many

Related object: L<CPP::Object::Result::Incident>

=cut

__PACKAGE__->has_many(
  "incidents",
  "CPP::Object::Result::Incident",
  { "foreign.type" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);


# Created by DBIx::Class::Schema::Loader v0.07002 @ 2011-10-15 22:58:22
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:2i02wTMw6LpXi5KGW8HR2w


# You can replace this text with custom content, and it will be preserved on regeneration
1;
