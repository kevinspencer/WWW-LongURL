package WWW::LongURL;

use JSON::Any;
use LWP::UserAgent;
use strict;
use warnings;
use base qw(Class::Accessor::Fast);

__PACKAGE__->mk_accessors(qw(apibase useragent format error));

our $VERSION = '0.03';

sub new {
    my $class = shift;

    my $self = {};
    bless $self, $class;
    $self->apibase('http://api.longurl.org/v2/');
    $self->format('json');
    $self->useragent('WWW-LongURL/0.03');
    return $self;
}

sub expand {
    my ($self, $url) = @_;

    my $ua = LWP::UserAgent->new();
    $ua->agent($self->useragent());

    my $api = $self->apibase() . 'expand?url=' . $url . '&format=' . $self->format();
    
    my $response = $ua->get($api);
    if ($response->is_success()) {
        my $obj = JSON::Any->jsonToObj($response->decoded_content());
        if ($obj->{'long-url'}) {
            return $obj->{'long-url'};
        } else {
            $self->error("Unrecognized response from " . $self->apibase());
            return;
        }
    } else {
        $self->error($response->status_line());
        return;
    }
}

1;

__END__

=head1 NAME

WWW::LongURL - Perl interface to the LongURL API.

=head1 SYNOPSIS

  use WWW::LongURL;

  my $longurl = WWW::LongURL->new();

  my $expanded_url = $longurl->expand('http://bit.ly/cZcYFn');
  if (! $expanded_url) {
     die $longurl->error(), "\n";
  }

=head1 DESCRIPTION

A simple interface for using the LongURL API to expand shortened URLs.

You can expand a bit.ly URL like so:

  my $url = $longurl->expand($some_bitly_url);

=head2 METHODS

=over 4

=item C<new>

Constructor

=item C<expand($url)>

On success, will return the expanded URL from LongURL.  On failure, returns undef.

=item C<error>

Returns the last error message.

=back

=head1 SUPPORTED SHORTENING SERVICES

LongURL will expand the URL from over 200 supported shortening services.

See L<http://longurl.org/services>

=head1 REPOSITORY

Development is on-going at:
https://github.com/kevinspencer/WWW-LongURL

=head1 AUTHOR

Kevin Spencer, kspencer@cpan.org

=head1 COPYRIGHT

Copyright (c) 2011.  Kevin Spencer

This program is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.

See http://www.perl.com/perl/misc/Artistic.html

=head1 SEE ALSO

L<http://longurl.org/>,
L<http://longurl.org/api/>

=cut
