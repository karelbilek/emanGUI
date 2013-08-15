package EmanGUI::DisplayableItems;

use warnings;
use strict;
use Moose;
use EmanGUI::ListItem;

use MooseX::Method::Signatures;

has 'items' => (isa=>'ArrayRef[EmanGUI::ListItem]', is=>'ro', default => sub { [] });
has 'description' => (isa => 'Str', is => 'ro', required => 1);

method addItem (EmanGUI::ListItem $item) {
    push (@{$self->items}, $item);
}

method items_hints {
    return [map {$_->hint} @{$self->items}];
}
method items_description {
    return [map {$_->real_description} @{$self->items}];
}
method run_onCursor (Int $what) {
    $self->items->[$what]->onCursor->();
}
method run_onEnter (Int $what) {
    $self->items->[$what]->onEnter->();
}

__PACKAGE__->meta->make_immutable;

