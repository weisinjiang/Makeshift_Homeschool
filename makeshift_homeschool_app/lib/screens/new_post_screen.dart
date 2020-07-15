import 'package:flutter/material.dart';
import 'package:makeshift_homeschool_app/shared/constants.dart';
import 'package:makeshift_homeschool_app/widgets/new_post_floating_action_button.dart';
import 'package:makeshift_homeschool_app/widgets/new_post_widgets.dart';

class NewPostScreen extends StatefulWidget {
  @override
  _NewPostScreenState createState() => _NewPostScreenState();
}

class _NewPostScreenState extends State<NewPostScreen> {
  final GlobalKey<FormState> _newPostFormKey = GlobalKey();
  // Map<String, Widget> userPostManager = {
  //   "title": lessonTitle(null, null),

  //   "subTitle0": addSubTitle(null, null),
  //   "paragraph0": addParagraph(null, null)
  // }; // Tracks titles and paragraphs
  // Users can add titles and paragraphs to their post, this manages and tracks which is which

  List<Widget> newPostWidgetList = [
    lessonTitle(null, null),
    addSubTitle(null, null),
    addParagraph(null, null)
  ];

  int subTitleCount = 1; // Posts will always have at least 1 item already
  int paragraphCount = 1;

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text("What are you teaching, today?"),
        elevation: 0.0,
        backgroundColor: kGreenSecondary_analogous2,
      ),
      // used to add paragraphs, images and titles

      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [kGreenSecondary_analogous2, kGreenSecondary_analogous1],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter),
        ),
        height: screenHeight,
        width: screenWidth,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Form(
                key: _newPostFormKey,
                child: Column(
                  children: newPostWidgetList,
                ),
              ),
              // Add Paragraph
              FlatButton(
                  onPressed: () {
                    setState(() {
                      newPostWidgetList.add(addParagraph(null, null));
                     
                    });
                  },
                  child: Text("Add another paragraph")),

              // Add Paragraph
              FlatButton(
                  onPressed: () {
                    setState(() {
                      newPostWidgetList.add(addSubTitle(null, null));
                      newPostWidgetList.add(addParagraph(null, null));
                    });
                  },
                  child: Text("Add Subtitle")),
            ],
          ),
        ),
      ),
    );
  }
}
