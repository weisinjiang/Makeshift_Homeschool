import 'package:flutter/material.dart';
import 'package:makeshift_homeschool_app/models/letter.dart';
import 'package:makeshift_homeschool_app/shared/constants.dart';
import 'package:makeshift_homeschool_app/shared/scale_transition.dart';
import 'package:makeshift_homeschool_app/widgets/letters_expanded.dart';

class LettersListTile extends StatelessWidget {
  final Letter letter;

  const LettersListTile({Key key, this.letter}) : super(key: key);
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
                    screen: LetterExpanded(
                  letter: letter,
                ))),
            //  onTap: () {},
            child: ListTile(
              title: Text(
                letter.id,
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
