// keyboardType: TextInputType.multiline,
//   maxLines: null,

//DONE!

import 'package:flutter/material.dart';
import 'package:makeshift_homeschool_app/services/auth.dart';
import 'package:makeshift_homeschool_app/services/bootcamp_provider.dart';
import 'package:makeshift_homeschool_app/shared/warning_messages.dart';
import 'package:provider/provider.dart';

class Interviewyourparents extends StatefulWidget {
  @override
  _InterviewyourparentsState createState() => _InterviewyourparentsState();
}

class _InterviewyourparentsState extends State<Interviewyourparents> {
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
    Who are you interviewing? ${textController[0].text}\n
    1. What's something you wish you did?\n
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
        title: Text("Interview your parents"),
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
                "asset/bootcamp/Interviewparent.gif",
                height: screenSize.height * 0.3,
                width: screenSize.width,
              ),

              SizedBox(
                height: screenSize.height * 0.03,
              ),

              Row(
                children: [
                  Text("Who are you interviewing?  "),
                  SizedBox(
                    width: 120,
                    child: TextFormField(
                      /// add a controller and attach it to this field
                      // keyboardType: TextInputType.multiline,
                      //     maxLines: null,
                      controller: textController[0],
                      decoration: InputDecoration(hintText: "Parent"),
                    ),
                  ),
                ],
              ),

              SizedBox(
                height: screenSize.height * 0.03,
              ),

              Text("1. What do you do at your job?"),
              SizedBox(
                width: 120,
                child: TextFormField(
                  /// add a controller and attach it to this field
                  // keyboardType: TextInputType.multiline,
                  //     maxLines: null,
                  controller: textController[1],
                  decoration: InputDecoration(hintText: "Answer One"),
                ),
              ),

              SizedBox(
                height: screenSize.height * 0.03,
              ),

              SizedBox(
                height: screenSize.height * 0.03,
              ),

              Text("2. What would be your ideal job?"),

              SizedBox(
                child: TextFormField(
                  /// add a controller and attach it to this field
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  controller: textController[2],
                  decoration: InputDecoration(hintText: "Answer Two"),
                ),
                width: screenSize.width,
              ),

              SizedBox(
                height: screenSize.height * 0.03,
              ),

              Text("3. What is something your friends like about you?"),

              SizedBox(
                child: TextFormField(
                  /// add a controller and attach it to this field
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  controller: textController[3],
                  decoration: InputDecoration(hintText: "Answer Three"),
                ),
                width: screenSize.width,
              ),

              SizedBox(
                height: screenSize.height * 0.03,
              ),

              Text(
                  "4. What are traits you look for in friends?"),

              SizedBox(
                child: TextFormField(
                  /// add a controller and attach it to this field
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  controller: textController[4],
                  decoration: InputDecoration(hintText: "Answer Four"),
                ),
                width: screenSize.width,
              ),

              SizedBox(
                height: screenSize.height * 0.03,
              ),

              Text("5. How do you think is the best way to live life?"),

              SizedBox(
                width: 300,
              ),

              SizedBox(
                child: TextFormField(
                  /// add a controller and attach it to this field
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  controller: textController[5],
                  decoration: InputDecoration(hintText: "Answer Five"),
                ),
                width: screenSize.width,
              ),

              SizedBox(
                height: screenSize.height * 0.03,
              ),

              Text(
                  "6. What is a belief you have that few other adults share?"),

              SizedBox(
                width: 300,
              ),

              SizedBox(
                child: TextFormField(
                  /// add a controller and attach it to this field
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  controller: textController[6],
                  decoration: InputDecoration(hintText: "Answer Six"),
                ),
                width: screenSize.width,
              ),

              SizedBox(
                height: screenSize.height * 0.03,
              ),

              Text("7. How does your personality make you different from other people?"),

              SizedBox(
                width: 300,
              ),

              SizedBox(
                child: TextFormField(
                  /// add a controller and attach it to this field
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  controller: textController[7],
                  decoration: InputDecoration(hintText: "Answer Seven"),
                ),
                width: screenSize.width,
              ),

              SizedBox(
                height: screenSize.height * 0.03,
              ),

              Text("8. What's something you regret or a lesson learned?"),

              SizedBox(
                width: 300,
              ),

              SizedBox(
                child: TextFormField(
                  /// add a controller and attach it to this field
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  controller: textController[8],
                  decoration: InputDecoration(hintText: "Answer Eight"),
                ),
                width: screenSize.width,
              ),

              SizedBox(
                height: screenSize.height * 0.03,
              ),

              Text(
                  "9. What’s your dream vacation?"),

              SizedBox(
                width: 300,
              ),

              SizedBox(
                child: TextFormField(
                  /// add a controller and attach it to this field
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  controller: textController[9],
                  decoration: InputDecoration(hintText: "Answer Nine"),
                ),
                width: screenSize.width,
              ),

              SizedBox(
                height: screenSize.height * 0.03,
              ),

              Text(
                  "10. What is something you do to relax and recharge after a long day?"),

              SizedBox(
                width: 300,
              ),

              SizedBox(
                child: TextFormField(
                  /// add a controller and attach it to this field
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  controller: textController[10],
                  decoration: InputDecoration(hintText: "Answer Ten"),
                ),
                width: screenSize.width,
              ),

              SizedBox(
                height: screenSize.height * 0.03,
              ),

              RaisedButton(
                  child: Text("Save"),
                  onPressed: () async {
                    await save(
                        database, user, "Interview your parents", context);
                  })
            ],
          ),
        ),
      ),
    );
  }
}
