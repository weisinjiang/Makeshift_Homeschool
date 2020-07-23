import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:makeshift_homeschool_app/shared/constants.dart';

class NewPostFloatingActionButton extends StatefulWidget {
  @override
  _NewPostFloatingActionButtonState createState() =>
      _NewPostFloatingActionButtonState();
}

class _NewPostFloatingActionButtonState
    extends State<NewPostFloatingActionButton>
    with SingleTickerProviderStateMixin {
bool isOpened = false;
  AnimationController _animationController;
  Animation<Color> _buttonColor;
  Animation<double> _animateIcon;
  Animation<double> _translateButton;
  Curve _curve = Curves.easeOut;
  double _fabHeight = 56.0;

  @override
  initState() {
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 200))
          ..addListener(() {
            setState(() {});
          });
    _animateIcon =
        Tween<double>(begin: 0.0, end: 1.0).animate(_animationController);
    _buttonColor = ColorTween(
      begin: kGreenSecondary,
      end: Colors.red,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Interval(
        0.00,
        1.00,
        curve: Curves.linear,
      ),
    ));
    _translateButton = Tween<double>(
      begin: _fabHeight,
      end: -14.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Interval(
        0.0,
        0.75,
        curve: _curve,
      ),
    ));
    super.initState();
  }

  @override
  dispose() {
    _animationController.dispose();
    super.dispose();
  }

  animate() {
    if (!isOpened) {
      _animationController.forward();
    } else {
      _animationController.reverse();
    }
    isOpened = !isOpened;
  }

  // Button that switches and shows more buttons
  Widget toggle() {
    return Container(
      child: FloatingActionButton(
        onPressed: animate,
        backgroundColor: _buttonColor.value,
        child: AnimatedIcon(
          icon: AnimatedIcons.menu_close,
          progress: _animateIcon,
        ),
      ),
    );
  }

  // Add a new heading/title button
  Widget addNewTitleButton() {
    return Container(
      child: FloatingActionButton(
          onPressed: () {},
          backgroundColor: kGreenSecondary,
          child: Icon(FontAwesomeIcons.heading)),
    );
  }

  // Add a new paragraph button
  Widget addNewParagraphButton() {
    return Container(
      child: FloatingActionButton(
          onPressed: () {},
          backgroundColor: kGreenSecondary,
          child: Icon(FontAwesomeIcons.paragraph)),
    );
  }

  // Add a new image button
  Widget addNewImageButton() {
    return Container(
      child: FloatingActionButton(
          onPressed: () {},
          backgroundColor: kGreenSecondary,
          child: Icon(FontAwesomeIcons.image)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        Transform(
          transform: Matrix4.translationValues(
            0.0,
            _translateButton.value * 3.0,
            0.0,
          ),
          child: addNewTitleButton(),
        ),
        Transform(
          transform: Matrix4.translationValues(
            0.0,
            _translateButton.value * 2.0,
            0.0,
          ),
          child: addNewParagraphButton(),
        ),
        Transform(
          transform: Matrix4.translationValues(
            0.0,
            _translateButton.value,
            0.0,
          ),
          child: addNewImageButton(),
        ),
        toggle(),
      ],
    );
  }
}
