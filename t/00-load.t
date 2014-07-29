#!perl -T

use Test::More;
use strict;
use warnings;

BEGIN {
    use_ok('WWW::LongURL');
}

diag("Testing WWW::LongURL $WWW::LongURL::VERSION, Perl $], $^X");
can_ok('WWW::LongURL', qw(new));
can_ok('WWW::LongURL', qw(expand));
can_ok('WWW::LongURL', qw(get_services));
can_ok('WWW::LongURL', qw(_call_api));
can_ok('WWW::LongURL', qw(apibase));
can_ok('WWW::LongURL', qw(useragent));
can_ok('WWW::LongURL', qw(format));
can_ok('WWW::LongURL', qw(error));

done_testing;
