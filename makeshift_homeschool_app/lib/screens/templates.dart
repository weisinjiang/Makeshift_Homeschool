import 'package:flutter/material.dart';
import 'package:makeshift_homeschool_app/screens/new_post_screen.dart';
import 'package:makeshift_homeschool_app/shared/slide_transition.dart';
import 'package:makeshift_homeschool_app/widgets/widgets.dart';

class Templates extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: mainAppBar(),
      body: Container(
        color: Colors.black87,
        padding: EdgeInsets.all(15),
        child: ListView(
          children: [
            ListTile(
              tileColor: Colors.grey[600],
              title: Text(
                "Article",
                style: simpleTextStyle(),
              ),
              leading: Icon(
                Icons.edit,
                color: Colors.white,
              ),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Topics(),
                    ));
              },
            ),
            SizedBox(
              height: 10,
            ),
            ListTile(
              tileColor: Colors.grey[600],
              title: Text(
                "Video",
                style: simpleTextStyle(),
              ),
              leading: Icon(
                Icons.video_library,
                color: Colors.white,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            ListTile(
              tileColor: Colors.grey[600],
              title: Text(
                "Stop Motion",
                style: simpleTextStyle(),
              ),
              leading: Icon(
                Icons.video_call_outlined,
                color: Colors.white,
              ),
            )
          ],
        ),
      ),
    );
  }
}

class Topics extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: mainAppBar(),
      body: Container(
        color: Colors.black87,
        padding: EdgeInsets.all(15),
        child: ListView(
          children: [
            ListTile(
              tileColor: Colors.grey[600],
              title: Text(
                "Technology",
                style: simpleTextStyle(),
              ),
              leading: Icon(
                Icons.computer,
                color: Colors.white,
              ),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Questions(),
                    ));
              },
            ),
            SizedBox(
              height: 10,
            ),
            ListTile(
              tileColor: Colors.grey[600],
              title: Text(
                "Science",
                style: simpleTextStyle(),
              ),
              leading: Icon(
                Icons.bubble_chart,
                color: Colors.white,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            ListTile(
              tileColor: Colors.grey[600],
              title: Text(
                "Math",
                style: simpleTextStyle(),
              ),
              leading: Icon(
                Icons.plus_one,
                color: Colors.white,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            ListTile(
              tileColor: Colors.grey[600],
              title: Text(
                "Statistics",
                style: simpleTextStyle(),
              ),
              leading: Icon(
                Icons.timeline,
                color: Colors.white,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            ListTile(
              tileColor: Colors.grey[600],
              title: Text(
                "Art",
                style: simpleTextStyle(),
              ),
              leading: Icon(
                Icons.brush,
                color: Colors.white,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            ListTile(
              tileColor: Colors.grey[600],
              title: Text(
                "History",
                style: simpleTextStyle(),
              ),
              leading: Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Questions extends StatefulWidget {
  @override
  _QuestionsState createState() => _QuestionsState();
}

class _QuestionsState extends State<Questions> {
  @override
  Widget build(BuildContext context) {
    bool _hasBeenPressed = false;
    return Scaffold(
      appBar: mainAppBar(),
      body: Container(
        padding: EdgeInsets.all(15),
        child: ListView(
          children: [
            FlatButton(
              child: new Text('Change Color'),
              textColor: Colors.white,
              // 2
              color: _hasBeenPressed ? Colors.blue : Colors.black,
              // 3
              onPressed: () => {
                setState(() {
                  _hasBeenPressed = !_hasBeenPressed;
                })
              },
            ),
            Text(
              "What is it?\nHow does it work?\nWhat problem does it solve?\nHow is it different from previous methods?\nHow is it affecting us now?\nHow will it affect us in the future?\nWhat are the practicle use cases?\nWhat is the price?\nDo you think the proce will lower?\nWhat materials does it need to be made?\nIs it hardware or software or both?\nHow can it be improved?\nWhat companies are producing this product?",
              style: mediumTextStyle(),
            ),
          ],
        ),
      ),
      persistentFooterButtons: [
        Container(
          padding: EdgeInsets.all(10),
          child: FlatButton(
            onPressed: () {
              Navigator.push(
                  context,
                  SlideLeftRoute(
                      screen: NewPostScreen(
                    isEditing: false,
                    postData: null,
                  )));
            },
            color: Colors.blue,
            child: Text("Continue"),
          ),
        ),
      ],
    );
  }
}
