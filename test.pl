# Before `make install' is performed this script should be runnable with
# `make test'. After `make install' it should work as `perl test.pl'

#########################


use strict;
use Test;
my $loaded;

BEGIN { 
    $| = 1;
    plan tests => 2;
};

use PDL;
use PDL::LAPACK;

### test: modules load
$loaded = 1;
ok(1); #


### End of black magic.


### test geinv (general matrix invert)
ok( sum( approx ( geinv( pdl [ [ 1 , 1 ], [1, 2 ] ] ) , pdl [ [2,-1] , [-1,1 ]]) ) == 4);



exit(0);