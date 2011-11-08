use strict;
use warnings;
use Test::More;

BEGIN { use_ok 'Catalyst::Test', 'CPP' }
BEGIN { use_ok 'CPP::Controller::Site' }

ok( request('/site')->is_success, 'Request should succeed' );
done_testing();
