// DONE!

import 'package:flutter/material.dart';
import 'package:makeshift_homeschool_app/services/auth.dart';
import 'package:makeshift_homeschool_app/services/bootcamp_provider.dart';
import 'package:provider/provider.dart';

class DifferentWaysToMove extends StatefulWidget {
  @override
  _DifferentWaysToMoveState createState() => _DifferentWaysToMoveState();
}

class _DifferentWaysToMoveState extends State<DifferentWaysToMove> {
  List<TextEditingController> textController = [
    TextEditingController(),

    /// controller for "Name" index0
    TextEditingController(),

    /// controller for "Explain how to do your new way of walking" index1
    TextEditingController(),

    /// controller for "Explain why..." index2
  ];

  Future<void> save(BootCampProvider database, String uid, String activityID,
      BuildContext context) async {
    

    
    String userResponse = 
    """ 
    The name of my new way of walking is ${textController[0].text}.\n
    Here's how do my new way of walking: ${textController[1].text}.\n
    I think that my new way of movement is better than walking because ${textController[2].text}. \n
    I hope you consider my new way of walking! \n

    """;   /// Entire lesson has a string



    await database.saveToUserProfile(uid, activityID, userResponse);

    Navigator.of(context).pop();
  }

  void dispose() {
    textController.forEach((element) {
      element.dispose();
    });
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var database = Provider.of<BootCampProvider>(context);
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

              SizedBox(
                height: screenSize.height * 0.001,
              ),

              Text("The name of my new way of walking is..."),

              SizedBox(
                child: TextFormField(
                  /// add a controller and attach it to this field
                  // keyboardType: TextInputType.multiline,
                  //     maxLines: null,
                  controller: textController[0],
                  decoration: InputDecoration(hintText: "Name"),
                ),
                width: 130,
              ),

              SizedBox(
                height: screenSize.height * 0.03,
              ),

              Text("Here's how do my new way of walking:"),

              SizedBox(
                child: TextFormField(
                  /// add a controller and attach it to this field
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  controller: textController[1],
                  decoration: InputDecoration(
                      hintText: "Explain how to do your new way of walking"),
                ),
                width: screenSize.width,
              ),

              SizedBox(
                height: screenSize.height * 0.03,
              ),

              Text(
                  "I think that my new way of movement is better than walking because"),

              SizedBox(
                child: TextFormField(
                  /// add a controller and attach it to this field
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  controller: textController[2],
                  decoration: InputDecoration(hintText: "Explain why..."),
                ),
                width: screenSize.width,
              ),

              SizedBox(
                height: screenSize.height * 0.03,
              ),

              Text("I hope you consider my new way of walking!"),

              SizedBox(
                height: screenSize.height * 0.03,
              ),

              RaisedButton(
                  child: Text("Save"),
                  onPressed: () async {
                    await save(database, user["uid"], "Different ways to move",
                        context);
                  })
            ],
          ),
        ),
      ),
    );
  }
}
