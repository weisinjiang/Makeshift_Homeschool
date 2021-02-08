import 'package:flutter/material.dart';


/// Video screen where video lessons are retrieved from the database and shown.
/// This class will draw the video lesson screen, similar to the learn page
/// Similar implementation to study_screen.dart
class VideoScreen extends StatefulWidget {
  @override
  _VideoScreenState createState() => _VideoScreenState();
  
}

class _VideoScreenState extends State<VideoScreen> {

  // Landed on this page
  var _isInit = true;
  // Not loading anything yet 
  var _isLoading = false;

  @override
  void didChangeDependencies() {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });
      // WEI: Add video provider that gets video from Firebase

    }
    _isInit = false;
    super.didChangeDependencies();
  }

  // Build only the screen where we place Thumbnail Widgets of the video post
  // @WEI -> Add checks that shows a loading screen if video feed fails to load on top of Sumay's code later
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}