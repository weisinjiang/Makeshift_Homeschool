import 'package:flutter/material.dart';
import 'package:makeshift_homeschool_app/models/post_model.dart';

class PostExpanded extends StatelessWidget {
  final Post postData;

  const PostExpanded({Key key, this.postData}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(postData.getTitle),
      ),
      body: Container(
        width: screenSize.width,
        height: screenSize.height,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget> [
              Text("Nothing yet")
            ]
          ),
        ),
      ),
    );
  }
}
