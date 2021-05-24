// keyboardType: TextInputType.multiline,
//   maxLines: null,
//DONE

import 'package:flutter/material.dart';
import 'package:makeshift_homeschool_app/services/auth.dart';
import 'package:makeshift_homeschool_app/services/bootcamp_provider.dart';
import 'package:makeshift_homeschool_app/shared/warning_messages.dart';
import 'package:provider/provider.dart';



class WriteAboutAFamilyVacation extends StatefulWidget {
  @override
  _WriteAboutAFamilyVacationState createState() => _WriteAboutAFamilyVacationState();
}

class _WriteAboutAFamilyVacationState extends State<WriteAboutAFamilyVacation> {
  List<TextEditingController> textController = [
    TextEditingController(), /// controller for "What happened?" index0
    TextEditingController(), /// controller for "How did it start out?" index1
    TextEditingController(), /// controller for "What happened next?" index2
    TextEditingController(), /// controller for "How did it end?" index3
  ];

  Future<void> save(BootCampProvider database, Map<String, dynamic> userData, String activityID, BuildContext context) async {
    String userResponse = 
    """
    The family vacation I'm going to write about is ${textController[0].text}.\n
    First, ${textController[1].text}.\n
    Next, ${textController[2].text}.\n
    Last, ${textController[3].text}.\n
    I hope you enjoyed reading about my family vacation!\n
    """;
    if (database.isBootcampComplete(this.textController)) {
      await database.saveToUserProfile(userData, activityID, userResponse);
      Navigator.of(context).pop();
    } else {
      showAlertDialog("Bootcamp has missing fields", "Not Complete", context);
    }
  
  }

  void dispose() {
    textController.forEach((element) {element.dispose();});
    super.dispose();
  }

    @override
    Widget build(BuildContext context) {
     

      var database = Provider.of<BootCampProvider>(context);
      var user = Provider.of<AuthProvider>(context).getUserInfo;
      final screenSize = MediaQuery.of(context).size; // size of the screen
  
      return Scaffold(
        appBar: AppBar(
          title: Text("Write About A Family Vacation"),
        ),
        body: Container(
          padding: EdgeInsets.all(15),
          height: screenSize.height,
          width: screenSize.width,
          child: Container(
            height: screenSize.height * 0.95,
          
            child: ListView(
                
                children: <Widget>[
  
  
  
                  /// Image on top
                  
                  
                  Image.asset("asset/bootcamp/airplane.gif"),
  
                  SizedBox(height: screenSize.height*0.03,),
                  
                  Text("The family vacation I'm going to write about is..."),
  
  
                  SizedBox(
                    child: TextFormField(
                /// add a controller and attach it to this field
                // keyboardType: TextInputType.multiline,
                //     maxLines: null,
                controller: textController[0],
                decoration: InputDecoration(
                  hintText: "Summary or introduction of your family vacation"
              ),
              ),
                    width: 130,
                  ),
  
                  SizedBox(height: screenSize.height*0.03,),
                  
  
                  Text("First,"),
  
               
  
                  SizedBox(
                    child: TextFormField(
                /// add a controller and attach it to this field
                keyboardType: TextInputType.multiline,
                    maxLines: null,
                controller: textController[1],
                decoration: InputDecoration(
                  hintText: "How did your vacation start out?"
              ),
              ),
                    width: screenSize.width,
                  ),


                  SizedBox(height: screenSize.height*0.03,),
  
                  
                  Text("Next,"),
  
  
                  SizedBox(
                    child: TextFormField(
                /// add a controller and attach it to this field
                keyboardType: TextInputType.multiline,
                    maxLines: null,
                controller: textController[2],
                decoration: InputDecoration(
                  hintText: "What happened next?"
              ),
              ),
                    width: screenSize.width,
                  ),

                  SizedBox(height: screenSize.height*0.03,),
  
                  Text("Last,"),
  
                  SizedBox(
                    child: TextFormField(
                /// add a controller and attach it to this field
                keyboardType: TextInputType.multiline,
                    maxLines: null,
                controller: textController[3],
                decoration: InputDecoration(
                  hintText: "How did your vacation end?"
              ),
              ),
                    width: screenSize.width,
                  ),

                  SizedBox(height: screenSize.height*0.03,),

  
                  Text("I hope you enjoyed reading about my family vacation!"),


                  SizedBox(height: screenSize.height*0.03,),
  
                  

                  RaisedButton(
                    child: Text("Save"),
                    onPressed: () async {
                      await save(database, user,"Write About A Family Vacation", context);
                    }
                  )
  
  
                ],
              ),
          ),
        ),
      );
    }
}
  