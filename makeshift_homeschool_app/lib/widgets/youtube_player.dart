import 'package:flutter/material.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';


/// This class creates a way for the app to connect to a Youtube Video.
/// MOBILE: Uses Flutter's InAppView Widget that directly links to a webpage.
///         The youtube link is formatted to be in embed mode, meaning the webpage that pops
///         up is only the video. The comments, playlists, etc are removed.
/// WEB: Uses Youtube's API widget to get the video and display it.
/// 
/// WHY?: Youtube's API only brings up a safari on the mobile version. The video cant be
/// put into a widget. It always pops up a webpage and on exit, you cannot enter it again.
class YoutubePlayerWidget extends StatefulWidget {

  // Need a youtube link everytime
  final String videoID;
  final double height;
  final double width;

  const YoutubePlayerWidget({Key key, this.videoID, this.height, this.width}) : super(key: key);

  @override 
  _YoutubePlayerWidgetState createState() => _YoutubePlayerWidgetState();
}

class _YoutubePlayerWidgetState extends State<YoutubePlayerWidget> {
  YoutubePlayerController _controller; // Used for Web version of the player

  @override
  void initState() {
    super.initState();

    // Web version will use the Youtube Player dependency
    // Mobile uses Flutter's inwebapp view because using the player in ObjectiveC does not work and
    // it just brings up a safari.
    if (kIsWeb) {
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
     
    }
    
  }

   @override
  Widget build(BuildContext context) {
   print("https://www.youtube.com/embed/${widget.videoID}");
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(  
        width: widget.width * 0.90,
        height: widget.height * 0.30,
        child: kIsWeb 
          ? YoutubePlayerIFrame(controller: _controller,)
          :InAppWebView(initialUrl: "https://www.youtube.com/embed/${widget.videoID}",),
      ),
    );
  }


}


