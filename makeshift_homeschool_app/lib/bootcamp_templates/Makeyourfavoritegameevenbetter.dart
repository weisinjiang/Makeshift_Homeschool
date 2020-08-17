// keyboardType: TextInputType.multiline,
//   maxLines: null,

import 'package:flutter/material.dart';
import 'package:makeshift_homeschool_app/services/auth.dart';
import 'package:makeshift_homeschool_app/services/bootcamp_provider.dart';
import 'package:provider/provider.dart';



class MakeYourFavoriteGameEvenBetter extends StatefulWidget {
  @override
  _MakeYourFavoriteGameEvenBetterState createState() => _MakeYourFavoriteGameEvenBetterState();
}

class _MakeYourFavoriteGameEvenBetterState extends State<MakeYourFavoriteGameEvenBetter> {
  List<TextEditingController> textController = [
    TextEditingController(), /// controller for "What happened?" index0
    TextEditingController(), /// controller for "What happened?" index0
    TextEditingController(), /// controller for "How did it start out?" index1
    TextEditingController(), /// controller for "What happened next?" index2
    TextEditingController(), /// controller for "How did it end?" index3
    TextEditingController(), /// controller for "Why?" index4
    TextEditingController(), /// controller for "Why?" index4
  ];

  Future<void> save(BootCampProvider database, String uid, String activityID, BuildContext context) async {
    String userReponse = 
    """
    Dear creator of ${textController[0].text},\n
    I really enjoy playing ${textController[1].text}.\n
    And I have some ideas on how to make it even better!\n
    1. ${textController[2].text}\n
    2. ${textController[3].text}\n
    3. ${textController[4].text}\n
    4. ${textController[5].text}\n
    5. ${textController[6].text}\n
    Thank you for considering my ideas!
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
     

      var database = Provider.of<BootCampProvider>(context);
      var user = Provider.of<AuthProvider>(context).getUser;
      final screenSize = MediaQuery.of(context).size; // size of the screen
  
      return Scaffold(
        appBar: AppBar(
          title: Text("Make you favorite game even better"),
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
                    "asset/bootcamp/videogame.gif", 
                    height: screenSize.height*0.3,
                    width: screenSize.width,
                    ),
                  
                  Text("Dear creator of "),
  
  
                  Row(
                    children: [
                      SizedBox(
                        width: 120,
                        child: TextFormField(
                          
                /// add a controller and attach it to this field
                // keyboardType: TextInputType.multiline,
                //     maxLines: null,
                controller: textController[0],
                decoration: InputDecoration(
                      hintText: "video game"
              ),
              ),
                        
                      ),

                      Text(","),

                      



                    ],
                  ),

                  SizedBox(height: screenSize.height*0.03,),

                  Row(
                    children: [

                      Text("I really enjoy playing  "),
                      SizedBox(
                        width: 120,
                        child: TextFormField(
                          
                /// add a controller and attach it to this field
                // keyboardType: TextInputType.multiline,
                //     maxLines: null,
                controller: textController[1],
                decoration: InputDecoration(
                      hintText: "video game"
              ),
              ),
                        
                      ),

                      Text("."),

                      



                    ],
                  ),

                  SizedBox(height: screenSize.height*0.03,),

                  Text("And I have some ideas on how to make it even better!"),
  
                  SizedBox(height: screenSize.height*0.03,),
                  


                  Text("1."),
  
               
  
                  SizedBox(
                    child: TextFormField(
                /// add a controller and attach it to this field
                keyboardType: TextInputType.multiline,
                    maxLines: null,
                controller: textController[2],
                decoration: InputDecoration(
                  hintText: "Suggestion One"
              ),
              ),
                    width: screenSize.width,
                  ),


                  SizedBox(height: screenSize.height*0.03,),
  
                  
                  Text("2."),
  
  
                  SizedBox(
                    child: TextFormField(
                /// add a controller and attach it to this field
                keyboardType: TextInputType.multiline,
                    maxLines: null,
                controller: textController[3],
                decoration: InputDecoration(
                  hintText: "Suggestion Two"
              ),
              ),
                    width: screenSize.width,
                  ),

                  SizedBox(height: screenSize.height*0.03,),
  
                  Text("3."),
  
                  SizedBox(
                    child: TextFormField(
                /// add a controller and attach it to this field
                keyboardType: TextInputType.multiline,
                    maxLines: null,
                controller: textController[4],
                decoration: InputDecoration(
                  hintText: "Suggestion Three"
              ),
              ),
                    width: screenSize.width,
                  ),

                  SizedBox(height: screenSize.height*0.03,),

  
                  Text("4. "),
  
                  SizedBox(width: 300,),
  
                  SizedBox(
                    child: TextFormField(
                /// add a controller and attach it to this field
                keyboardType: TextInputType.multiline,
                    maxLines: null,
                controller: textController[5],
                decoration: InputDecoration(
                  hintText: "Suggestion Four"
              ),
              ),
                    width: screenSize.width,
                  ),

                  SizedBox(height: screenSize.height*0.03,),

                  Text("5. "),
  
                  SizedBox(width: 300,),
  
                  SizedBox(
                    child: TextFormField(
                /// add a controller and attach it to this field
                keyboardType: TextInputType.multiline,
                    maxLines: null,
                controller: textController[6],
                decoration: InputDecoration(
                  hintText: "Suggestion Five"
              ),
              ),
                    width: screenSize.width,
                  ),


                  SizedBox(height: screenSize.height*0.03,),

  
  
                  Text("Thank you for considering my ideas!"),

                  SizedBox(height: screenSize.height*0.03,),

                  RaisedButton(
                    child: Text("Save"),
                    onPressed: () async {
                      await save(database, user["uid"],"Make your favorite game even better", context);
                    }
                  )
  
  
                ],
              ),
          ),
        ),
      );
    }
}
  