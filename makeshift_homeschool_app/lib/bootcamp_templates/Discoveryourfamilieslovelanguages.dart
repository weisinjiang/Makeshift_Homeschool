// keyboardType: TextInputType.multiline,
//   maxLines: null,

// DONE!

import 'package:flutter/material.dart';
import 'package:makeshift_homeschool_app/services/auth.dart';
import 'package:makeshift_homeschool_app/services/bootcamp_database.dart';
import 'package:provider/provider.dart';



class DiscoverYourFamiliesLoveLanguages extends StatefulWidget {
  @override
  _DiscoverYourFamiliesLoveLanguagesState createState() => _DiscoverYourFamiliesLoveLanguagesState();
}

class _DiscoverYourFamiliesLoveLanguagesState extends State<DiscoverYourFamiliesLoveLanguages> {
  List<TextEditingController> textController = [
    TextEditingController(), /// controller for "What happened?" index0
    
  ];

  Future<void> save(BootCampDatabase database, String uid, String activityID, BuildContext context) async {
    String userResponse = 
      """What is one of your family members love languages?\n
      "${textController[0].text}"\n
    """;
    textController.forEach((controller) { 
      // userReponse.add(controller.text);
    });
    await database.saveToUserProfile(uid, activityID, userResponse);

    
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
          title: Text("Discover Your Families Love Languages"),
        ),
        body: Container(
          color: Colors.white,
          padding: EdgeInsets.all(15),
          height: screenSize.height,
          width: screenSize.width,
          child: Container(
            color: Colors.white,
            height: screenSize.height * 0.95,
          
            child: ListView(
                
                children: <Widget>[
  
  
  
                  /// Image on top
                  
                  
                  Image.asset(
                    "asset/bootcamp/heart.gif", 
                    height: screenSize.height*0.3,
                    width: screenSize.width,
                    ),

                  

                  Row(
            children: [
              SizedBox(width: 20,),
              Text("Love languages", style: TextStyle(fontSize: 20, )),
              
              
            ],
          ),

          SizedBox(height: screenSize.height*0.03,),

          
          Row(
            children: [
              SizedBox(width: 20,),
              Text("1. Words of Affermation", style: TextStyle(fontSize: 17, color: Colors.purple)),
              
              
            ],
          ),

          Row(
            children: [
              SizedBox(width: 20,),
              Text("You like it when people compliment you with words", style: TextStyle(fontSize: 14, color: Colors.purple[200])),
              
              
            ],
          ),

          SizedBox(height: screenSize.height*0.02,),



          Row(
            children: [
              SizedBox(width: 20,),
              Text("2. Gifts", style: TextStyle(fontSize: 17, color: Colors.green)),
              
              
            ],
          ),

          Row(
            children: [
              SizedBox(width: 20,),
              Text("You like it when people give you gifts", style: TextStyle(fontSize: 14, color: Colors.green[200])),
              
              
            ],
          ),

          SizedBox(height: screenSize.height*0.02,),

          Row(
            children: [
              SizedBox(width: 20,),
              Text("3. Acts of service", style: TextStyle(fontSize: 17, color: Colors.blue)),
              
              
            ],
          ),

          Row(
            children: [
              SizedBox(width: 20,),
              Text("You like it when people do helpful things", style: TextStyle(fontSize: 14, color: Colors.blue[200])),
              
              
            ],
          ),

          SizedBox(height: screenSize.height*0.02,),

          Row(
            children: [
              SizedBox(width: 20,),
              Text("4. Quality Time", style: TextStyle(fontSize: 17, color: Colors.pink)),
              
              
            ],
          ),

          Row(
            children: [
              SizedBox(width: 20,),
              Text("You love spending quality time with people", style: TextStyle(fontSize: 14, color: Colors.pink[200])),
              
              
            ],
          ),

          SizedBox(height: screenSize.height*0.02,),

          Row(
            children: [
              SizedBox(width: 20,),
              Text("5. Hugs and Kisses", style: TextStyle(fontSize: 17, color: Colors.orangeAccent)),
              
              
            ],
          ),

          Row(
            children: [
              SizedBox(width: 20,),
              Text("You like hugs and kisses from friends and family", style: TextStyle(fontSize: 14, color: Colors.orange[200])),
              
              
            ],
          ),

          SizedBox(height: screenSize.height*0.03,),
                  
                  Text("What is one of your family members love languages?"),
  
  
                  SizedBox(
                    width: 120,
                    child: TextFormField(
                      
                /// add a controller and attach it to this field
                // keyboardType: TextInputType.multiline,
                //     maxLines: null,
                controller: textController[0],
                decoration: InputDecoration(
                  hintText: "What is it? Will you treat them a bit differently?"
              ),
              ),
                    
                  ),

                  

                  


                  SizedBox(height: screenSize.height*0.03,),

  
  
 



                  RaisedButton(
                    child: Text("Save"),
                    onPressed: () async {
                      await save(database, user["uid"],"Discover Your Families Love Languages", context);
                    }
                  )
  
  
                ],
              ),
          ),
        ),
      );
    }
}
  