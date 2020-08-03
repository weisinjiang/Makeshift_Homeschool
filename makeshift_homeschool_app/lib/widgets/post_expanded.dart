import 'package:flutter/material.dart';
import 'dart:core';
import 'package:makeshift_homeschool_app/models/post_model.dart';
import 'package:makeshift_homeschool_app/widgets/post_widgets.dart';

/// Expanded Post after clicking on a Post Thumbnail.
/// Enlarged so you can see all the details for the post
///
class PostExpanded extends StatelessWidget {
  final Post postData;

  const PostExpanded({Key key, this.postData}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    List<Widget> contentToShowOnScreen = [];

    /// Map<String, Map<String, String>> from database
    var postContentMap = postData.getPostContents;
    var numBodies = postContentMap.length; // number of keys in the map

    /// body is the key for a map of contents, which are subtitle and paragraphs
    // postContentMap.forEach((body, content) {
    //   content.forEach((contentType, text) {
    //     if (contentType == "subtitle") {
    //       contentToShowOnScreen
    //           .add(buildSubTitle(text, screenSize.width, screenSize.height));
    //     } else {
    //       contentToShowOnScreen.add(buildParagraph(text, screenSize.width));
    //     }
    //   });
    //   // contentToShowOnScreen.add(SizedBox(
    //   //   height: screenSize.height * 0.05,
    //   // ));
    // });

     contentToShowOnScreen.add(buildImage(postData.getImageUrl,
        screenSize.height, screenSize.width)); //add image last
    /// Loop through each body. Body begins with 1
    for (var body = 0; body < postContentMap.length; body++) {
      var bodyNum = body + 1; // body1, body2, etc...
      /// {paragraph1 : text, paragraph2: text, subtitle : text}
      var bodyContent = postContentMap["body" + bodyNum.toString()];

      /// Add the subtitle first for each body contents
      var subtitleText = bodyContent["subtitle"];
      contentToShowOnScreen.add(
          buildSubTitle(subtitleText, screenSize.width, screenSize.height));

      /// Then add the paragraphs, bodyContent-1 because subtitle is not counted
      for (var paragraph = 0; paragraph < bodyContent.length - 1; paragraph++) {
        var paragraphNum = paragraph + 1;
        var paragraphText = bodyContent["paragraph" + paragraphNum.toString()];
        contentToShowOnScreen.add(
          buildParagraph(paragraphText, screenSize.width)
        );
      }
    }

    // contentToShowOnScreen.add(buildImage(postData.getImageUrl,
    //     screenSize.height, screenSize.width)); //add image last
    // contentToShowOnScreen
    //     .reversed; // reverse the list because the map is reversed
    return Scaffold(
      appBar: AppBar(
        title: Text(postData.getTitle),
      ),
      body: Container(
        width: screenSize.width,
        height: screenSize.height,
        child: ListView(
          children: contentToShowOnScreen,
        ),
      ),
    );
  }
}
