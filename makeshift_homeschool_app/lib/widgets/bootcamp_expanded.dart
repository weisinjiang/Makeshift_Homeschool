import 'package:flutter/material.dart';
import 'package:makeshift_homeschool_app/models/bootcamp_activity.dart';
import 'package:makeshift_homeschool_app/services/auth.dart';
import 'package:makeshift_homeschool_app/services/bootcamp_database.dart';
import 'package:makeshift_homeschool_app/services/bootcamp_provider.dart';
import 'package:makeshift_homeschool_app/shared/color_const.dart';
import 'package:makeshift_homeschool_app/shared/constants.dart';
import 'package:provider/provider.dart';

/// After clicking on the ListTitle for bootcamp, the actual lesson will enlarge
class BootCampExpanded extends StatelessWidget {
  final BootCampActivity activity;
  BootCampExpanded({Key key, this.activity}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    var userData = Provider.of<AuthProvider>(context).getUser;
    BootCampProvider activityWidget = BootCampProvider(activity: activity);
    activityWidget.constructAllFields(screenSize); // construct the widget list

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: colorPaleSpring,
        title: Text(activity.id),
      ),
      body: Container(
        height: screenSize.height,
        width: screenSize.width,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: ListView(
            children: [
              Container(
                height: screenSize.height * 0.35,
                width: screenSize.width,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50.0),
                    border: Border.all(
                        color: Colors.black,
                        style: BorderStyle.solid,
                        width: 3),
                    image: DecorationImage(
                        image: AssetImage("asset/gif/${activity.id}.gif"),
                        fit: BoxFit.fill)),
              ),
              const SizedBox(
                height: 30,
              ),
              activityWidget.buildWidget("intro", screenSize),
              const SizedBox(
                height: 10,
              ),
              activityWidget.buildWidget("body", screenSize),
              const SizedBox(
                height: 30,
              ),
              activityWidget.build5Reasons(screenSize),
              const SizedBox(
                height: 50,
              ),
              activityWidget.buildWidget("conclusion", screenSize),
              SizedBox(
                height: 30,
              ),
              Text(
                "Sincerely, \n${userData["username"]}",
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(
                height: 30,
              ),
              RaisedButton(
                child: Text("Save"),
                onPressed: () async {
                  /// fields are not empty
                  if (!activityWidget.areFieldsEmtpy()) {
                    Map<String, String> completeLetter =
                        activityWidget.saveLetter();
                    await Provider.of<BootCampDatabase>(context, listen: false)
                        .saveToUserProfile(
                            userData["uid"], activity.id, completeLetter);
                    Navigator.of(context).pop();
                  }
                },
                color: colorPaleSpring,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
