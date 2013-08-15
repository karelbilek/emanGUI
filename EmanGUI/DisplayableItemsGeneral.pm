package EmanGUI::DisplayableItemsGeneral;

use warnings;
use strict;
use Moose;
use EmanGUI::ListItem;
use EmanGUI::ListItemGroup;
use EmanGUI::DisplayableItems;

use MooseX::Method::Signatures;

has 'items' => (isa=>'ArrayRef[EmanGUI::ListItemGeneral]', is=>'ro', default => sub { [] });
has 'description' => (isa => 'Str', is => 'ro', required => 1);
has 'repaint' => (isa=>'CodeRef', is=>'ro', required=>'1');

method toDisplayableItems () {
    #die "Not implemented yet.";
    my @kids;
    for my $kid (@{$self->items}) {
        push (@kids, $kid->toListItems);
    }
    return new EmanGUI::DisplayableItems{items=>\@kids, description=>$self->description};
}

method do_repaint() {
    $self->repaint->($self->toDisplayableItems);
}

method addItemGroup (EmanGUI::ListItemGroup $item) {
    push (@{$self->items}, $item);
    $item->mother($self);
    $item->level(0);
}

__PACKAGE__->meta->make_immutable;

