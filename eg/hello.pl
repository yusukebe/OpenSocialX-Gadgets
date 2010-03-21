#!/usr/bin/perl
use OpenSocialX::Gadgets;

my $gadget = OpenSocialX::Gadgets->new(
    title       => 'Hello World',
    description => 'just hello world'
);
$gadget->add_pref( 'Require', { feature => ['opensocial-0.8'] } );
$gadget->add_content(
    {
        type    => 'html',
        view    => 'canvas',
        include => [
            qw!./eg/hello.html ./eg/hello.js!
        ]
    }
);
my $xml = $gadget->render;
print $xml;
