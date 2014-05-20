package Email::MIME::Kit::Renderer::Xslate;

use Moose;
with 'Email::MIME::Kit::Role::Renderer';

# ABSTRACT: render parts of your mail with Text::Xslate

use Text::Xslate;

sub render {
   my ($self, $tpl, $stash) = @_;

   \($self->_render_tx($$tpl, $stash||{}))
}

has options => (
   is      => 'ro',
   default => sub { {} },
);

has _tx => (
   is       => 'ro',
   lazy     => 1,
   init_arg => undef,
   default  => sub { Text::Xslate->new(shift->options) },
   handles => {
      _render_tx => 'render_string',
   },
);

1;

__END__

=pod

=head1 DESCRIPTION

This is a renderer plugin for L<Email::MIME::Kit>, and renders message parts
using L<Text::Xslate>.  When specifying a renderer in F<manifest.json>, you
might write something like this:

  { ..., "renderer": "Xslate" }

Or, to supply options:

  {
    ...,
    "renderer": [
      "Xslate", {
         "options": {
            "syntax": "Kolon"
            // etc etc
         }
      }
    ]
  }

All options are passed verbatim to C<< Text::Xslate->new >>.

For plaintext emails a good default is

    "renderer": [
      "Xslate", {
         "options": { "type":"text" }
      }
    ]

=cut
