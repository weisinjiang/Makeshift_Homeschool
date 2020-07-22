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

    /// body is the key for a map of contents, which are subtitle and paragraphs
    postContentMap.forEach((body, content) {
      content.forEach((contentType, text) {
        if (contentType == "subtitle") {
          contentToShowOnScreen
              .add(buildSubTitle(text, screenSize.width, screenSize.height));
        } else {
          contentToShowOnScreen.add(buildParagraph(text, screenSize.width));
        }
      });
      // contentToShowOnScreen.add(SizedBox(
      //   height: screenSize.height * 0.05,
      // ));
    });
    contentToShowOnScreen.add(buildImage(postData.getImageUrl, screenSize.height, screenSize.width)); //add image last
    contentToShowOnScreen.reversed; // reverse the list because the map is reversed
    return Scaffold(
      appBar: AppBar(
        title: Text(postData.getTitle),
      ),
      body: Container(
        width: screenSize.width,
        height: screenSize.height,
        child: ListView(
          children: List.from(contentToShowOnScreen.reversed),
        ),
      ),
    );
  }
}
