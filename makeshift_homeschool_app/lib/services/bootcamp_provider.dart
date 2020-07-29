import 'package:flutter/material.dart';
import 'package:makeshift_homeschool_app/models/bootcamp_activity.dart';

/// Bootcamp that deals with rendering and controlling text widgets
/// First need to pass in an activity for it to work on
class BootCampProvider {
  final BootCampActivity activity; // REQUIRED!

  /// Controllers
  //List<TextEditingController> fillInBoxesController; // fill in for letter
  Map<String, List<TextEditingController>> fillInBoxesController;
  List<TextEditingController> fiveResponsesController; // 5 responses

  /// Widget List to be shown on the screen and when called
  List<Widget> widgetList = [];
  Map<String, List<Widget>> widgetMap;

  /// Constructor
  ///   Requires activity to be passed in, then makes ref to database
  ///   FillIn box is empty because the number of input is different /activity
  ///   Widget to render is empty initially
  ///   Five Response will be consistant with each activity
  BootCampProvider({this.activity}) {
    this.fillInBoxesController = {"intro": [], "body": [], "conclusion": []};
    this.widgetList = [];
    this.widgetMap = {"intro": [], "body": [], "conclusion": []};
    this.fiveResponsesController = [
      TextEditingController(),
      TextEditingController(),
      TextEditingController(),
      TextEditingController(),
      TextEditingController()
    ];
  }

  void addTextControllerToFillInBoxList(String field) =>
      this.fillInBoxesController[field].add(TextEditingController());

  int getFillInBoxListSize(String field) =>
      this.fillInBoxesController[field].length;

  List<Widget> get getWidgetList => this.widgetList;

  List<TextEditingController> getFillInBoxController(String field) =>
      this.fillInBoxesController[field];

  /// Buid the widget list based on the field, where field is: intro, body, conc
  /// And add it to the Widget map based on what field it is
  void constructWidgetField(String field, Size screenSize) {
    var contents = activity.contentsAsStringList(field);
    var userInputHints = activity.getUserinputMatches(activity.template[field]);

    for (var i = 0; i < contents.length; i++) {
      var text = contents[i];
      if (i == contents.length - 1) {
        // Last item is empty, means last widget is a textform field
        if (contents[i].length == 0) {
          var hint = userInputHints[i];
          hint = hint.replaceAll("<", "");
          hint = hint.replaceAll(">", "");
          addTextControllerToFillInBoxList(
              field); // add a controller for textfield
          this.widgetMap[field].add(Container(
                width: screenSize.width * 0.30,
                child: TextField(
                  textAlign: TextAlign.center,
                  controller: fillInBoxesController[field]
                      [getFillInBoxListSize(field) - 1],
                  maxLines: null,
                  decoration: InputDecoration(hintText: hint, labelText: hint),
                ),
              ));
        } else {
          /// if not empty, widget ends with a Text widget
          this.widgetMap[field].add(Text(
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
        this.widgetMap[field].add(Text(
              text,
              style: TextStyle(fontSize: 20),
              textAlign: TextAlign.left,
            ));
        addTextControllerToFillInBoxList(field);
        this.widgetMap[field].add(Container(
              width: screenSize.width * 0.30,
              child: TextField(
                textAlign: TextAlign.center,
                controller: fillInBoxesController[field]
                    [getFillInBoxListSize(field) - 1],
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

  /// Construct all the fields: Intro, body, conclusion by calling
  /// constructWidgetField. This widget is called when consumer is created
  void constructAllFields(Size screenSize) {
    constructWidgetField("intro", screenSize);
    constructWidgetField("body", screenSize);
    constructWidgetField("conclusion", screenSize);
  }

  /// Checks if any fields is left empty
  bool areFieldsEmtpy() {
    /// Check the 5 responses controllers
    this.fiveResponsesController.forEach((controller) {
      if (controller.text.isNotEmpty) {
        return true;
      }
    });

    /// For each field's controller, check if it's empty
    this.fillInBoxesController.forEach((_, list) {
      list.forEach((controller) {
        if (controller.text.isEmpty) {
          return true;
        }
      });
    });

    /// if not all empty, false
    return false;
  }

  /// Save the letter into a string by first getting the content as a string
  /// with user inputs replaced as <>
  /// Then loop through the field's controllers and replace each <> with it
  Map<String, String> saveLetter() {
    var contentIntro = activity.getContentAsStringWithBrackets("intro");
    var contentsBody = activity.getContentAsStringWithBrackets("body");
    var contentsConclusion =
        activity.getContentAsStringWithBrackets("conclusion");
    Map<String, String> completedLetter = {};

    this.fillInBoxesController.forEach((field, controllerList) {
      var text = activity.getContentAsStringWithBrackets(field);
      controllerList.forEach((controller) {
        text = text.replaceFirst("<>", controller.text);
      });
      completedLetter[field] = text;
    });

    for (var i = 0; i < 5; i++) {
      completedLetter["reason" + i.toString()] =
          fiveResponsesController[i].text;
          
    }
    return completedLetter;
  }

  Widget build5Reasons(Size screenSize) {
    return Container(
      width: screenSize.width,
      child: Column(
        children: <Widget>[
          TextField(
            textAlign: TextAlign.center,
            controller: fiveResponsesController[0],
            decoration: InputDecoration(
                icon: Icon(Icons.arrow_right), prefixText: "Reason 1: "),
          ),
          TextField(
            textAlign: TextAlign.center,
            controller: fiveResponsesController[1],
            decoration: InputDecoration(
                icon: Icon(Icons.arrow_right), prefixText: "Reason 2: "),
          ),
          TextField(
            textAlign: TextAlign.center,
            controller: fiveResponsesController[2],
            decoration: InputDecoration(
                icon: Icon(Icons.arrow_right), prefixText: "Reason 3: "),
          ),
          TextField(
            textAlign: TextAlign.center,
            controller: fiveResponsesController[3],
            decoration: InputDecoration(
                icon: Icon(Icons.arrow_right), prefixText: "Reason 4: "),
          ),
          TextField(
            textAlign: TextAlign.center,
            controller: fiveResponsesController[4],
            decoration: InputDecoration(
                icon: Icon(Icons.arrow_right), prefixText: "Reason 5: "),
          ),
        ],
      ),
    );
  }

  /// Build the intro widget and return a container that has the contents
  Widget buildWidget(String field, Size screenSize) {
    List<Widget> introWidgetsList = this.widgetMap[field];

    return Container(
      width: screenSize.width,
      child: Wrap(
        crossAxisAlignment: WrapCrossAlignment.center,
        alignment: WrapAlignment.start,
        direction: Axis.horizontal,
        spacing: 10.0,
        children: introWidgetsList,
      ),
    );
  }
}
