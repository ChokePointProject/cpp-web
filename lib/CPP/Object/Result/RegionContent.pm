package CPP::Object::Result::RegionContent;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

use strict;
use warnings;

use base 'DBIx::Class::Core';

__PACKAGE__->load_components("InflateColumn::DateTime", "TimeStamp::WithTimeZone");

=head1 NAME

CPP::Object::Result::RegionContent

=cut

__PACKAGE__->table("region_content");

=head1 ACCESSORS

=head2 region

  data_type: 'varchar'
  is_foreign_key: 1
  is_nullable: 0
  size: 16

=head2 id

  data_type: 'varchar'
  is_nullable: 0
  size: 16

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

=head2 content

  data_type: 'text'
  is_nullable: 1

=head2 usr

  data_type: 'varchar'
  is_foreign_key: 1
  is_nullable: 0
  size: 64

=cut

__PACKAGE__->add_columns(
  "region",
  { data_type => "varchar", is_foreign_key => 1, is_nullable => 0, size => 16 },
  "id",
  { data_type => "varchar", is_nullable => 0, size => 16 },
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
  "content",
  { data_type => "text", is_nullable => 1 },
  "usr",
  { data_type => "varchar", is_foreign_key => 1, is_nullable => 0, size => 64 },
);
__PACKAGE__->set_primary_key("region", "id");

=head1 RELATIONS

=head2 region

Type: belongs_to

Related object: L<CPP::Object::Result::Region>

=cut

__PACKAGE__->belongs_to(
  "region",
  "CPP::Object::Result::Region",
  { id => "region" },
  { is_deferrable => 1, on_delete => "CASCADE", on_update => "CASCADE" },
);

=head2 usr

Type: belongs_to

Related object: L<CPP::Object::Result::Usr>

=cut

__PACKAGE__->belongs_to(
  "usr",
  "CPP::Object::Result::Usr",
  { id => "usr" },
  { is_deferrable => 1, on_delete => "CASCADE", on_update => "CASCADE" },
);


# Created by DBIx::Class::Schema::Loader v0.07002 @ 2011-11-21 21:20:27
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:OjkfLjSsbhbP8RRfELduKg


# You can replace this text with custom content, and it will be preserved on regeneration
1;
