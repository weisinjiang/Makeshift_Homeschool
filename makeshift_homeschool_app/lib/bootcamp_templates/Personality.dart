// keyboardType: TextInputType.multiline,
//   maxLines: null,

import 'package:flutter/material.dart';
import 'package:makeshift_homeschool_app/services/auth.dart';
import 'package:makeshift_homeschool_app/services/bootcamp_provider.dart';
import 'package:makeshift_homeschool_app/shared/warning_messages.dart';
import 'package:provider/provider.dart';

class Personality extends StatefulWidget {
  @override
  _PersonalityState createState() => _PersonalityState();
}

class _PersonalityState extends State<Personality> {
  List<TextEditingController> textController = [
    TextEditingController(),

    /// controller for "What happened?" index0
    TextEditingController(),

    /// controller for "What happened?" index0
    TextEditingController(),

    /// controller for "How did it start out?" index1
    TextEditingController(),

    /// controller for "What happened next?" index2
    TextEditingController(),

    /// controller for "How did it end?" index3
    TextEditingController(),

    /// controller for "Why?" index4
    TextEditingController(),

    /// controller for "Why?" index4
  ];

  Future<void> save(BootCampProvider database, Map<String, dynamic> userData,
      String activityID, BuildContext context) async {
    String userResponse = """
    What is your personality ${textController[0].text},\n
    I really enjoy playing ${textController[1].text}.\n
    And I have some ideas on how to make it even better!\n
    1. ${textController[2].text}\n
    2. ${textController[3].text}\n
    3. ${textController[4].text}\n
    4. ${textController[5].text}\n
    5. ${textController[6].text}\n
    Thank you for considering my ideas!
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
        title: Text("What is Your Personality"),
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
                "asset/bootcamp/? Head.png",
                height: screenSize.height * 0.3,
                width: screenSize.width,
              ),
              SizedBox(
                height: screenSize.height * 0.03,
              ),

              Text("introvert means: extrovert means:"),

              SizedBox(
                height: screenSize.height * 0.03,
              ),

              Text("1."),

              SizedBox(
                child: TextFormField(
                  /// add a controller and attach it to this field
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  controller: textController[2],
                  decoration: InputDecoration(
                      hintText: "Are introverted or extroverted?"),
                ),
                width: screenSize.width,
              ),

              SizedBox(
                height: 40,
              ),

              Text("introvert means: extrovert means:"),

              SizedBox(
                height: screenSize.height * 0.01,
              ),

              SizedBox(
                height: screenSize.height * 0.03,
              ),

              Text("2."),

              SizedBox(
                child: TextFormField(
                  /// add a controller and attach it to this field
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  controller: textController[3],
                  decoration: InputDecoration(
                      hintText: "Are you Sensing or intuitive?"),
                ),
                width: screenSize.width,
              ),

              SizedBox(
                height: 40,
              ),

              Text("introvert means: extrovert means:"),

              SizedBox(
                height: screenSize.height * 0.01,
              ),

              SizedBox(
                height: screenSize.height * 0.03,
              ),

              Text("3."),

              SizedBox(
                child: TextFormField(
                  /// add a controller and attach it to this field
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  controller: textController[4],
                  decoration:
                      InputDecoration(hintText: "Are you thinking or feeling?"),
                ),
                width: screenSize.width,
              ),

              SizedBox(
                height: 40,
              ),

              Text("introvert means: extrovert means:"),

              SizedBox(
                height: screenSize.height * 0.01,
              ),

              SizedBox(
                height: screenSize.height * 0.03,
              ),

              Text("4. "),

              SizedBox(
                width: 300,
              ),

              SizedBox(
                child: TextFormField(
                  /// add a controller and attach it to this field
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  controller: textController[5],
                  decoration: InputDecoration(
                      hintText: "Are you judging or perceiving?"),
                ),
                width: screenSize.width,
              ),

              SizedBox(
                height: screenSize.height * 0.03,
              ),

              SizedBox(
                width: 300,
              ),

              SizedBox(
                child: TextFormField(
                  /// add a controller and attach it to this field
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  controller: textController[6],
                  decoration: InputDecoration(
                      hintText:
                          "What are some things you like about your personality?"),
                ),
                width: screenSize.width,
              ),

              SizedBox(
                height: screenSize.height * 0.03,
              ),

              Text("Thank you for learning about my personality!"),

              SizedBox(
                height: screenSize.height * 0.03,
              ),

              RaisedButton(
                  child: Text("Save"),
                  onPressed: () async {
                    await save(database, user,
                        "Make your favorite game even better", context);
                  })
            ],
          ),
        ),
      ),
    );
  }
}