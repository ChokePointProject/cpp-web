package CPP::Object::Result::Page;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

use strict;
use warnings;

use base 'DBIx::Class::Core';

__PACKAGE__->load_components("InflateColumn::DateTime", "TimeStamp::WithTimeZone");

=head1 NAME

CPP::Object::Result::Page

=cut

__PACKAGE__->table("page");

=head1 ACCESSORS

=head2 id

  data_type: 'varchar'
  is_nullable: 0
  size: 64

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

=cut

__PACKAGE__->add_columns(
  "id",
  { data_type => "varchar", is_nullable => 0, size => 64 },
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
);
__PACKAGE__->set_primary_key("id");


# Created by DBIx::Class::Schema::Loader v0.07002 @ 2011-11-21 21:20:26
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:JYAL1YodBGOBl6EBFu+7Mg


# You can replace this text with custom content, and it will be preserved on regeneration
1;
