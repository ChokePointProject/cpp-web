use strict;
use warnings;
use Test::More;

BEGIN { use_ok 'Catalyst::Test', 'CPP' }
BEGIN { use_ok 'CPP::Controller::Country' }

ok( request('/country')->is_success, 'Request should succeed' );
done_testing();
