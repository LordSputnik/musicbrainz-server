package MusicBrainz::Server::Form::Url::Edit;

use strict;
use warnings;

use base 'MusicBrainz::Server::Form::EditForm';

sub profile
{
    return {
        required => {
            url  => '+MusicBrainz::Server::Form::Field::URL',
        },
        optional => {
            description => 'TextArea',
            edit_note   => 'TextArea',
        },
    };
}

sub mod_type { ModDefs::MOD_EDIT_URL }

sub build_options
{
    my ($self) = @_;

    my $url  = $self->item;
    my $user = $self->context->user;

    return {
        urlobj => $url,
        url    => $self->value('url'),
        desc   => $self->value('description'),
    };
}

1;
