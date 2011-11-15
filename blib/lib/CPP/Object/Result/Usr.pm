package CPP::Object::Result::Usr;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

use strict;
use warnings;

use base 'DBIx::Class::Core';

__PACKAGE__->load_components("InflateColumn::DateTime", "TimeStamp::WithTimeZone");

=head1 NAME

CPP::Object::Result::Usr

=cut

__PACKAGE__->table("usr");

=head1 ACCESSORS

=head2 id

  data_type: 'varchar'
  is_nullable: 0
  size: 64

=head2 date_created

  data_type: 'datetime'
  datetime_undef_if_invalid: 1
  is_nullable: 1
  locale: 'es_MX'
  set_on_create: 1

=head2 last_updated

  data_type: 'datetime'
  datetime_undef_if_invalid: 1
  is_nullable: 1
  locale: 'es_MX'
  set_on_create: 1
  set_on_update: 1

=head2 first_name

  data_type: 'varchar'
  is_nullable: 1
  size: 255

=head2 last_name

  data_type: 'varchar'
  is_nullable: 1
  size: 255

=head2 email

  data_type: 'varchar'
  is_nullable: 1
  size: 255

=cut

__PACKAGE__->add_columns(
  "id",
  { data_type => "varchar", is_nullable => 0, size => 64 },
  "date_created",
  {
    data_type => "datetime",
    datetime_undef_if_invalid => 1,
    is_nullable => 1,
    locale => "es_MX",
    set_on_create => 1,
  },
  "last_updated",
  {
    data_type => "datetime",
    datetime_undef_if_invalid => 1,
    is_nullable => 1,
    locale => "es_MX",
    set_on_create => 1,
    set_on_update => 1,
  },
  "first_name",
  { data_type => "varchar", is_nullable => 1, size => 255 },
  "last_name",
  { data_type => "varchar", is_nullable => 1, size => 255 },
  "email",
  { data_type => "varchar", is_nullable => 1, size => 255 },
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
  { "foreign.usr" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 region_contents

Type: has_many

Related object: L<CPP::Object::Result::RegionContent>

=cut

__PACKAGE__->has_many(
  "region_contents",
  "CPP::Object::Result::RegionContent",
  { "foreign.usr" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);


# Created by DBIx::Class::Schema::Loader v0.07002 @ 2011-10-15 22:58:22
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:YvVZQUV5nX0oV5zt+9u90A


# You can replace this text with custom content, and it will be preserved on regeneration
1;
