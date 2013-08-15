package EmanGUI::ListItemGeneral;

use Moose::Role;
use warnings;
use strict;


has 'level' => (isa=>'Int', is=>'rw', default=>'0');


requires 'toListItems';

1;
#__PACKAGE__->meta->make_immutable;
