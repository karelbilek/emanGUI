sub complicated_items {
    my $listItems = new EmanGUI::DisplayableItemsGeneral{description=>'Stupid lists.', repaint=>\&display_items};
    for my $i(1..10) {
        my $groupItem = new EmanGUI::ListItemGroup(description=>"sto $i");
        $listItems->addItemGroup($groupItem);
        for my $j(1..10) {
            my $groupItem2 = new EmanGUI::ListItemGroup(description=>"dec ".($i*10+$j));
            $groupItem->addItemGroup($groupItem2);
            
            for my $k(1..10) {
                my $celkem = $i*100+$j*10+$k;
                $groupItem2->addItem(new EmanGUI::ListItem {
                    description=>$celkem,
                    onCursor=>sub{$textviewer->{-text}="Vybran je $celkem";
                                    $textviewer->draw},
                    onEnter=>sub {$cui->dialog(-message=>"Smackl si $celkem.")}
                }); 
            }
        }
    }
    return $listItems->toDisplayableItems();

}

sub basic_items {
    my $listItems = new EmanGUI::DisplayableItems{description=>'Stupid lists.'};
    for my $i (1..200) {
       $listItems->addItem(new EmanGUI::ListItem {
           description=>$i,
           onCursor=>sub{$textviewer->{-text}="Vybran je $i";
                         $textviewer->draw},
           onEnter=>sub {$cui->dialog(-message=>"Smackl si $i.")}
       }); 
    }
    return $listItems;
}
