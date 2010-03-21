#!/usr/bin/perl
use OpenSocialX::Gadgets;

my $gadget = OpenSocialX::Gadgets->new( title => 'Hello World' );
$gadget->add_pref( 'Require', { feature => ['opensocial-0.8'] } );
$gadget->add_content( { type => 'html', include => [qw!./eg/index.html ./eg/index.js!] } );
my $xml = $gadget->render;
print $xml;
