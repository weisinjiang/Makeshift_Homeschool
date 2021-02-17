import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';
import 'package:flutter/foundation.dart';


/// This class used the Youtube Player API in pubspec.yaml
/// Pass in the required information so that this player can be used 
/// anywhere in the app
class YoutubePlayer extends StatefulWidget {

  // Need a youtube link everytime
  final String youtubeLink;
  final String videoID;

  const YoutubePlayer({Key key, this.youtubeLink, this.videoID}) : super(key: key);

  @override 
  _YoutubePlayerState createState() => _YoutubePlayerState();
}

class _YoutubePlayerState extends State<YoutubePlayer> {
  YoutubePlayerController _controller;


  
  


  @override
  void initState() {
    super.initState();

    // Initialize the the youtube controller before the widget is build.
    this._controller = YoutubePlayerController(
      initialVideoId: widget.videoID,
      params: const YoutubePlayerParams(  
        autoPlay: false,
        playsInline: true,
        desktopMode: true,
        showFullscreenButton: true,
        showControls: true,

      )
    );
    _controller.onEnterFullscreen = () {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    log('Entered Fullscreen');
  };
  _controller.onExitFullscreen = () {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    Future.delayed(const Duration(seconds: 1), () {
      _controller.play();
    });
    Future.delayed(const Duration(seconds: 5), () {
      SystemChrome.setPreferredOrientations(DeviceOrientation.values);
    });
    log('Exited Fullscreen');
  };
    
  }

   @override
  Widget build(BuildContext context) {
    YoutubePlayerIFrame player = YoutubePlayerIFrame(controller: _controller);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          YoutubePlayerControllerProvider(
            controller: _controller,
            child: Expanded(child: player,),
          ),
        ],
      ),
    );
  }

 @override
  void deactivate() {
    // Pauses video while navigating to next page.
    _controller.pause();
    super.deactivate();
  }

  @override
  void dispose() {
    _controller.close();
    super.dispose();
  }
}


