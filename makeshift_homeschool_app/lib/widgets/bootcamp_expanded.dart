import 'package:flutter/material.dart';
import 'package:makeshift_homeschool_app/models/bootcamp_activity.dart';
import 'package:makeshift_homeschool_app/services/auth.dart';
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
    Map<String, String> fiveResponse = {};

    /// Controlls the text input for the 5 responses
    List<TextEditingController> fiveResponseController = List(5);
    fiveResponseController.fillRange(0, 5, TextEditingController());

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
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
              SizedBox(
                height: 10,
              ),
              activity.buildWidget("intro", screenSize),
              SizedBox(
                height: 20,
              ),
              activity.buildWidget("body", screenSize),
              SizedBox(
                height: 20,
              ),
              TextField(
                controller: fiveResponseController[0],
                decoration: InputDecoration(
                    icon: Icon(Icons.arrow_right), prefixText: "Reason 1: "),
              ),
              TextField(
                controller: fiveResponseController[1],
                decoration: InputDecoration(
                    icon: Icon(Icons.arrow_right), prefixText: "Reason 2: "),
              ),
              TextField(
                controller: fiveResponseController[2],
                decoration: InputDecoration(
                    icon: Icon(Icons.arrow_right), prefixText: "Reason 3: "),
              ),
              TextField(
                controller: fiveResponseController[3],
                decoration: InputDecoration(
                    icon: Icon(Icons.arrow_right), prefixText: "Reason 4: "),
              ),
              TextField(
                controller: fiveResponseController[4],
                decoration: InputDecoration(
                    icon: Icon(Icons.arrow_right), prefixText: "Reason 5: "),
              ),
              SizedBox(
                height: 20,
              ),
              activity.buildWidget("conclusion", screenSize),
              SizedBox(
                height: 30,
              ),
              Text(
                "Thank you, \n${userData["username"]}",
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(
                height: 30,
              ),
              RaisedButton(
                child: Text("Save"),
                onPressed: () async {
                  for (var i = 0; i < 5; i++) {
                    fiveResponse["Response " + i.toString()] =
                        fiveResponseController[i].text;
                    fiveResponseController.clear();
                  }
                  
                },
                color: kGreenSecondary,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
