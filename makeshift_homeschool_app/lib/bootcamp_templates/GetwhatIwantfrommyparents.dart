// keyboardType: TextInputType.multiline,
//   maxLines: null,

import 'package:flutter/material.dart';
import 'package:makeshift_homeschool_app/services/auth.dart';
import 'package:makeshift_homeschool_app/services/bootcamp_database.dart';
import 'package:provider/provider.dart';



class GetWhatIWantFromMyParents extends StatefulWidget {
  @override
  _GetWhatIWantFromMyParentsState createState() => _GetWhatIWantFromMyParentsState();
}

class _GetWhatIWantFromMyParentsState extends State<GetWhatIWantFromMyParents> {
  List<TextEditingController> textController = [
    TextEditingController(), /// controller for "What happened?" index0
    TextEditingController(), /// controller for "What happened?" index0
    TextEditingController(), /// controller for "How did it start out?" index1
    TextEditingController(), /// controller for "What happened next?" index2
    TextEditingController(), /// controller for "How did it end?" index3
    TextEditingController(), /// controller for "Why?" index4
    TextEditingController(), /// controller for "Why?" index5
    TextEditingController(), /// controller for "Why?" index6
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
          title: Text("Get What I Want From My Parents"),
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
                    "asset/bootcamp/please.gif", 
                    height: screenSize.height*0.3,
                    width: screenSize.width,
                    ),
                  
                  Text("Dear "),
  
  
                  Row(
                    children: [
                      SizedBox(
                        width: screenSize.width*0.9,
                        child: TextFormField(
                          
                /// add a controller and attach it to this field
                // keyboardType: TextInputType.multiline,
                //     maxLines: null,
                controller: textController[0],
                decoration: InputDecoration(
                      hintText: "parent or gaurdian"
              ),
              ),
                        
                      ),

                      Text(","),

                      



                    ],
                  ),

                  SizedBox(height: screenSize.height*0.03,),

                  Text("First, I wanna say, you're great parents."),

                  SizedBox(height: screenSize.height*0.03,),

                  Row(
                    children: [

                      Text("But, I've been wanting  "),
                      SizedBox(
                        width: 120,
                        child: TextFormField(
                          
                /// add a controller and attach it to this field
                // keyboardType: TextInputType.multiline,
                //     maxLines: null,
                controller: textController[1],
                decoration: InputDecoration(
                      hintText: "what you want"
              ),
              ),
                        
                      ),

                      

                      



                    ],
                  ),

                  Text("for a pretty long time."),

                  SizedBox(height: screenSize.height*0.03,),

                  Text("Here are some things I've done that you might not have noticed:"),
  
                  SizedBox(height: screenSize.height*0.03,),
                  


                  Text("1."),
  
               
  
                  SizedBox(
                    child: TextFormField(
                /// add a controller and attach it to this field
                keyboardType: TextInputType.multiline,
                    maxLines: null,
                controller: textController[2],
                decoration: InputDecoration(
                  hintText: "Something You've Done, One"
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
                  hintText: "Something You've Done, Two"
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
                  hintText: "Something You've Done, Three"
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
                  hintText: "Something You've Done, Four"
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
                  hintText: "Something You've Done, Five"
              ),
              ),
                    width: screenSize.width,
                  ),


                  SizedBox(height: screenSize.height*0.03,),

                  Text("I believe this is proof that I should get"),

                  SizedBox(
                        width: 120,
                        child: TextFormField(
                          
                /// add a controller and attach it to this field
                // keyboardType: TextInputType.multiline,
                //     maxLines: null,
                controller: textController[7],
                decoration: InputDecoration(
                      hintText: "what you want"
              ),
              ),
                        
                      ),

                      SizedBox(height: screenSize.height*0.03,),

  
  
                  Text("Thank you for considering my wants!"),

                  SizedBox(height: screenSize.height*0.03,),

                  RaisedButton(
                    child: Text("Save"),
                    onPressed: () async {
                      await save(database, user["uid"],"Get what I want from my parents", context);
                    }
                  )
  
  
                ],
              ),
          ),
        ),
      );
    }
}
  