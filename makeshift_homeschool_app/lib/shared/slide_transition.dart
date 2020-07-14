import 'package:flutter/material.dart';

/// Animation for when the page changes to another screen
/// Slide effect

class SlideLeftRoute extends PageRouteBuilder {
  final Widget screen;  // the screen to be transitioned using the animation
  SlideLeftRoute({this.screen}) // constructor
      : super(
          pageBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) =>
              screen,
          transitionsBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) =>
              SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(1, 0), // from bottom -y 
                  end: Offset.zero,
                ).animate(animation),
                child: child,
              ),
        );
}
