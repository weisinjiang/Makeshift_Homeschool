import 'package:flutter/material.dart';
/*
  Dropdown menu with a set of options a user can select from.
  Pass in a Set of strings and a boxhint
*/

class MyDropdownMenu extends StatefulWidget {
  final Set<String> dropdownOptions;
  final String boxHintText;

  const MyDropdownMenu({Key key, this.dropdownOptions, this.boxHintText})
      : super(key: key);
  @override
  _MyDropdownMenuState createState() => _MyDropdownMenuState();
}

class _MyDropdownMenuState extends State<MyDropdownMenu> {
  String optionSelected = "Click me!";
  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(

        decoration: InputDecoration(
          prefixIcon: Icon(Icons.search),
          hintText: widget.boxHintText,
          border: OutlineInputBorder(borderRadius: BorderRadius.vertical()),
        ),
        items: convertSetToDropdownMenuList(widget.dropdownOptions),
        hint: Text(optionSelected), // shows selected ref
        onChanged: (changedDropdownItem) {
          // ref changed, save the value
          setState(() {
            optionSelected = changedDropdownItem;
          });
        });
  }

  /*
    This method maps the passed in Set and changing each String into a 
    DropdownMenuItem Widget. Convert it to a List and return it
  */
  List<DropdownMenuItem> convertSetToDropdownMenuList(
      Set<String> dropdownList) {
    var dropDownItemSet = dropdownList.map((option) => DropdownMenuItem<String>(
          child: Text(option),
          value: option,
        ));

    return dropDownItemSet.toList();
  }
}
