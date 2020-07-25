import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:makeshift_homeschool_app/models/bootcamp_activity.dart';

/// Bootcamp that deals with rendering and controlling text widgets
/// First need to pass in an activity for it to work on
class BootCampProvider {
  final BootCampActivity activity; // REQUIRED!

  /// Firestore Instances
  final Firestore _database = Firestore.instance;
  CollectionReference _bootcampRef;
  CollectionReference _userDocumentBootCampRef;

  /// Controllers
  List<TextEditingController> fillInBoxesController; // fill in for letter
  List<TextEditingController> fiveResponsesController; // 5 responses

  /// Widget List to be shown on the screen and when called
  List<Widget> widgetList = [];

  /// Constructor
  ///   Requires activity to be passed in, then makes ref to database
  ///   FillIn box is empty because the number of input is different /activity
  ///   Widget to render is empty initially
  ///   Five Response will be consistant with each activity
  BootCampProvider({this.activity}) {
    this._bootcampRef = _database.collection("bootcamp");
    this._userDocumentBootCampRef = _database.collection("user documents");
    this.fillInBoxesController = [];
    this.widgetList = [];
    this.fiveResponsesController = List(5);
    this.fiveResponsesController.fillRange(0, 5, TextEditingController());
  }

  Future<List<BootCampActivity>> getBootCampActivities() async {
    List<BootCampActivity> activities = [];
    var snapshot = await _bootcampRef.getDocuments();
    var allDocuments = snapshot.documents;
    allDocuments.forEach((doc) {
      var activity = BootCampActivity(id: doc.documentID);
      activity.setData = doc;
      activities.add(activity);
    });

    return activities;
  }

  List<String> getBootCampActivityNames(List<BootCampActivity> list) {
    List<String> names = [];
    list.forEach((element) {
      names.add(element.id);
    });
    return names;
  }

  void addTextControllerToFillInBoxList() =>
      this.fillInBoxesController.add(TextEditingController());

  int get getFillInBoxListSize => this.fillInBoxesController.length;

  List<Widget> get getWidgetList => this.widgetList;

  List<TextEditingController> get getFillInBoxController =>
      this.fillInBoxesController;

  /// Buid the widget list based on the field, where field is: intro, body, conc
  void constructWidgetField(String field, Size screenSize) {
    var contents = activity.contentsAsStringList(field);
    var userInputHints = activity.getUserinputMatches(activity.template[field]);

    //List<Widget> widgetList = [];

    for (var i = 0; i < contents.length; i++) {
      var text = contents[i];
      if (i == contents.length - 1) {
        // Last item is empty, means last widget is a textform field
        if (contents[i].length == 0) {
          var hint = userInputHints[i];
          hint = hint.replaceAll("<", "");
          hint = hint.replaceAll(">", "");
          addTextControllerToFillInBoxList(); // add a controller for textfield
          this.widgetList.add(Container(
                width: screenSize.width * 0.30,
                child: TextField(
                  controller: fillInBoxesController[getFillInBoxListSize - 1],
                  maxLines: null,
                  decoration: InputDecoration(hintText: hint, labelText: hint),
                ),
              ));
        } else {
          /// if not empty, widget ends with a Text widget
          this.widgetList.add(Text(
                text,
                style: TextStyle(fontSize: 20),
                textAlign: TextAlign.left,
              ));
        }
      } else {
        // if not at the end of the list, add the text & textfield
        var hint = userInputHints[i];
        hint = hint.replaceAll("<", "");
        hint = hint.replaceAll(">", "");
        this.widgetList.add(Text(
              text,
              style: TextStyle(fontSize: 20),
              textAlign: TextAlign.left,
            ));
        addTextControllerToFillInBoxList();
        this.widgetList.add(Container(
              width: screenSize.width * 0.30,
              child: TextField(
                controller: fillInBoxesController[getFillInBoxListSize - 1],
                decoration: InputDecoration(hintText: hint),
                maxLines: null,
              ),
            ));
      }
    }

    // return Container(
    //   width: screenSize.width,
    //   child: Wrap(
    //     crossAxisAlignment: WrapCrossAlignment.center,
    //     alignment: WrapAlignment.start,
    //     direction: Axis.horizontal,
    //     children: this.widgetList,
    //   ),
    // );
  }
}
