// keyboardType: TextInputType.multiline,
//   maxLines: null,
//DONE

import 'package:flutter/material.dart';
import 'package:makeshift_homeschool_app/services/auth.dart';
import 'package:makeshift_homeschool_app/services/bootcamp_database.dart';
import 'package:provider/provider.dart';



class WriteAboutYourFavoriteMemory extends StatefulWidget {
  @override
  _WriteAboutYourFavoriteMemoryState createState() => _WriteAboutYourFavoriteMemoryState();
}

class _WriteAboutYourFavoriteMemoryState extends State<WriteAboutYourFavoriteMemory> {
  List<TextEditingController> textController = [
    TextEditingController(), /// controller for "What happened?" index0
    TextEditingController(), /// controller for "How did it start out?" index1
    TextEditingController(), /// controller for "What happened next?" index2
    TextEditingController(), /// controller for "How did it end?" index3
    TextEditingController(), /// controller for "Why?" index4
  ];

  Future<void> save(BootCampDatabase database, String uid, String activityID, BuildContext context) async {
    String userReponse = 
    """
    I remember this time when ${textController[0].text}!\n
    First, ${textController[1].text}.\n
    Next, ${textController[2].text}.\n
    Last, ${textController[3].text}.\n
    This is my favorite memory because ${textController[4].text}.\n
    Thank you for reading about my favorite memory!\n
    """;
    textController.forEach((controller) { 
      //userReponse.add(controller.text);
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
          title: Text("Write About Your Favorite Memory"),
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
                  
                  
                  Image.asset("asset/bootcamp/beach.gif"),
  
                  SizedBox(height: screenSize.height*0.03,),
                  
                  Text("I remember this time when "),
  
  
                  SizedBox(
                    child: TextFormField(
                /// add a controller and attach it to this field
                // keyboardType: TextInputType.multiline,
                //     maxLines: null,
                controller: textController[0],
                decoration: InputDecoration(
                  hintText: "What happened?"
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
                  hintText: "How did it start out?"
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
                  hintText: "How did it end?"
              ),
              ),
                    width: screenSize.width,
                  ),

                  SizedBox(height: screenSize.height*0.03,),

  
                  Text("This is my favorite memory because..."),
  
                  SizedBox(width: 300,),
  
                  SizedBox(
                    child: TextFormField(
                /// add a controller and attach it to this field
                keyboardType: TextInputType.multiline,
                    maxLines: null,
                controller: textController[4],
                decoration: InputDecoration(
                  hintText: "Why?"
              ),
              ),
                    width: screenSize.width,
                  ),


                  SizedBox(height: screenSize.height*0.03,),

  
  
                  Text("Thank you for reading about my favorite memory!"),

                  RaisedButton(
                    child: Text("Save"),
                    onPressed: () async {
                      await save(database, user["uid"],"Write About Your Favorite Memory", context);
                    }
                  )
  
  
                ],
              ),
          ),
        ),
      );
    }
}
  