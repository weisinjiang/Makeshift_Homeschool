import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart' as youtube;
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
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  youtube.YoutubePlayerController _controller;
  TextEditingController _idController;
  TextEditingController _seekToController;

  youtube.PlayerState _playerState;
  youtube.YoutubeMetaData _videoMetaData;
  double _volume = 100;
  bool _muted = false;
  bool _isPlayerReady = false;
  

  void listener() {
    if (_isPlayerReady && mounted && !_controller.value.isFullScreen) {
      setState(() {
        _playerState = _controller.value.playerState;
        _videoMetaData = _controller.metadata;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _controller = youtube.YoutubePlayerController(
      initialVideoId: widget.videoID,
      flags: const youtube.YoutubePlayerFlags(  
        mute: false,
        autoPlay: false,
        disableDragSeek: false,
        loop: false,
      )
  
    )..addListener(listener);
    _idController = TextEditingController();
    _seekToController = TextEditingController();
    _videoMetaData = const youtube.YoutubeMetaData();
    _playerState = youtube.PlayerState.unknown;

  }

   @override
  Widget build(BuildContext context) {

    return youtube.YoutubePlayerBuilder(  
      onExitFullScreen: () {
        SystemChrome.setPreferredOrientations(DeviceOrientation.values);
      },

      player: youtube.YoutubePlayer(
        controller: _controller,
        showVideoProgressIndicator: true,
        progressIndicatorColor: Colors.blueAccent,
        onReady: () => _isPlayerReady = true,
      ),
      builder: (contex, player) {
        return Expanded(
          child: player,
        );
      },

 

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
    _controller.dispose();
    _idController.dispose();
    _seekToController.dispose();
    super.dispose();
  }
}


