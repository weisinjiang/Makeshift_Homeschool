
import 'package:flutter/material.dart';
import 'package:makeshift_homeschool_app/services/Interest_Provider.dart';
import 'package:makeshift_homeschool_app/shared/enums.dart';
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


class InterestPickerScreen extends StatelessWidget {

  final Interest interestType;

  const InterestPickerScreen({Key key, this.interestType}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
  return Provider<InterestProvider>(
    create: (context) => InterestProvider(interestType),
    child: Consumer<InterestProvider>(  
      builder: (context, interestProvider, _) => Scaffold(

        appBar: AppBar(  
          title: Text("Select Your Interests"),
        ),


        body: Container(  
          child: Center(  
            child: InterestChip(interestProvider: interestProvider),
          ),
        ),



      ),
    ),
  );



   
  }
  
}