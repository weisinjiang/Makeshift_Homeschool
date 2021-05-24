// keyboardType: TextInputType.multiline,
//   maxLines: null,

//DONE

import 'package:flutter/material.dart';
import 'package:makeshift_homeschool_app/services/auth.dart';
import 'package:makeshift_homeschool_app/services/bootcamp_provider.dart';
import 'package:makeshift_homeschool_app/shared/warning_messages.dart';
import 'package:provider/provider.dart';

class Yourfavoritefictionalcharacter extends StatefulWidget {
  @override
  _YourfavoritefictionalcharacterState createState() =>
      _YourfavoritefictionalcharacterState();
}

class _YourfavoritefictionalcharacterState
    extends State<Yourfavoritefictionalcharacter> {
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

  Future<void> save(BootCampProvider database, Map<String, dynamic> userData, String activityID,
      BuildContext context) async {
    String userResponse = """
    My favorite fictional charecter is ${textController[0].text} from ${textController[1].text}.\n
    Here are some reasons why I like this character:\n
    1. ${textController[2].text}\n
    2. ${textController[3].text}\n
    3. ${textController[4].text}\n
    4. ${textController[5].text}\n
    5. ${textController[6].text}\n
    Thank you for reading about my favorite fictional charecter! I hope you enjoyed!\n
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
        title: Text("Your favorite character"),
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

              Image.asset("asset/bootcamp/reading.gif"),

              Text("My favorite fictional character is "),

              Row(
                children: [
                  SizedBox(
                    width: 120,
                    child: TextFormField(
                      /// add a controller and attach it to this field
                      // keyboardType: TextInputType.multiline,
                      //     maxLines: null,
                      controller: textController[0],
                      decoration: InputDecoration(hintText: "Name"),
                    ),
                  ),
                  Text("  from     "),
                  SizedBox(
                    width: 140,
                    child: TextFormField(
                      /// add a controller and attach it to this field
                      // keyboardType: TextInputType.multiline,
                      //     maxLines: null,
                      controller: textController[1],
                      decoration: InputDecoration(hintText: "fictional story"),
                    ),
                  ),
                ],
              ),

              SizedBox(
                height: screenSize.height * 0.03,
              ),

              Text("Here are some reasons why I like this character:"),

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
                  decoration: InputDecoration(hintText: "Reason One"),
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
                  decoration: InputDecoration(hintText: "Reason Two"),
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
                  decoration: InputDecoration(hintText: "Reason Three"),
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
                  decoration: InputDecoration(hintText: "Reason Four"),
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
                  decoration: InputDecoration(hintText: "Reason Five"),
                ),
                width: screenSize.width,
              ),

              SizedBox(
                height: screenSize.height * 0.03,
              ),

              Text(
                  "Thank you for reading about my favorite fictional character! I hope you enjoyed!"),

              SizedBox(
                height: screenSize.height * 0.03,
              ),

              RaisedButton(
                  child: Text("Save"),
                  onPressed: () async {
                    await save(database, user, "Your favorite character",
                        context);
                  })
            ],
          ),
        ),
      ),
    );
  }
}
