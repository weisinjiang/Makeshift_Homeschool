import 'package:flutter/material.dart';
import 'package:makeshift_homeschool_app/services/Interest_Provider.dart';
import 'package:makeshift_homeschool_app/services/auth.dart';
import 'package:makeshift_homeschool_app/shared/enums.dart';
import 'package:makeshift_homeschool_app/shared/warning_messages.dart';
import 'package:makeshift_homeschool_app/widgets/InterestChip.dart';
import 'package:provider/provider.dart';

/**
 * Builds the Interest Picker screen
 */

// class InterestPickerScreen extends StatefulWidget {
//   InterestPickerScreen({Key key}) : super(key: key);

//   @override 
//   _InterestPickerScreenState createState() {
//     return _InterestPickerScreenState();
//   }
// }


class InterestPickerScreen extends StatefulWidget {

  final Interest interestType;

  const InterestPickerScreen({Key key, this.interestType}) : super(key: key);

  @override
  _InterestPickerScreenState createState() => _InterestPickerScreenState();
}

class _InterestPickerScreenState extends State<InterestPickerScreen> {

  String userId;

  @override 
  void initState() {
    userId = Provider.of<AuthProvider>(context, listen: false).getUserInfo["uid"];
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
  
    
    return ChangeNotifierProvider<InterestProvider>(
      create: (context) => InterestProvider(widget.interestType, userId),
      child: Consumer<InterestProvider>(  
        builder: (context, interestProvider, _) => Scaffold(

          appBar: AppBar(  
            leading: new Container(), // removes the back button, so user's need to press save
            title: widget.interestType == Interest.CLASSROOMS
            ? Text("Selected Interested Classrooms")
            : Text("Select Your Interests"),
          ),


          body: Container(  
            child: Column(
              children: [
                Center(  
                  child: InterestChip(interestProvider: interestProvider),
                ),
                IconButton(
                  icon: const Icon(Icons.save), 
                  onPressed: () async {
                    if (!interestProvider.selectedAtLeastOne()) {
                      showAlertDialog("Select at least 1 option", "Empty Selection", context);
                    }
                    else {
                      interestProvider.save();
                      Navigator.of(context).pop();
                    }
                  },

                ),
              ],
            ),
          ),


        ),
      ),
    );
   
  }
}