import 'package:flutter/material.dart';
import 'package:makeshift_homeschool_app/services/auth.dart';
import 'package:makeshift_homeschool_app/services/new_post_provider.dart';
import 'package:makeshift_homeschool_app/shared/constants.dart';
import 'package:makeshift_homeschool_app/shared/warning_messages.dart';
import 'package:provider/provider.dart';

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
///
///

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
  NewPostProvider newPost = NewPostProvider();

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    var authProvider = Provider.of<AuthProvider>(context);

    /// New post uses this provider as a global variable so users can
    /// add as many paragraphs, subtitles as they want.
    return Consumer<NewPostProvider>(
      //Consumes the provider in main.dart
      /// Consumer that uses NewPostProvider
      builder: (context, newPostProvider, _) => Scaffold(
        appBar: AppBar(
          title: Text("New Lesson"),
          elevation: 1.0,
          backgroundColor: kGreenSecondary_analogous2,

          /// Add to the database
          actions: <Widget>[
            FlatButton(
              onPressed: () {
                authProvider.getUserInformation().then((userInfo) async{
                  int lessonCreated = int.parse(userInfo["lesson_created"]);
                  await newPostProvider.post(
                      userInfo["uid"], userInfo["username"], lessonCreated);
                });
                Navigator.of(context).pop();
              },
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
        body: Container(
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
          child: Builder(
            builder: (context) => ListView(
              children: <Widget>[
                /// Middle screen where users input paragraphs and subtiles
                Container(
                  height: screenHeight * 0.70,
                  width: screenWidth * 0.96,
                  // decoration:
                  //     BoxDecoration(border: Border.all(color: Colors.black)),
                  child: Scrollbar(
                    child: SingleChildScrollView(
                      child: Column(
                        children: newPostProvider.getNewPostWidgetList,
                      ),
                    ),
                  ),
                ),

                /// Bottom Buttons to add/remove paragraphs and subtitles
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      FlatButton(
                          onPressed: () => newPostProvider.addParagraph(),
                          child: Text("+ Paragraph")),

                      // AddSubtile
                      FlatButton(
                          onPressed: () => newPostProvider.addSubtitle(),
                          child: Text("+ Subtitle")),

                      //Remove last widget
                      FlatButton(
                          onPressed: () {
                            var isAbleToRemove =
                                newPostProvider.removeLastTextForm();
                            if (!isAbleToRemove) {
                              Scaffold.of(context).showSnackBar(snackBarMessage(
                                  "You can't remove more fields"));
                            }
                          },
                          child: Text("Delete")),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
