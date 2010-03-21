use inc::Module::Install;
name 'OpenSocialX-Gadgets';
all_from 'lib/OpenSocialX/Gadgets.pm';

requires 'XML::LibXML';
requires 'File::Slurp';

tests 't/*.t';
author_tests 'xt';

test_requires 'Test::More';
auto_set_repository;
auto_include;
WriteAll;
