// keyboardType: TextInputType.multiline,
//   maxLines: null,

//DONE!

import 'package:flutter/material.dart';
import 'package:makeshift_homeschool_app/services/auth.dart';
import 'package:makeshift_homeschool_app/services/bootcamp_provider.dart';
import 'package:makeshift_homeschool_app/shared/warning_messages.dart';
import 'package:provider/provider.dart';

class Talkaboutyourfavoriteactivity extends StatefulWidget {
  @override
  _TalkaboutyourfavoriteactivityState createState() =>
      _TalkaboutyourfavoriteactivityState();
}

class _TalkaboutyourfavoriteactivityState
    extends State<Talkaboutyourfavoriteactivity> {
  List<TextEditingController> textController = [
    TextEditingController(),

    /// controller for "What happened?" index0
    TextEditingController(),

    /// controller for "What happened?" index1
    TextEditingController(),

    /// controller for "How did it start out?" index2
    TextEditingController(),

    /// controller for "What happened next?" index3
    TextEditingController(),

    /// controller for "How did it end?" index4
    TextEditingController(),

  

  ];

  Future<void> save(BootCampProvider database, Map<String, dynamic> userData,
      String activityID, BuildContext context) async {
    String userResponse = """
    My favorite activity is ${textController[0].text}\n
    Some things that I like about this activity are
    ${textController[1].text} and ${textController[2].text}
    I recommend this activity because
    ${textController[3].text}.\n
    Although I really like ${textController[0].text}, There are some things that I don't like, including
    ${textController[4].text} and ${textController[5].text}
   
    
    
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
    var user = Provider.of<AuthProvider>(context).getUser;
    final screenSize = MediaQuery.of(context).size; // size of the screen

    return Scaffold(
      appBar: AppBar(
        title: Text("Talk about your favorite activity"),
      ),
      body: Container(
        color: Colors.white,
        padding: EdgeInsets.all(15),
        height: screenSize.height,
        width: screenSize.width,
        child: Container(
          color: Colors.white,
          child: ListView(children: <Widget>[
            /// Image on top

            Image.asset(
              "asset/bootcamp/activity.png",
              width: screenSize.width,
              height: screenSize.height * 0.3,
            ),
            Text("My favorite activity is "),
            SizedBox(
              width: 120,
              child: Row(
                children: [
                  SizedBox(
                    width: 120,
                    child: TextFormField(
                      /// add a controller and attach it to this field
                      // keyboardType: TextInputType.multiline,
                      //     maxLines: null,
                      controller: textController[0],
                      decoration: InputDecoration(
                        hintText: "Activity",
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: screenSize.height * 0.03,
            ),
            Text("Some things I like about this activity are  "),
            SizedBox(
              width: 120,
              child: Row(
                children: [
                  SizedBox(
                    width: 200,
                    child: TextFormField(
                      /// add a controller and attach it to this field
                      // keyboardType: TextInputType.multiline,
                      // maxLines: null,
                      controller: textController[1],
                      decoration:
                          InputDecoration(hintText: "What you like about it,1"),
                    ),
                  ),
                ],
              ),
            ),
            Text("And another thing I like is "),
            SizedBox(
              width: 200,
              child: Row(
                children: [
                  SizedBox(
                    width: 200,
                    child: TextFormField(
                      /// add a controller and attach it to this field
                      // keyboardType: TextInputType.multiline,
                      // maxLines: null,
                      controller: textController[2],
                      decoration:
                          InputDecoration(hintText: "What you like about it,2"),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: 200,
              child: Row(children: [
                Text("I recommend this activity because  "),
                SizedBox( width: 120,
                  child: TextFormField(
                    /// add a controller and attach it to this field
                    // keyboardType: TextInputType.multiline,
                    // maxLines: null,
                    controller: textController[3],
                  ),
                ),
              ]),
            ),
            SizedBox(height: screenSize.height * 0.03, width: 120),

            SizedBox(
              width: 200,
              child: Row(children: [
                Text("Although I really like  "),
                SizedBox(
                  width: 200,
                  child: TextFormField(
                    /// add a controller and attach it to this field
                    // keyboardType: TextInputType.multiline,
                    //     maxLines: null,
                    controller: textController[0],
                    decoration: InputDecoration(hintText: "Activity"),
                  ),
                ),
                Text(", there are\n some"),
              ]),
            ),

            Row(
              children: [
                Text(" things that I don't like, including "),
                SizedBox(
                  width: 120,
                  child: Row(
                    children: [
                      Container( width: 120,
                        child: TextFormField(
                          controller: textController[4],
                          decoration:
                              InputDecoration(hintText: "Thing you don't like,1"),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Row(children: [
              Text(" and "),
              SizedBox(
                width: 200,
                child: Row(children: [
                  SizedBox( width: 120,
                    child: TextFormField(
                      controller: textController[5],
                      decoration:
                          InputDecoration(hintText: "Thing you don't like,2"),
                    ),
                  ),
                ]),
              )
            ]),

            RaisedButton(
                child: Text("Save"),
                onPressed: () async {
                  await save(database, user,
                      "Talk about your favorite activity", context);
                }),
          ]),
        ),
      ),
    );
  }
}
