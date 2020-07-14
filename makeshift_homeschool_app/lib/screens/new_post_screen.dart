import 'package:flutter/material.dart';
import 'package:makeshift_homeschool_app/shared/constants.dart';

class NewPostScreen extends StatefulWidget {
  @override
  _NewPostScreenState createState() => _NewPostScreenState();
}

class _NewPostScreenState extends State<NewPostScreen> {
  Map<String, Widget> userPostManager = {
    "Title1": Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        decoration: const InputDecoration(
          prefixIcon: Icon(Icons.title),
          hintText: "Title",
          border: OutlineInputBorder(borderRadius: BorderRadius.vertical()),
        ),
        validator: null,
        onSaved: null,
      ),
    ),
    "Paragraph1": Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        keyboardType: TextInputType.emailAddress,
        decoration: const InputDecoration(
          prefixIcon: Icon(Icons.email),
          hintText: "Email",
          border: OutlineInputBorder(borderRadius: BorderRadius.vertical()),
        ),
        validator: null,
        onSaved: null,
      ),
    ),
  }; // Tracks titles and paragraphs
  // Users can add titles and paragraphs to their post, this manages and tracks which is which

  int titleCount = 1; // Posts will always have at least 1 item already
  int paragraphCount = 1;

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text("What are you teaching, today?"),
        elevation: 0.0,
        backgroundColor: kGreenSecondary_analogous2,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [kGreenSecondary_analogous2, kGreenSecondary_analogous1],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter),
        ),
        height: screenHeight,
        width: screenWidth,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Form(  

                child: Column(
                  children: userPostManager.values.toList(),
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
