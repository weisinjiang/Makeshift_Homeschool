import 'package:flutter/material.dart';
import 'package:makeshift_homeschool_app/models/bootcamp_activity.dart';
import 'package:makeshift_homeschool_app/shared/constants.dart';
import 'package:makeshift_homeschool_app/shared/scale_transition.dart';
import 'package:makeshift_homeschool_app/widgets/bootcamp_expanded.dart';

/// ListTile for Bootcamp.
/// Users will click before showing them the lesson details

class BootCampListTile extends StatelessWidget {
  final BootCampActivity activity;

  const BootCampListTile({Key key, this.activity}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Material(
        child: Ink(
          decoration: BoxDecoration(
              color: kGreenSecondary,
              border: Border.all(color: Colors.black, width: 2.0)),
          child: InkWell(
            splashColor: Colors.grey,
            onTap: () => Navigator.push(
                context,
                ScaleRoute(
                    screen: BootCampExpanded(
                  activity: activity,
                ))),
            // onTap: () {},
            child: ListTile(
              leading: CircleAvatar(
                  backgroundColor: kGreenSecondary_analogous1,
                  child: Image.asset(
                    'asset/bootcamp/${activity.image}',
                    fit: BoxFit.contain,
                  )),
              title: Text(
                activity.id,
                textAlign: TextAlign.center,
                style: kTitleTextStyle,
              ),
              trailing: Icon(Icons.arrow_forward_ios),
            ),
          ),
        ),
      ),
    );
  }
}
