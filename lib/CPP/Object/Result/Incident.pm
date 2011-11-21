package CPP::Object::Result::Incident;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

use strict;
use warnings;

use base 'DBIx::Class::Core';

__PACKAGE__->load_components("InflateColumn::DateTime", "TimeStamp::WithTimeZone");

=head1 NAME

CPP::Object::Result::Incident

=cut

__PACKAGE__->table("incident");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0

=head2 date_created

  data_type: 'datetime'
  datetime_undef_if_invalid: 1
  is_nullable: 1
  locale: 'en_US'
  set_on_create: 1

=head2 last_updated

  data_type: 'datetime'
  datetime_undef_if_invalid: 1
  is_nullable: 1
  locale: 'en_US'
  set_on_create: 1
  set_on_update: 1

=head2 ts

  data_type: 'datetime'
  datetime_undef_if_invalid: 1
  is_nullable: 1
  locale: 'en_US'

=head2 ts_end

  data_type: 'datetime'
  datetime_undef_if_invalid: 1
  is_nullable: 1
  locale: 'en_US'

=head2 type

  data_type: 'varchar'
  is_foreign_key: 1
  is_nullable: 1
  size: 16

=head2 source

  data_type: 'varchar'
  is_nullable: 1
  size: 16

=head2 source_id

  data_type: 'varchar'
  is_nullable: 1
  size: 64

=head2 usr

  data_type: 'varchar'
  is_nullable: 1
  size: 64

=head2 name

  data_type: 'varchar'
  is_nullable: 1
  size: 255

=head2 descr

  data_type: 'text'
  is_nullable: 1

=head2 lat

  data_type: 'double precision'
  is_nullable: 1

=head2 lon

  data_type: 'double precision'
  is_nullable: 1

=cut

__PACKAGE__->add_columns(
  "id",
  { data_type => "integer", is_auto_increment => 1, is_nullable => 0 },
  "date_created",
  {
    data_type => "datetime",
    datetime_undef_if_invalid => 1,
    is_nullable => 1,
    locale => "en_US",
    set_on_create => 1,
  },
  "last_updated",
  {
    data_type => "datetime",
    datetime_undef_if_invalid => 1,
    is_nullable => 1,
    locale => "en_US",
    set_on_create => 1,
    set_on_update => 1,
  },
  "ts",
  {
    data_type => "datetime",
    datetime_undef_if_invalid => 1,
    is_nullable => 1,
    locale => "en_US",
  },
  "ts_end",
  {
    data_type => "datetime",
    datetime_undef_if_invalid => 1,
    is_nullable => 1,
    locale => "en_US",
  },
  "type",
  { data_type => "varchar", is_foreign_key => 1, is_nullable => 1, size => 16 },
  "source",
  { data_type => "varchar", is_nullable => 1, size => 16 },
  "source_id",
  { data_type => "varchar", is_nullable => 1, size => 64 },
  "usr",
  { data_type => "varchar", is_nullable => 1, size => 64 },
  "name",
  { data_type => "varchar", is_nullable => 1, size => 255 },
  "descr",
  { data_type => "text", is_nullable => 1 },
  "lat",
  { data_type => "double precision", is_nullable => 1 },
  "lon",
  { data_type => "double precision", is_nullable => 1 },
);
__PACKAGE__->set_primary_key("id");

=head1 RELATIONS

=head2 country_incidents

Type: has_many

Related object: L<CPP::Object::Result::CountryIncident>

=cut

__PACKAGE__->has_many(
  "country_incidents",
  "CPP::Object::Result::CountryIncident",
  { "foreign.incident" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 type

Type: belongs_to

Related object: L<CPP::Object::Result::IncidentType>

=cut

__PACKAGE__->belongs_to(
  "type",
  "CPP::Object::Result::IncidentType",
  { id => "type" },
  {
    is_deferrable => 1,
    join_type     => "LEFT",
    on_delete     => "CASCADE",
    on_update     => "CASCADE",
  },
);

=head2 region_incidents

Type: has_many

Related object: L<CPP::Object::Result::RegionIncident>

=cut

__PACKAGE__->has_many(
  "region_incidents",
  "CPP::Object::Result::RegionIncident",
  { "foreign.incident" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);


# Created by DBIx::Class::Schema::Loader v0.07002 @ 2011-11-21 22:37:18
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:EXiC3KmqeeEwgG3GYbNxVw

  __PACKAGE__->many_to_many('countries' => 'country_incidents', 'country');
  __PACKAGE__->many_to_many('regions' => 'region_incidents', 'region');


1;
