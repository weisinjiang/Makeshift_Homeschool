import 'package:flutter/material.dart';
import 'package:makeshift_homeschool_app/shared/constants.dart';
import 'package:makeshift_homeschool_app/shared/warning_messages.dart';
import 'package:makeshift_homeschool_app/widgets/new_post_floating_action_button.dart';
import 'package:makeshift_homeschool_app/widgets/new_post_widgets.dart';

///  Pops up a form for users to create a lesson
/// Takes a lesson name and multiple subtitles and paragraphs
/// Users will be able to add additional paragraphs and subtiltes, but there
/// can only be 1 title.
///
/// Structure
///   Form takes in a list of cutomized TextFormField widgets
///   Adding a new subtitle or paragraph adds these cutomized widgets into
///   the list and redraws the screen.
///
///   A form key is provided to keep track of the contents in the forms when
///   a new paragraph or subtitle is added

class NewPostScreen extends StatefulWidget {
  @override
  _NewPostScreenState createState() => _NewPostScreenState();
}

class _NewPostScreenState extends State<NewPostScreen> {
  /// Tracks user data so that if the build method is redrawn, input is saved
  final GlobalKey<FormState> _newPostFormKey = GlobalKey();

  /// Added widgets are in-order and will be placed into Firestore the same way
  /// Widget index should be the same as the order in which it appears on the
  /// app from top to bottom: index 0 = first item on the screen
  List<Widget> newPostWidgetList = [
    lessonTitle(null, null),
    addSubTitle(null, null),
    addParagraph(null, null)
  ];

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text("New Lesson"),
        elevation: 1.0,
        backgroundColor: kGreenSecondary_analogous2,

        /// Add to the database
        actions: <Widget>[
          FlatButton(
            onPressed: () {},
            child: Text(
              "Post",
              style: TextStyle(
                  color: Colors.blue,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
            highlightColor: Colors.transparent,
            color: Colors.transparent,
            splashColor: Colors.transparent,
          )
        ],
      ),
      // used to add paragraphs, images and titles

      /// Using a builder because a scaffold is shown in one of the child widgets below
      /// Scaffold of above is not reachable without the Builder widget.
      body: Builder(
        builder: (context) => Container(
          /// Color of the entire background of this page
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
              kGreenSecondary_analogous2,
              kGreenSecondary_analogous1
            ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
          ),
          height: screenHeight,
          width: screenWidth,

          /// Users can add infinite amount of subtiles and paragraphs, so when
          /// it goes out of screen, it should be scrollable
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Form(
                      key: _newPostFormKey, // Key to preserve input if rebuild
                      child: Column(
                        children:
                            newPostWidgetList, // global list of paragraphs, etc
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        FlatButton(
                            onPressed: () {
                              setState(() {
                                newPostWidgetList.add(addParagraph(null, null));
                              });
                            },
                            child: Text("+ Paragraph")),

                        // Add Paragraph
                        FlatButton(
                            onPressed: () {
                              setState(() {
                                newPostWidgetList.add(addSubTitle(null, null));
                              });
                            },
                            child: Text("+ Subtitle")),

                        // Remove last widget
                        FlatButton(
                            onPressed: () {
                              /// By default, the new post should have a title, sub and paragraph.
                              /// Only remove the most recent text field IF there is more than 3 widgets
                              if (newPostWidgetList.length > 3) {
                                setState(() {
                                  newPostWidgetList.removeLast();
                                });
                              } else if (newPostWidgetList.length == 3) {
                                /// If the textfield is 3, then they cant remove more
                                Scaffold.of(context).showSnackBar(
                                    snackBarMessage(
                                        "You can't remove more fields"));
                              }
                            },
                            child: Text("Delete")),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
