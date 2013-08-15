package EmanGUI::ListItem;

use Moose;
use warnings;
use strict;
use MooseX::Method::Signatures;


has 'description' => (isa => 'Str', is => 'rw', required => 1);
has 'onCursor' => (isa => 'CodeRef', is => 'ro', required => 1);
has 'onEnter' => (isa => 'CodeRef', is => 'ro', required => 1);
has 'hint' => (isa=>'Str', is=>'ro', default=>sub{""});

method real_description() {
    my $res="";
    for  (0..($self->level - 1)) {
        $res.= " | ";
    }
    $res.=$self->description();
}

method toListItems() {
    return ($self);
}

with 'EmanGUI::ListItemGeneral';

__PACKAGE__->meta->make_immutable;

