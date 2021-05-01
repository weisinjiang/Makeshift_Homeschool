// keyboardType: TextInputType.multiline,
//   maxLines: null,

// DONE!

import 'package:flutter/material.dart';
import 'package:makeshift_homeschool_app/services/auth.dart';
import 'package:makeshift_homeschool_app/services/bootcamp_provider.dart';
import 'package:makeshift_homeschool_app/shared/warning_messages.dart';
import 'package:provider/provider.dart';

class PracticeWinningFriends extends StatefulWidget {
  @override
  _PracticeWinningFriendsState createState() => _PracticeWinningFriendsState();
}

class _PracticeWinningFriendsState extends State<PracticeWinningFriends> {
  List<TextEditingController> textController = [
    TextEditingController(),

    /// controller for "What happened?" index0
    TextEditingController(),

    /// controller for "What happened?" index1
    
    
  ];

  Future<void> save(BootCampProvider database, Map<String, dynamic> userData,
      String activityID, BuildContext context) async {
    String userResponse = """
      I tried a how to win friends strategy on ${textController[0].text} today.\n
      And this is what happened:\n
      ${textController[1].text}\n
    """;
    if (database.isBootcampComplete(this.textController)) {
      await database.saveToUserProfile(userData, activityID, userResponse);
      Navigator.of(context).pop();
    } else {
      showAlertDialog("Bootcamp has missing fields", "Not Complete", context);
    }
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
    var user = Provider.of<AuthProvider>(context).getUserInfo;
    final screenSize = MediaQuery.of(context).size; // size of the screen

    return Scaffold(
      appBar: AppBar(
        title: Text("Practice winning friends"),
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
                "asset/bootcamp/umbrella.gif",
                height: screenSize.height * 0.3,
                width: screenSize.width,
              ),

              Text("Stratagies for winning friends",
                  style: TextStyle(
                    fontSize: 20,
                  )),

              SizedBox(
                height: screenSize.height * 0.03,
              ),

              Text("1. Find out what other people want and help them get it",
                  style: TextStyle(fontSize: 17, color: Colors.purple)),

              SizedBox(
                height: screenSize.height * 0.02,
              ),

              Text("2. Be interested in other people",
                  style: TextStyle(fontSize: 17, color: Colors.green)),

              SizedBox(
                height: screenSize.height * 0.02,
              ),

              Text("3. Smile",
                  style: TextStyle(fontSize: 17, color: Colors.blue)),

              SizedBox(
                height: screenSize.height * 0.02,
              ),

              Text("4. Remember a persons name and use it",
                  style: TextStyle(fontSize: 17, color: Colors.pink)),

              SizedBox(
                height: screenSize.height * 0.02,
              ),

              Text("5. Make the other person feel important",
                  style: TextStyle(fontSize: 17, color: Colors.orangeAccent)),

              SizedBox(
                height: screenSize.height * 0.03,
              ),

              Text("Who are you testing the strategy on?"),

              SizedBox(
                width: 120,
                child: TextFormField(
                  /// add a controller and attach it to this field
                  // keyboardType: TextInputType.multiline,
                  //     maxLines: null,
                  controller: textController[0],
                  decoration: InputDecoration(
                      hintText: "Write their name here"),
                ),
              ),

              SizedBox(
                height: screenSize.height * 0.03,
              ),
              
              
              Text("What happened?"),

              SizedBox(
                width: 120,
                child: TextFormField(
                  /// add a controller and attach it to this field
                  // keyboardType: TextInputType.multiline,
                  //     maxLines: null,
                  controller: textController[1],
                  decoration: InputDecoration(
                      hintText: "Did it go well? Did nothing change?"),
                ),
              ),


              SizedBox(
                height: screenSize.height * 0.03,
              ),

              RaisedButton(
                  child: Text("Save"),
                  onPressed: () async {
                    await save(
                        database, user, "Practice winning friends", context);
                  })
            ],
          ),
        ),
      ),
    );
  }
}
