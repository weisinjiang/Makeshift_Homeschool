import 'package:flutter/material.dart';


/// 
/// First set of slides before the first question
/// 

class TutorBootcamp1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size; // size of the screen
    return Scaffold(
      body: PageView(  
        scrollDirection: Axis.horizontal,
        children: [
          Container(
            child: SizedBox(child: Image.asset("asset/tutor_slides/congrats.gif", width: screenSize.width,), width: screenSize.width, height: screenSize.height,),
            color: Colors.white,
          ),
          Container(
            child: Center(child: Image.asset("asset/tutor_slides/tutorslide1.png")),
            color: Colors.white,
          ),
          Container(
            color: Colors.greenAccent,
            child: Column(  
              children: [
                SizedBox(height: 200,),
                Text("Page 3"),
                RaisedButton(  
                  onPressed: () {Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => TutorBootcampQuestion1()));},
                  color: Colors.red,
                  child: Text("Next Page"),
                ),
              ],
            )
          ),
        ],
        pageSnapping: true,
      ),
    );
  }
  
}

/// 
/// First question
/// 


class TutorBootcampQuestion1 extends StatelessWidget {
  @override

  /// Alert Dialog to tell you if you were correct
  
  showAlertDialog1(BuildContext context) {

    // set up the buttons
    Widget cancelButton = FlatButton(
      child: Text("Cancel"),
      onPressed:  () {Navigator.of(context).pop();},
    );
    Widget continueButton = FlatButton(
      child: Text("Continue"),
      onPressed:  () {Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => TutorBootcamp2()));},
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Correct!"),
      content: Text("Your answer is correct! Would you like to continue?"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  /// Alert Dialog to tell you if you were incorrect

  showAlertDialog2(BuildContext context) {
    
    Widget continueButton = FlatButton(
      child: Text("Continue"),
      onPressed:  () {Navigator.of(context).pop();},
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Wrong"),
      content: Text("Your answer is incorrect. Try again!"),
      actions: [
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }


  /// Question and buttons to answer
  Widget build(BuildContext context) {
    return Scaffold(  
      appBar: AppBar(title: Text("qUeStIoN OnE"),),
      body: Center(
        child: Column(  
                children: [
                  SizedBox(height: 150,),
                  Text("QuEsTiOn fOr yOu, wHaT iS aN iNtRoDuCtIon?"), // Question
                  SizedBox(height: 50,),



                  /// Answers
                  RaisedButton(  
                    child: Text("How you start a post"),
                    onPressed: () {showAlertDialog1(context);}, // Says you were correct
                  ),
                  RaisedButton(  
                    child: Text("Where you say Goodbye"),
                    onPressed: () {showAlertDialog2(context);}, // Says you were incorrect
                  ),
                  RaisedButton(  
                    child: Text("You play with rubber duckies"),
                    onPressed: () {showAlertDialog2(context);}, // Says you were incorrect
                  ),
                  RaisedButton(  
                    child: Text("La la la la la"),
                    onPressed: () {showAlertDialog2(context);}, // Says you were incorrect
                  ),

                  RaisedButton(  
                  onPressed: () {Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => TutorBootcamp1()));}, 
                  color: Colors.orange,
                  child: Text("Back"),
                ),
                ],
              ),
        ),
    );
  }
  
}


///
/// Next set of slides before second question
/// 

class TutorBootcamp2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      body: PageView(  
        scrollDirection: Axis.horizontal,
        children: [
          Container(
            color: Colors.pink,
            child: Column(  
              children: [
                SizedBox(height: 200,),
                Text("Page 5"),
                RaisedButton(  
                  onPressed: () {Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => TutorBootcampQuestion1()));}, 
                  color: Colors.orange,
                  child: Text("Back"),
                ),
              ],
            )
          ),
          Container(
            child: Center(child: Text("Page 6")),
            color: Colors.yellow,
          ),
          Container(
            color: Colors.pink,
            child: Column(  
              children: [
                SizedBox(height: 200,),
                Text("Page 7"),
                RaisedButton(  
                  onPressed: () {}, // Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => TutorBootcampQuestion1()));
                  color: Colors.red,
                  child: Text("Next Page"),
                ),
              ],
            )
          ),
        ],
        pageSnapping: true,
      ),
    );
  }
  
}