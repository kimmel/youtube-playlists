#!/usr/bin/env perl

use v5.16;
use warnings;
use autodie qw( :all );
use utf8::all;
use WebService::GData::YouTube;
use URI::URL;

sub main {
    my $playlist_id = $ARGV[0];
    my $yt          = WebService::GData::YouTube->new();

    while ( my $videos = $yt->get_user_playlist_by_id($playlist_id) ) {

        foreach my $video ( @{$videos} ) {

            if ( !exists( $video->content->[0]->{'duration'} ) ) {
                say $video->position();
                next;
            }

            my $uri = URI::URL->new( $video->content->[0]->{'url'} );
            say $video->position() . q( ) . $uri->host . $uri->path;
        }
    }

    exit;
}

main() unless caller;

1;
