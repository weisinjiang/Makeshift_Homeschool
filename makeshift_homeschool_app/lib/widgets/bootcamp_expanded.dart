import 'package:flutter/material.dart';
import 'package:makeshift_homeschool_app/models/bootcamp_activity.dart';
import 'package:makeshift_homeschool_app/shared/constants.dart';
/// After clicking on the ListTitle for bootcamp, the actual lesson will enlarge
class BootCampExpanded extends StatelessWidget {
  final BootCampActivity activity;

  const BootCampExpanded({Key key, this.activity}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    List<Widget> contents = [];

    activity.template.forEach((key, value) {
      contents.add(Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          value,
          style: TextStyle(
            fontSize: 20
          ),
          textAlign: TextAlign.left,
        ),
      ));

      contents.add(SizedBox(height: 20,));
    });

    return Scaffold(
        appBar: AppBar(
    title: Text(activity.id),
        ),
        body: Container(
    child: ListView(
      children: contents,
    ),
        ),
      );
  }
}
