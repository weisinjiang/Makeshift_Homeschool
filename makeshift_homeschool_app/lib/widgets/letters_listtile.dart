import 'package:flutter/material.dart';
import 'package:makeshift_homeschool_app/models/bootcamp_lesson.dart';
import 'package:makeshift_homeschool_app/shared/constants.dart';
import 'package:makeshift_homeschool_app/shared/scale_transition.dart';
import 'package:makeshift_homeschool_app/widgets/letters_expanded.dart';
import 'package:provider/provider.dart';

class LettersListTile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    /// Single BootCampLesson from Completed Letters screen
    final lesson = Provider.of<BootCampLesson>(context, listen: false);

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
                    screen: LetterExpanded(
                  lesson: lesson,
                ))),
            //  onTap: () {},
            child: ListTile(
              title: Text(
                lesson.getId,
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
