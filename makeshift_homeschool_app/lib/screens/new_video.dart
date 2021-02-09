import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class NewVideo extends StatefulWidget {
  @override
  _NewVideoState createState() => _NewVideoState();
}

class _NewVideoState extends State<NewVideo> {
  YoutubePlayerController _controller = YoutubePlayerController(
    initialVideoId:
        YoutubePlayer.convertUrlToId("https://youtu.be/V89BOZhJFlI"),
    flags: YoutubePlayerFlags(
      autoPlay: true,
      mute: false,
    ),
  );

  //& TextEditingControllers

  TextEditingController titleTextEditingController =
      new TextEditingController();
  TextEditingController discriptionTextEditingController =
      new TextEditingController();
  TextEditingController youtubeLinkTextEditingController =
      new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          "New Video",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Container(
        color: Colors.black87,
        padding: EdgeInsets.all(10),
        child: ListView(
          children: [
            TextFormField(
              style: simpleTextStyle(),
              decoration: textFieldInput("Title"),
              controller: titleTextEditingController,
            ),
            Divider(
              height: 35,
              color: Colors.white70,
            ),
            TextFormField(
              style: simpleTextStyle(),
              decoration: textFieldInput("Youtube Link"),
              controller: youtubeLinkTextEditingController,
            ),
            SizedBox(
              height: 10,
            ),
            TextFormField(
              maxLines: 5,
              style: simpleTextStyle(),
              decoration: textFieldInput("Discription"),
              controller: discriptionTextEditingController,
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "Preview:",
              style: simpleTextStyle(),
            ),
            SizedBox(
              height: 10,
            ),
            YoutubePlayer(
              controller: _controller,
              liveUIColor: Colors.amber,
            ),
          ],
        ),
      ),
    );
  }
}

//! Widgets

TextStyle simpleTextStyle() {
  return TextStyle(color: Colors.white);
}

InputDecoration textFieldInput(String hint) {
  return InputDecoration(
      hintText: hint,
      hintStyle: TextStyle(color: Colors.white60),
      focusedBorder:
          OutlineInputBorder(borderSide: BorderSide(color: Colors.greenAccent)),
      enabledBorder:
          OutlineInputBorder(borderSide: BorderSide(color: Colors.white60)));
}
