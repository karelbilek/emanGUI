package EmanGUI::ListItemGroup;

use Moose;
use warnings;
use strict;
use MooseX::Method::Signatures;

has 'description' => (isa => 'Str', is => 'ro', required => 1);
has 'itemsUnder' => (isa=>'ArrayRef[EmanGUI::ListItemGeneral]',is=>'ro', default=>sub{[]});
has 'mother' => (isa=>'EmanGUI::DisplayableItemsGeneral', is=>'rw', required=>'0');
#has 'repaint' => (isa=>'CodeRef', is=>'ro', required=>'1');
has 'is_open' => (isa=>'Bool', is=>'rw', default=>sub{return 0});

method addItem (EmanGUI::ListItem $item) {

    push (@{$self->itemsUnder}, $item);
    $item->level(1+$self->level);
}
method addItemGroup (EmanGUI::ListItemGroup $itemG) {
    if (!$self->mother) {
        die "Mother not set";
    }

    push (@{$self->itemsUnder}, $itemG);
    $itemG->mother($self->mother);
    $itemG->level(1+$self->level);
}

method toListItems() {
    my $description_all=$self->description;
    if ($self->is_open) {
        $description_all="[-] ".$description_all;
    } else {
        $description_all="[+] ".$description_all;
    }

    my $onCursor=sub{};
    my $onEnter=sub{
        $self->is_open(!($self->is_open));
        $self->mother->do_repaint();
        #$self->repaint->($self->mother->toDisplayableItems);
    };
    my $first = new EmanGUI::ListItem{
        description=>$description_all,
        onCursor=>$onCursor,
        onEnter=>$onEnter,
        level=>($self->level)};
    my @resultItems;
    push @resultItems, $first;
    
    if ($self->is_open) {
        for my $kid (@{$self->itemsUnder}) {
            my @items = $kid->toListItems();
            for my $kidItem (@items) {
    #           $kidItem->description(" | ".($kidItem->description));
                push @resultItems, $kidItem;
            }
        }
    }
    return @resultItems;
}

with 'EmanGUI::ListItemGeneral';

__PACKAGE__->meta->make_immutable;

