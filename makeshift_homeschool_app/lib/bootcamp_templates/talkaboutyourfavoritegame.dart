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

    /// controller for "Why?" index5
    TextEditingController(),

    /// controller for "Why?" index6
    TextEditingController(),

    /// controller for "What happened next?" index7
    TextEditingController(),

    /// controller for "How did it end?" index8
    TextEditingController(),

    /// controller for "Why?" index9
    TextEditingController(),

    /// controller for "Why?" index10
  ];

  Future<void> save(BootCampProvider database, Map<String, dynamic> userData,
      String activityID, BuildContext context) async {
    String userResponse = """
    My favorite activity is ${textController[0].text}\n
    Some things that i]I like about this activity\n
    ${textController[1].text}\n
    2. What's your favorite relaxing activity?\n
    ${textController[2].text}\n
    3. What would be your ideal vacation?\n
    ${textController[3].text}\n
    4. If you could go back in time and tell your younger self something, what would you tell them?\n
    ${textController[4].text}\n
    5. What's something about yourself you especially enjoy?\n
    ${textController[5].text}\n
    6. How has your childhood shaped you and your personality?\n
    ${textController[6].text}\n
    7. What do your friends and family like best about you?\n
    ${textController[7].text}\n
    8. What's something you regret, or a lesson learned?\n
    ${textController[8].text}\n
    9. What is a belief or point of view that you hold that is not shared by most people?\n
    ${textController[9].text}\n
    10. What is something you do to relax or recharge after a long day?\n
    ${textController[10].text}\n
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
          height: screenSize.height * 0.95,
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
                    width: 120,
                    child: TextFormField(
                      /// add a controller and attach it to this field
                      // keyboardType: TextInputType.multiline,
                      // maxLines: null,
                      controller: textController[1],
                      decoration:
                          InputDecoration(hintText: "What you like about it"),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: 120,
              child: Row(children: [
                Text("I recommend this activity because  "),
                TextFormField(
                  /// add a controller and attach it to this field
                  // keyboardType: TextInputType.multiline,
                  // maxLines: null,
                  controller: textController[2],
                ),
              ]),
            ),
            SizedBox(height: screenSize.height * 0.03, width: 120),

            SizedBox(
              width: 120,
              child: Row(children: [
                Text("Although I really like  "),
                SizedBox(
                  width: 120,
                  child: TextFormField(
                    /// add a controller and attach it to this field
                    // keyboardType: TextInputType.multiline,
                    //     maxLines: null,
                    controller: textController[0],
                    decoration: InputDecoration(hintText: "Activity"),
                  ),
                ),
                Text(", there are some"),
              ]),
            ),

            Row(
              children: [
                Text(" things that I don't like, including "),
                SizedBox(
                  width: 120,
                  child: Row(
                    children: [
                      TextFormField(
                        controller: textController[3],
                        decoration:
                            InputDecoration(hintText: "Things you don't like"),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Row(children: [
              Text(" things that I don't like, including "),
              SizedBox(
                width: 120,
                child: Row(children: [
                  TextFormField(
                    controller: textController[3],
                    decoration:
                        InputDecoration(hintText: "Things you don't like"),
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