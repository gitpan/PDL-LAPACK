use PDL::Core::Dev;
use ExtUtils::MakeMaker;
PDL::Core::Dev->import();


$package = ["lapack.pd",LAPACK,PDL::LAPACK];

# the hash helps dh-make-perl to find needed name and version strings
# ( for creating a debian package:
#	dh-make-perl creates .deb packages from standard perl source modules 
# 	call with:  
#	    dh-make-perl --build --desc "LAPACK access from PDL" <SOURCE_DIR> 
# )
%hash=(                                                                                                        
	pdlpp_stdargs($package),
	
	'NAME'           => 'PDL::LAPACK',                                                                       
	'VERSION_FROM'   => 'lapack.pd',  # finds $VERSION
	($] ge '5.005' ? # Add these new keywords supported since 5.005
	    (
	     'AUTHOR'         => 'Harald Bartel / Prozentor GmbH (harald.bartel@prozentor.de)',
	     'ABSTRACT'       => 'Perl PDL access to LAPACK', 
	     ) : () ),
	     
);


# required libraries and search paths
$hash{LIBS}->[0] .= " -L./CLAPACK ";    # path to needed libraries 
$hash{LIBS}->[0] .= " -llapack_LINUX "; # change to the name of your compiled clapack library
$hash{LIBS}->[0] .= " -lcblaswr ";
$hash{LIBS}->[0] .= " -lcblas ";
$hash{LIBS}->[0] .= " -latlas "; 	# link against atlas or blas
$hash{LIBS}->[0] .= " -lF77 ";
$hash{LIBS}->[0] .= " -lm ";

# addtional include directories
$hash{INC}       .= ' -I./CLAPACK ';# additional include dir

WriteMakefile( %hash );

sub MY::postamble {pdlpp_postamble($package)};
	  
