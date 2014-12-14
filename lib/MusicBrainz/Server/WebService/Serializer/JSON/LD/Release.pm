package MusicBrainz::Server::WebService::Serializer::JSON::LD::Release;
use Moose;
use MusicBrainz::Server::WebService::Serializer::JSON::LD::Utils qw( serialize_entity list_or_single artwork );
use List::AllUtils qw( uniq );
use List::UtilsBy qw( uniq_by );

extends 'MusicBrainz::Server::WebService::Serializer::JSON::LD';
with 'MusicBrainz::Server::WebService::Serializer::JSON::LD::Role::GID';
with 'MusicBrainz::Server::WebService::Serializer::JSON::LD::Role::Name';
with 'MusicBrainz::Server::WebService::Serializer::JSON::LD::Role::Length';

around serialize => sub {
    my ($orig, $self, $entity, $inc, $stash, $toplevel) = @_;
    my $ret = $self->$orig($entity, $inc, $stash, $toplevel);

    $ret->{'@type'} = 'MusicRelease';

    $ret->{releaseOf} = serialize_entity($entity->release_group, $inc, $stash);

    if ($toplevel) {
        if ($entity->all_events) {
            $ret->{hasReleaseRegion} = [
                map { release_event($_, $inc, $stash) } $entity->all_events
            ];
        }
        if ($entity->all_labels) {
            my @catalog_numbers = uniq grep { defined } map { $_->catalog_number } $entity->all_labels;
            if (@catalog_numbers) {
                $ret->{catalogNumber} = list_or_single(@catalog_numbers);
            }
            my @labels = map { serialize_entity($_, $inc, $stash) } uniq_by { $_->gid } grep { defined } map { $_->label } $entity->all_labels;
            if (@labels) {
                $ret->{recordLabel} = list_or_single(@labels);
            }
        }
        my @medium_formats = uniq map { medium_format($_->format) } grep { defined $_->format } $entity->all_mediums;
        if (@medium_formats) {
            $ret->{hasReleaseFormat} = list_or_single(@medium_formats);
        }

        if ($stash->store($entity)->{cover_art}) {
            $ret->{image} = list_or_single(map { artwork($_) } @{ $stash->store($entity)->{cover_art} });
        }

        # XXX: updating for split pages?
        if ($entity->all_mediums &&
            ($entity->all_mediums)[0]->all_tracks &&
            (($entity->all_mediums)[0]->all_tracks)[0]->recording) {
            my @tracks;
            for my $medium ($entity->all_mediums) {
                for my $track ($medium->all_tracks) {
                    $stash->store($track->recording)->{trackNumber} = $track->number;
                    push(@tracks, serialize_entity($track->recording, $inc, $stash));
                }
            }
            $ret->{track} = \@tracks;
        }

        $ret->{gtin14} = $entity->barcode->code if $entity->barcode;

        $ret->{creditedTo} = $entity->artist_credit->name if $entity->artist_credit;
    }

    return $ret;
};

sub release_event {
    my ($event, $inc, $stash) = @_;
    my $ret = {'@type' => 'CreativeWorkReleaseRegion'};
    if ($event->date) {
        $ret->{releaseDate} = $event->date->format;
    }
    if ($event->country) {
        $ret->{releaseCountry} = serialize_entity($event->country, $inc, $stash)
    }
    return $ret;
}

sub medium_format {
    my ($format) = @_;
    my %map = (
        1 => 'CD',
        2 => 'DVD',
        5 => 'LaserDisc',
        7 => 'Vinyl',
        8 => 'Cassette',
        12 => 'Digital'
    );
    # NOTE: this does not deal with multiple steps in the tree, which as of
    # this writing only applies to 8cm CD+G. It also outputs nothing in the
    # case of it not being one of these few formats. I'm not sure of the
    # best mitigation for either problem.
    my $name;
    if ($name = $map{$format->id}) {
        return "http://schema.org/${name}Format";
    } elsif ($name = $map{$format->parent ? $format->parent->id : $format->parent_id}) {
        return "http://schema.org/${name}Format";
    }
}

__PACKAGE__->meta->make_immutable;
no Moose;
1;

=head1 COPYRIGHT

Copyright (C) 2014 MetaBrainz Foundation

This program is free software; you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation; either version 2 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program; if not, write to the Free Software
Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.

=cut
