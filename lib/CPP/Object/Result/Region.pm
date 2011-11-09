package CPP::Object::Result::Region;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

use strict;
use warnings;

use base 'DBIx::Class::Core';

__PACKAGE__->load_components("InflateColumn::DateTime", "TimeStamp::WithTimeZone");

=head1 NAME

CPP::Object::Result::Region

=cut

__PACKAGE__->table("region");

=head1 ACCESSORS

=head2 id

  data_type: 'varchar'
  default_value: (empty string)
  is_nullable: 0
  size: 16

=head2 type

  data_type: 'varchar'
  is_nullable: 1
  size: 16

=head2 name

  data_type: 'varchar'
  is_nullable: 1
  size: 255

=head2 lat

  data_type: 'double precision'
  is_nullable: 1

=head2 lon

  data_type: 'double precision'
  is_nullable: 1

=cut

__PACKAGE__->add_columns(
  "id",
  { data_type => "varchar", default_value => "", is_nullable => 0, size => 16 },
  "type",
  { data_type => "varchar", is_nullable => 1, size => 16 },
  "name",
  { data_type => "varchar", is_nullable => 1, size => 255 },
  "lat",
  { data_type => "double precision", is_nullable => 1 },
  "lon",
  { data_type => "double precision", is_nullable => 1 },
);
__PACKAGE__->set_primary_key("id");

=head1 RELATIONS

=head2 region_contents

Type: has_many

Related object: L<CPP::Object::Result::RegionContent>

=cut

__PACKAGE__->has_many(
  "region_contents",
  "CPP::Object::Result::RegionContent",
  { "foreign.region" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 region_countries

Type: has_many

Related object: L<CPP::Object::Result::RegionCountry>

=cut

__PACKAGE__->has_many(
  "region_countries",
  "CPP::Object::Result::RegionCountry",
  { "foreign.region" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 region_incidents

Type: has_many

Related object: L<CPP::Object::Result::RegionIncident>

=cut

__PACKAGE__->has_many(
  "region_incidents",
  "CPP::Object::Result::RegionIncident",
  { "foreign.region" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);


# Created by DBIx::Class::Schema::Loader v0.07002 @ 2011-10-15 22:58:22
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:wozagY2AxIulZR8kA9iY5w

  __PACKAGE__->many_to_many('incidents' => 'region_incidents', 'incident');
  __PACKAGE__->many_to_many('countries' => 'region_countries', 'country');

1;
