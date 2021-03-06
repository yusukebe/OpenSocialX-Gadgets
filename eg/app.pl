#!/usr/bin/perl
use OpenSocialX::Gadgets;

my $gadget = OpenSocialX::Gadgets->new(
    title       => 'Hello World',
    description => 'just hello world'
);
$gadget->add_pref( 'Require', { feature => ['opensocial-0.8'] } );
$gadget->add_content(
    {
        type     => 'html',
        view     => 'canvas',
        include  => [qw!./eg/app.html ./eg/app.js!],
        external => [
'http://ajax.googleapis.com/ajax/libs/jquery/1.4/jquery.min.js',
        ]
    }
);
my $xml = $gadget->render;
print $xml;
