// keyboardType: TextInputType.multiline,
//   maxLines: null,

import 'package:flutter/material.dart';
import 'package:makeshift_homeschool_app/services/auth.dart';
import 'package:makeshift_homeschool_app/services/bootcamp_database.dart';
import 'package:provider/provider.dart';



class Differentwaystomove extends StatefulWidget {
  @override
  _DifferentwaystomoveState createState() => _DifferentwaystomoveState();
}

class _DifferentwaystomoveState extends State<Differentwaystomove> {
  List<TextEditingController> textController = [
    TextEditingController(), /// controller for "What happened?" index0
    TextEditingController(), /// controller for "How did it start out?" index1
    TextEditingController(), /// controller for "What happened next?" index2
  ];

  Future<void> save(BootCampDatabase database, String uid, String activityID, BuildContext context) async {
    List<String> userReponse = [];
    textController.forEach((controller) { 
      userReponse.add(controller.text);
    });
    await database.saveToUserProfile(uid, activityID, userReponse);

    
    Navigator.of(context).pop();
  
  }

  void dispose() {
    textController.forEach((element) {element.dispose();});
    super.dispose();
  }

    @override
    Widget build(BuildContext context) {
     

      var database = Provider.of<BootCampDatabase>(context);
      var user = Provider.of<AuthProvider>(context).getUser;
      final screenSize = MediaQuery.of(context).size; // size of the screen
  
      return Scaffold(
        appBar: AppBar(
          title: Text("Write about a different way to move"),
        ),
        body: Container(
          color: Colors.white,
          padding: EdgeInsets.all(15),
          height: screenSize.height,
          width: screenSize.width,
          child: Container(
            height: screenSize.height * 0.95,
            color: Colors.white,
          
            child: ListView(
                
                children: <Widget>[
  
  
  
                  /// Image on top
                  
                  
                  Image.asset("asset/bootcamp/walking.gif"),
  
                  SizedBox(height: screenSize.height*0.001,),
                  
                  Text("The name of my new way of walking is..."),
  
  
                  SizedBox(
                    child: TextFormField(
                /// add a controller and attach it to this field
                // keyboardType: TextInputType.multiline,
                //     maxLines: null,
                controller: textController[0],
                decoration: InputDecoration(
                  hintText: "Name"
              ),
              ),
                    width: 130,
                  ),
  
                  SizedBox(height: screenSize.height*0.03,),
                  
  
                  Text("Here's how do my new way of walking:"),
  
               
  
                  SizedBox(
                    child: TextFormField(
                /// add a controller and attach it to this field
                keyboardType: TextInputType.multiline,
                    maxLines: null,
                controller: textController[1],
                decoration: InputDecoration(
                  hintText: "Explain how to do your new way of walking"
              ),
              ),
                    width: screenSize.width,
                  ),


                  SizedBox(height: screenSize.height*0.03,),
  
                  
                  Text("I think that my new way of movment is better than walking because"),

                  
  
  
                  SizedBox(
                    child: TextFormField(
                /// add a controller and attach it to this field
                keyboardType: TextInputType.multiline,
                    maxLines: null,
                controller: textController[2],
                decoration: InputDecoration(
                  hintText: "Explain why..."
              ),
              ),
                    width: screenSize.width,
                  ),

                  


                  SizedBox(height: screenSize.height*0.03,),

  
  
                  Text("I hope you consider my new way of walking!"),

                  SizedBox(height: screenSize.height*0.03,),

                  RaisedButton(
                    child: Text("Save"),
                    onPressed: () async {
                      await save(database, user["uid"],"Different ways to move", context);
                    }
                  )
  
  
                ],
              ),
          ),
        ),
      );
    }
}
  