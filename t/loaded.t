use strict;
use warnings;

use Data::Printer;
use Module::Version::Loaded qw( versioned_inc versioned_modules );
use Test::More;

my %inc     = versioned_inc();
my %modules = versioned_modules();

ok( %inc, 'got versioned inc' );
cmp_ok(
    $inc{'Module/Version.pm'}, '>=', 0.12,
    'Module::Version gets its own version in inc'
);

cmp_ok(
    $modules{'Module::Version'}, '>=', 0.12,
    'Module::Version gets its own version in modules'
);

diag p %inc;
diag p %modules;

done_testing();
