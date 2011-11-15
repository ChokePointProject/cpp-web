package CPP::Object::Result::Country;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

use strict;
use warnings;

use base 'DBIx::Class::Core';

__PACKAGE__->load_components("InflateColumn::DateTime", "TimeStamp::WithTimeZone");

=head1 NAME

CPP::Object::Result::Country

=cut

__PACKAGE__->table("country");

=head1 ACCESSORS

=head2 id

  data_type: 'varchar'
  default_value: (empty string)
  is_nullable: 0
  size: 2

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

=head2 bb_nw_lat

  data_type: 'double precision'
  is_nullable: 1

=head2 bb_nw_lon

  data_type: 'double precision'
  is_nullable: 1

=head2 bb_se_lat

  data_type: 'double precision'
  is_nullable: 1

=head2 bb_se_lon

  data_type: 'double precision'
  is_nullable: 1

=cut

__PACKAGE__->add_columns(
  "id",
  { data_type => "varchar", default_value => "", is_nullable => 0, size => 2 },
  "name",
  { data_type => "varchar", is_nullable => 1, size => 255 },
  "lat",
  { data_type => "double precision", is_nullable => 1 },
  "lon",
  { data_type => "double precision", is_nullable => 1 },
  "bb_nw_lat",
  { data_type => "double precision", is_nullable => 1 },
  "bb_nw_lon",
  { data_type => "double precision", is_nullable => 1 },
  "bb_se_lat",
  { data_type => "double precision", is_nullable => 1 },
  "bb_se_lon",
  { data_type => "double precision", is_nullable => 1 },
);
__PACKAGE__->set_primary_key("id");

=head1 RELATIONS

=head2 country_contents

Type: has_many

Related object: L<CPP::Object::Result::CountryContent>

=cut

__PACKAGE__->has_many(
  "country_contents",
  "CPP::Object::Result::CountryContent",
  { "foreign.country" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 country_incidents

Type: has_many

Related object: L<CPP::Object::Result::CountryIncident>

=cut

__PACKAGE__->has_many(
  "country_incidents",
  "CPP::Object::Result::CountryIncident",
  { "foreign.country" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 region_countries

Type: has_many

Related object: L<CPP::Object::Result::RegionCountry>

=cut

__PACKAGE__->has_many(
  "region_countries",
  "CPP::Object::Result::RegionCountry",
  { "foreign.country" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);


# Created by DBIx::Class::Schema::Loader v0.07002 @ 2011-10-15 22:58:22
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:ESPt6dcKNfAcnYufK8CGNw

  __PACKAGE__->many_to_many('incidents' => 'country_incidents', 'incident');

1;
