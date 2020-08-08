// keyboardType: TextInputType.multiline,
//   maxLines: null,

//DONE

import 'package:flutter/material.dart';
import 'package:makeshift_homeschool_app/services/auth.dart';
import 'package:makeshift_homeschool_app/services/bootcamp_provider.dart';
import 'package:provider/provider.dart';

class AlternativeMovieEndings extends StatefulWidget {
  @override
  _AlternativeMovieEndingsState createState() =>
      _AlternativeMovieEndingsState();
}

class _AlternativeMovieEndingsState extends State<AlternativeMovieEndings> {
  List<TextEditingController> textController = [
    TextEditingController(),

    /// controller for "What happened?" index0
    TextEditingController(),

    /// controller for "How did it start out?" index1
    TextEditingController(),

    /// controller for "What happened next?" index2
    TextEditingController(),

    /// controller for "How did it end?" index3
    TextEditingController(),

    /// controller for "Why?" index4
    TextEditingController(),

    /// controller for "Why?" index4
  ];

  Future<void> save(BootCampProvider database, String uid, String activityID,
      BuildContext context) async {
    String userReponse = """
    Today I'm questioning ${textController[0].text} plot.\n
    For those of you who don't know ${textController[1].text} is a movie.\n
    The actual plot goes like this:\n
    ${textController[2].text}\n
    This is how I think things should've gone:\n
    ${textController[3].text}\n
    The reason why I think my plot is better is because...\n
    ${textController[4].text}.\n
    I hope you reconsider the plot of ${textController[5].text}!\n
    Thank you for reading!\n
    """;
    textController.forEach((controller) {
      //userReponse.add(controller.text);
    });
    await database.saveToUserProfile(uid, activityID, userReponse);

    Navigator.of(context).pop();
  }

  void dispose() {
    textController.forEach((element) {
      element.dispose();
    });
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var database = Provider.of<BootCampProvider>(context);
    var user = Provider.of<AuthProvider>(context).getUser;
    final screenSize = MediaQuery.of(context).size; // size of the screen

    return Scaffold(
      appBar: AppBar(
        title: Text("Alternative Movie Endings"),
      ),
      body: Container(
        padding: EdgeInsets.all(15),
        height: screenSize.height,
        width: screenSize.width,
        child: Container(
          height: screenSize.height * 0.95,
          child: ListView(
            children: <Widget>[
              /// Image on top

              Image.asset("asset/bootcamp/movie.gif"),

              Row(
                children: [
                  Text("Today I am questioning   "),
                  SizedBox(
                    child: TextFormField(
                      /// add a controller and attach it to this field
                      // keyboardType: TextInputType.multiline,
                      //     maxLines: null,
                      controller: textController[0],
                      decoration: InputDecoration(hintText: "Movie"),
                    ),
                    width: 80,
                  ),
                  Text("  plot."),
                ],
              ),

              SizedBox(
                height: screenSize.height * 0.03,
              ),

              Row(
                children: [
                  Text("For those of you who don't know,   "),
                  SizedBox(
                    child: TextFormField(
                      /// add a controller and attach it to this field
                      // keyboardType: TextInputType.multiline,
                      //     maxLines: null,
                      controller: textController[1],
                      decoration: InputDecoration(hintText: "Movie"),
                    ),
                    width: 80,
                  ),
                ],
              ),

              Text("is a movie."),

              SizedBox(
                height: screenSize.height * 0.03,
              ),

              Text("The actual plot goes like this:"),

              SizedBox(
                child: TextFormField(
                  /// add a controller and attach it to this field
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  controller: textController[2],
                  decoration: InputDecoration(hintText: "Summarize the plot"),
                ),
                width: screenSize.width,
              ),

              SizedBox(
                height: screenSize.height * 0.03,
              ),

              Text("This is how I think things should've gone:"),

              SizedBox(
                child: TextFormField(
                  /// add a controller and attach it to this field
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  controller: textController[3],
                  decoration:
                      InputDecoration(hintText: "Write your alternative plot"),
                ),
                width: screenSize.width,
              ),

              SizedBox(
                height: screenSize.height * 0.03,
              ),

              Text("The reason why I think my plot is better is because..."),

              SizedBox(
                child: TextFormField(
                  /// add a controller and attach it to this field
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  controller: textController[4],
                  decoration: InputDecoration(
                      hintText: "Why is your plot better than the previous?"),
                ),
                width: screenSize.width,
              ),

              SizedBox(
                height: screenSize.height * 0.03,
              ),

              Row(
                children: [
                  Text("I hope you reconsider the plot of   "),
                ],
              ),

              SizedBox(
                child: TextFormField(
                  /// add a controller and attach it to this field
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  controller: textController[5],
                  decoration: InputDecoration(hintText: "Movie"),
                ),
                width: 80,
              ),

              SizedBox(
                height: screenSize.height * 0.03,
              ),

              Text("Thank you for reading!"),

              RaisedButton(
                  child: Text("Save"),
                  onPressed: () async {
                    await save(database, user["uid"],
                        "Alternative Movie Endings", context);
                  })
            ],
          ),
        ),
      ),
    );
  }
}
