#!perl
use LWP::Online ':skip_all';
use strict;
use warnings;

# Skip online tests if we can't contact the LongURL API..
BEGIN {
    require Test::More;
    unless ( LWP::Online::online() ) {
        Test::More->import(
            skip_all => 'Test requires a working internet connection'
        );
    }
}

use Test::More;

use_ok('WWW::LongURL');
ok(my $expander = WWW::LongURL->new());
isa_ok($expander, 'WWW::LongURL');
my $short_url = 'http://is.gd/w';
is ($expander->expand($short_url), 'http://www.google.com/');
done_testing();
