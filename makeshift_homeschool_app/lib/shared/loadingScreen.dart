import 'package:flutter/material.dart';

/// Basic widget that shows a circular progress indicator for when data
/// is still loading

class LoadingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
