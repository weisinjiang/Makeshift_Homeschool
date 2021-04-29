import 'dart:math';

import 'package:flutter/material.dart';
import 'package:makeshift_homeschool_app/services/Interest_Provider.dart';
import 'package:makeshift_homeschool_app/shared/RandomColorGen.dart';

/*
  This class takes a Interest Provider and gets a list of interests from the provider.
  Using that list, it constructs a list of Chips for users to select from.
  When users toggle between between chips, this stateful widget will change the state
  of the selected list in the Interest Provider.
*/

class InterestChip extends StatefulWidget {

  final InterestProvider interestProvider;

  InterestChip({this.interestProvider, List<String> interestList}); // Pass in the list to this widget
  
  @override
  _InterestChipState createState() {
    return _InterestChipState();
  }

}

class _InterestChipState extends State<InterestChip> {

  List<String> selected = [];

  // Random number generator to generate random ints from 0-255
  // for each ticker so they have almost unquie colors
  static RandomColorGen randomColor = new RandomColorGen();


  /**
   * For each interest string in the list, create a ChoiceChip with 
   * code telling it what to do when we toggle the chips.
   */
  List<Widget> _buildInterestChips() {
    widget.interestProvider.initializeInterestList();
    
    List<Widget> chips = [];
    List<String> interestList = widget.interestProvider.getInterests;
    Map<String, Color> chipColorMap = widget.interestProvider.getChipColorMap;

    interestList.forEach( (interest) {
      chips.add(
        Container(
          padding: EdgeInsets.all(2.0),
          child: ChoiceChip(  
            label: Text(interest,style: TextStyle(fontWeight: FontWeight.bold),),
            backgroundColor: chipColorMap[interest],
            selected: selected.contains(interest),
            onSelected: (interestSelected) {
              setState(() {
                // Remove or add the selected interest on toggle
                selected.contains(interest) 
                  ? selected.remove(interest)
                  : selected.add(interest);    
                widget.interestProvider.updateSelectedList(selected);
                widget.interestProvider.printTest(); //! Print to check the array
              });
            },
          ),
        )

      );

    });

    return chips;

  }

  @override
  Widget build(BuildContext context) {
    
    return Wrap(  
      children: _buildInterestChips(),
    );
  }

}