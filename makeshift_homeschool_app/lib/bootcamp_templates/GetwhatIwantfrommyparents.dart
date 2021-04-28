// keyboardType: TextInputType.multiline,
//   maxLines: null,

//DONE

import 'package:flutter/material.dart';
import 'package:makeshift_homeschool_app/services/auth.dart';
import 'package:makeshift_homeschool_app/services/bootcamp_provider.dart';
import 'package:makeshift_homeschool_app/shared/warning_messages.dart';
import 'package:provider/provider.dart';

class GetWhatIWantFromMyParents extends StatefulWidget {
  @override
  _GetWhatIWantFromMyParentsState createState() =>
      _GetWhatIWantFromMyParentsState();
}
class _GetWhatIWantFromMyParentsState extends State<GetWhatIWantFromMyParents> {
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

    /// controller for "Why?" index7
  ];

  Future<void> save(BootCampProvider database, Map<String, dynamic> userData,
      String activityID, BuildContext context) async {
    String userResponse = """
    Dear ${textController[0].text},\n
    First, I wanna say, you're great parents.
    But, I've been wanting ${textController[1].text} for a pretty long time.\n
    Here's are some things that I've done that you might not of noticed.\n
    1. ${textController[2].text}\n
    2. ${textController[3].text}\n
    3. ${textController[4].text}\n
    4. ${textController[5].text}\n
    5. ${textController[6].text}\n
    I believe this is proof that I should get ${textController[7].text}.\n
    Thank you for considering my wants!
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
                height: screenSize.height * 0.3,
                width: screenSize.width,
              ),

              Text("Dear "),

              Row(
                children: [
                  SizedBox(
                    width: screenSize.width * 0.9,
                    child: TextFormField(
                      /// add a controller and attach it to this field
                      // keyboardType: TextInputType.multiline,
                      //     maxLines: null,
                      controller: textController[0],
                      decoration:
                          InputDecoration(hintText: "parent or gaurdian"),
                    ),
                  ),
                  Text(","),
                ],
              ),

              SizedBox(
                height: screenSize.height * 0.03,
              ),

              Text("First, I wanna say, you're great parents."),

              SizedBox(
                height: screenSize.height * 0.03,
              ),

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
                      decoration: InputDecoration(hintText: "what you want"),
                    ),
                  ),
                ],
              ),

              Text("for a pretty long time."),

              SizedBox(
                height: screenSize.height * 0.03,
              ),

              Text(
                  "Here are some things I've done that you might not have noticed:"),

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
                  decoration:
                      InputDecoration(hintText: "Something You've Done, One"),
                ),
                width: screenSize.width,
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
                  decoration:
                      InputDecoration(hintText: "Something You've Done, Two"),
                ),
                width: screenSize.width,
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
                      InputDecoration(hintText: "Something You've Done, Three"),
                ),
                width: screenSize.width,
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
                  decoration:
                      InputDecoration(hintText: "Something You've Done, Four"),
                ),
                width: screenSize.width,
              ),

              SizedBox(
                height: screenSize.height * 0.03,
              ),

              Text("5. "),

              SizedBox(
                width: 300,
              ),

              SizedBox(
                child: TextFormField(
                  /// add a controller and attach it to this field
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  controller: textController[6],
                  decoration:
                      InputDecoration(hintText: "Something You've Done, Five"),
                ),
                width: screenSize.width,
              ),

              SizedBox(
                height: screenSize.height * 0.03,
              ),

              Text("I believe this is proof that I should get"),

              SizedBox(
                width: 120,
                child: TextFormField(
                  /// add a controller and attach it to this field
                  // keyboardType: TextInputType.multiline,
                  //     maxLines: null,
                  controller: textController[7],
                  decoration: InputDecoration(hintText: "what you want"),
                ),
              ),

              SizedBox(
                height: screenSize.height * 0.03,
              ),

              Text("Thank you for considering my wants!"),

              SizedBox(
                height: screenSize.height * 0.03,
              ),

              RaisedButton(
                  child: Text("Save"),
                  onPressed: () async {
                    await save(database, user,
                        "Get what I want from my parents", context);
                  })
            ],
          ),
        ),
      ),
    );
  }
}
