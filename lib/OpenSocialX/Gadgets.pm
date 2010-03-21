package OpenSocialX::Gadgets;
use strict;
use warnings;
our $VERSION = '0.01';
use XML::LibXML; #XXX
use File::Slurp qw/read_file/;

sub new {
    my ( $class, %opt ) = @_;
    my $self = bless { title => $opt{title}, modules => [], }, $class;
    $self->_init;
    $self;
}

sub _init {
    my $self = shift;
    my $dom   = XML::LibXML::Document->new( '1.0', 'utf-8' );
    my $module  = $dom->createElement('Module');
    my $prefs = $dom->createElement('ModulePrefs');
    $prefs->setAttribute('title', $self->{title} );
    $module->appendChild( $prefs );
    $dom->setDocumentElement( $module );
    $self->{dom} = $dom;
}

sub add_pref {
    my ( $self, $name, $hash ) = @_;
    my ($pref) = $self->{dom}->getElementsByTagName('ModulePrefs');
    my $elem = $self->{dom}->createElement($name);
    for my $key ( keys %$hash ) {
        for ( @{ $hash->{$key} } ) {
            $elem->setAttribute( $key, $_ );
        }
    }
    $pref->appendChild( $elem );
}

sub add_content {
    my ( $self, $args ) = @_;
    my $type    = $args->{type};                                       #XXX
    my ($module) = $self->{dom}->getElementsByTagName('Module');
    my $content = $self->{dom}->createElement('Content');
    $content->setAttribute( 'type', $type );
    my $text = '';
    for my $file ( @{ $args->{include} } ) {
        if( $file =~ /\.js$/ ){
            $text .= '<script type="text/javascript">' . read_file( $file ) . '</script>';
        }else{
            $text  .= read_file($file);
        }
    }
    my $cdata = XML::LibXML::CDATASection->new($text);
    $content->appendChild($cdata);
    $module->appendChild($content);
}

sub render {
    my $self = shift;
    return $self->{dom}->toString();
}

1;
__END__

=head1 NAME

OpenSocialX::Gadgets - Helper modules for development or OpenSocial

=head1 SYNOPSIS

  use OpenSocialX::Gadgets;

  my $gadget = OpenSocialX::Gadgets->new( title => 'Hello World' );
  $gadget->add_pref( 'require', { feature => 'opensocial-0.8' } );
  $gadget->add_content('index.html');
  $gadget->add_content('index.js');
  my $xml = $gadget->render;

=head1 DESCRIPTION

Now only testing with mixi appli in Japan.

=head1 AUTHOR

Yusuke Wada E<lt>yusuke at kamawada.comE<gt>

=head1 SEE ALSO

=head1 LICENSE

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut
