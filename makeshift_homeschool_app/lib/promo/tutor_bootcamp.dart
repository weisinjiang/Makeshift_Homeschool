import 'package:flutter/material.dart';
import 'package:makeshift_homeschool_app/screens/root_screen.dart';


///
//! First set of slides before the first question
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
            child: Center(child: Image.asset("asset/tutor_slides/tutorslide1.png")),
            color: Colors.white,
          ),
          Container(
            child: Center(child: Image.asset("asset/tutor_slides/tutorslide2.png")),
            color: Colors.white,
          ),
          Container(
            color: Colors.white,
            child: Column(  
              children: [
                SizedBox(height: 91,),
                Center(child: Image.asset("asset/tutor_slides/tutorslide3.png")),
                RaisedButton(  
                  onPressed: () {Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => TutorBootcampQuestion1()));},
                  color: Colors.greenAccent,
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
//! First question
/// 


class TutorBootcampQuestion1 extends StatelessWidget {
  @override

  //! Alert Dialog to tell you if you were correct
  
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

    //! set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Correct! 😃", style: TextStyle(color: Colors.green)),
      content: Text("Your answer is correct! Would you like to continue?"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    //! show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  //! Alert Dialog to tell you if you were incorrect

  showAlertDialog2(BuildContext context) {
    
    Widget continueButton = FlatButton(
      child: Text("Continue"),
      onPressed:  () {Navigator.of(context).pop();},
    );

    //! set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Wrong 💩", style: TextStyle(color: Colors.red)),
      content: Text("Your answer is incorrect. Try again!"),
      actions: [
        continueButton,
      ],
    );

    //! show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }


  //! Question and buttons to answer
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size; // size of the screen
    return Scaffold(  
      body: Container(
        child: Center(
          child: Column(  
                
                children: [
                  SizedBox(height: screenSize.height/25,),
                  Align(
                    alignment: Alignment.topRight,
                    child: Column(
                      children: [
                        RaisedButton(  
                          onPressed: () {Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => TutorBootcamp1()));}, 
                          color: Colors.greenAccent,
                          child: Text("Back"),
                        ),

                        SizedBox(width: screenSize.width/3),

                      ],
                    ),
                  ),
                  
                  SizedBox(height: 150,),

                  Row(
                    children: [
                      SizedBox(width: screenSize.width/7,),
                      Text("Question 1:", style: TextStyle(fontSize: 20, color: Colors.black38, fontWeight: FontWeight.bold),),
                    ],
                  ), // Question

                  SizedBox(height: screenSize.height/50,),

                  Text("What is an introduction?", style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),), // Question
                  SizedBox(height: 50,),



                  //! Answers !\\
                  
                  RaisedButton(  
                    elevation: 5,
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                      side: BorderSide(color: Colors.black, width: 1)
                    ),
                    child: SizedBox(child: Text("How you end a post", textAlign: TextAlign.center,), width: screenSize.width/1.7,),
                    onPressed: () {showAlertDialog2(context);}, // Says you were incorrect
                  ),
                  RaisedButton(  
                    elevation: 5,
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                      side: BorderSide(color: Colors.black, width: 1)
                    ),
                          child: SizedBox(child: Text("How you start a post", textAlign: TextAlign.center,), width: screenSize.width/1.7,),
                          onPressed: () {showAlertDialog1(context);}, // Says you were correct
                        ),
                  RaisedButton(  
                    elevation: 5,
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                      side: BorderSide(color: Colors.black, width: 1,)
                    ),
                    child: SizedBox(child: Text("Where you say hello", textAlign: TextAlign.center,), width: screenSize.width/1.7,),
                    onPressed: () {showAlertDialog2(context);}, // Says you were incorrect
                  ),
                  RaisedButton(  
                    elevation: 5,
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                      side: BorderSide(color: Colors.black, width: 1)
                    ),
                    child: SizedBox(child: Text("Where you put a picture", textAlign: TextAlign.center,), width: screenSize.width/1.7,),
                    onPressed: () {showAlertDialog2(context);}, // Says you were incorrect
                  ),

                  
                ],
              ),
        ),
      ),
    );
  }
  
}


///
//! Next set of slides before second question
/// 

class TutorBootcamp2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size; // size of the screen
    
    return Scaffold(
      body: PageView(  
        scrollDirection: Axis.horizontal,
        children: [
          Container(
            color: Colors.white,
            child: Column(  
              children: [
                SizedBox(height: 91,),
                Container(
                  child: Center(child: Image.asset("asset/tutor_slides/tutorslide4.png")),
                  color: Colors.white,
                ),
                Row(
                  children: [
                    SizedBox(width: screenSize.width/4,),
                    RaisedButton(  
                      onPressed: () {Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => TutorBootcampQuestion1()));}, 
                      color: Colors.greenAccent,
                      child: Text("Back"),
                    ),
                    SizedBox(width: screenSize.width/50,),
                    RaisedButton(  
                      onPressed: () {Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => TutorBootcampQuestion2()));}, 
                      color: Colors.greenAccent,
                      child: Text("Next"),
                    ),
                  ],
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


//!//!//!//!//!//!//!//!
//!  Second Question //!
//!//!//!//!//!//!//!//!

class TutorBootcampQuestion2 extends StatelessWidget {
  @override

  //! Alert Dialog to tell you if you were correct
  
  showAlertDialog1(BuildContext context) {

    // set up the buttons
    Widget cancelButton = FlatButton(
      child: Text("Cancel"),
      onPressed:  () {Navigator.of(context).pop();},
    );
    Widget continueButton = FlatButton(
      child: Text("Continue"),
      onPressed:  () {Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => TutorBootcamp3()));},
    );

    //! set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Correct! 😃", style: TextStyle(color: Colors.green)),
      content: Text("Your answer is correct! Would you like to continue?"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    //! show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  //! Alert Dialog to tell you if you were incorrect

  showAlertDialog2(BuildContext context) {
    
    Widget continueButton = FlatButton(
      child: Text("Continue"),
      onPressed:  () {Navigator.of(context).pop();},
    );

    //! set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Wrong 💩", style: TextStyle(color: Colors.red)),
      content: Text("Your answer is incorrect. Try again!"),
      actions: [
        continueButton,
      ],
    );

    //! show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }


  //! Question and buttons to answer
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size; // size of the screen
    return Scaffold(  
      body: Container(
        child: Center(
          child: Column(  
                
                children: [
                  SizedBox(height: screenSize.height/25,),
                  Align(
                    alignment: Alignment.topRight,
                    child: Column(
                      children: [
                        RaisedButton(  
                          onPressed: () {Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => TutorBootcamp2()));}, 
                          color: Colors.greenAccent,
                          child: Text("Back"),
                        ),

                        SizedBox(width: screenSize.width/3),

                      ],
                    ),
                  ),
                  
                  SizedBox(height: 150,),

                  Row(
                    children: [
                      SizedBox(width: screenSize.width/4.1,),
                      Text("Question 2:", style: TextStyle(fontSize: 20, color: Colors.black38, fontWeight: FontWeight.bold),),
                    ],
                  ), // Question

                  SizedBox(height: screenSize.height/50,),

                  Text("What is the body?", style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),), // Question
                  SizedBox(height: 50,),



                  //! Answers !\\
                  
                  RaisedButton(  
                    elevation: 5,
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                      side: BorderSide(color: Colors.black, width: 1)
                    ),
                    child: SizedBox(child: Text("The second paragraph", textAlign: TextAlign.center,), width: screenSize.width/1.7,),
                    onPressed: () {showAlertDialog2(context);}, // Says you were incorrect
                  ),
                  
                  RaisedButton(  
                    elevation: 5,
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                      side: BorderSide(color: Colors.black, width: 1,)
                    ),
                    child: SizedBox(child: Text("Where you say goodbye", textAlign: TextAlign.center,), width: screenSize.width/1.7,),
                    onPressed: () {showAlertDialog2(context);}, // Says you were incorrect
                  ),

                  RaisedButton(  
                    elevation: 5,
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                      side: BorderSide(color: Colors.black, width: 1)
                    ),
                          child: SizedBox(child: Text("You adress your three main points", textAlign: TextAlign.center,), width: screenSize.width/1.7,),
                          onPressed: () {showAlertDialog1(context);}, // Says you were correct
                        ),

                  RaisedButton(  
                    elevation: 5,
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                      side: BorderSide(color: Colors.black, width: 1)
                    ),
                    child: SizedBox(child: Text("The place where you put a video", textAlign: TextAlign.center,), width: screenSize.width/1.7,),
                    onPressed: () {showAlertDialog2(context);}, // Says you were incorrect
                  ),

                  
                ],
              ),
        ),
      ),
    );
  }
  
}


///
//! Next set of slides before third question
/// 

class TutorBootcamp3 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size; // size of the screen
    
    return Scaffold(
      body: PageView(  
        scrollDirection: Axis.horizontal,
        children: [
          Container(
            color: Colors.white,
            child: Column(  
              children: [
                SizedBox(height: 91,),
                Container(
                  child: Center(child: Image.asset("asset/tutor_slides/tutorslide5.png")),
                  color: Colors.white,
                ),
                Row(
                  children: [
                    SizedBox(width: screenSize.width/4,),
                    RaisedButton(  
                      onPressed: () {Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => TutorBootcampQuestion2()));}, 
                      color: Colors.greenAccent,
                      child: Text("Back"),
                    ),
                    SizedBox(width: screenSize.width/50,),
                    RaisedButton(  
                      onPressed: () {Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => TutorBootcampQuestion3()));}, 
                      color: Colors.greenAccent,
                      child: Text("Next"),
                    ),
                  ],
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



//!//!//!//!//!//!//!//!//!
//!    Third Question   //!
//!//!//!//!//!//!//!//!//!

class TutorBootcampQuestion3 extends StatelessWidget {
  @override

  //! Alert Dialog to tell you if you were correct
  
  showAlertDialog1(BuildContext context) {

    // set up the buttons
    Widget cancelButton = FlatButton(
      child: Text("Cancel"),
      onPressed:  () {Navigator.of(context).pop();},
    );
    Widget continueButton = FlatButton(
      child: Text("Continue"),
      onPressed:  () {Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => TutorBootcamp4()));},
    );

    //! set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Correct! 😃", style: TextStyle(color: Colors.green)),
      content: Text("Your answer is correct! Would you like to continue?"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    //! show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  //! Alert Dialog to tell you if you were incorrect

  showAlertDialog2(BuildContext context) {
    
    Widget continueButton = FlatButton(
      child: Text("Continue"),
      onPressed:  () {Navigator.of(context).pop();},
    );

    //! set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Wrong 💩", style: TextStyle(color: Colors.red)),
      content: Text("Your answer is incorrect. Try again!"),
      actions: [
        continueButton,
      ],
    );

    //! show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }


  //! Question and buttons to answer
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size; // size of the screen
    return Scaffold(  
      body: Container(
        child: Center(
          child: Column(  
                
                children: [
                  SizedBox(height: screenSize.height/25,),
                  Align(
                    alignment: Alignment.topRight,
                    child: Column(
                      children: [
                        RaisedButton(  
                          onPressed: () {Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => TutorBootcamp3()));}, 
                          color: Colors.greenAccent,
                          child: Text("Back"),
                        ),

                        SizedBox(width: screenSize.width/3),

                      ],
                    ),
                  ),
                  
                  SizedBox(height: 150,),

                  Row(
                    children: [
                      SizedBox(width: screenSize.width/6.8,),
                      Text("Question 3:", style: TextStyle(fontSize: 20, color: Colors.black38, fontWeight: FontWeight.bold),),
                    ],
                  ), // Question

                  SizedBox(height: screenSize.height/50,),

                  Text("What is the Conclusion?", style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),), // Question
                  SizedBox(height: 50,),



                  //! Answers !\\
                  
                  RaisedButton(  
                    elevation: 5,
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                      side: BorderSide(color: Colors.black, width: 1)
                    ),
                    child: SizedBox(child: Text("The beginning", textAlign: TextAlign.center,), width: screenSize.width/1.7,),
                    onPressed: () {showAlertDialog2(context);}, // Says you were incorrect
                  ),

                  RaisedButton(  
                    elevation: 5,
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                      side: BorderSide(color: Colors.black, width: 1)
                    ),
                          child: SizedBox(child: Text("The ending of your post", textAlign: TextAlign.center,), width: screenSize.width/1.7,),
                          onPressed: () {showAlertDialog1(context);}, // Says you were correct
                        ),
                  
                  RaisedButton(  
                    elevation: 5,
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                      side: BorderSide(color: Colors.black, width: 1,)
                    ),
                    child: SizedBox(child: Text("Your picture", textAlign: TextAlign.center,), width: screenSize.width/1.7,),
                    onPressed: () {showAlertDialog2(context);}, // Says you were incorrect
                  ),

                  RaisedButton(  
                    elevation: 5,
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                      side: BorderSide(color: Colors.black, width: 1)
                    ),
                    child: SizedBox(child: Text("The place where you say hello", textAlign: TextAlign.center,), width: screenSize.width/1.7,),
                    onPressed: () {showAlertDialog2(context);}, // Says you were incorrect
                  ),

                  
                ],
              ),
        ),
      ),
    );
  }
  
}


///
//! Next set of slides before forth question
/// 

class TutorBootcamp4 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size; // size of the screen
    
    return Scaffold(
      body: PageView(  
        scrollDirection: Axis.horizontal,
        children: [
          Container(
            color: Colors.white,
            child: Column(  
              children: [
                SizedBox(height: 91,),
                Container(
                  child: Center(child: Image.asset("asset/tutor_slides/tutorslide6.png")),
                  color: Colors.white,
                ),
                Row(
                  children: [
                    SizedBox(width: screenSize.width/4,),
                    RaisedButton(  
                      onPressed: () {Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => TutorBootcampQuestion3()));}, 
                      color: Colors.greenAccent,
                      child: Text("Back"),
                    ),
                    SizedBox(width: screenSize.width/50,),
                    RaisedButton(  
                      onPressed: () {Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => TutorBootcampQuestion4()));}, 
                      color: Colors.greenAccent,
                      child: Text("Next"),
                    ),
                  ],
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




//!//!//!//!//!//!//!//!//!
//!    Forth Question   //!
//!//!//!//!//!//!//!//!//!

class TutorBootcampQuestion4 extends StatelessWidget {
  @override

  //! Alert Dialog to tell you if you were correct
  
  showAlertDialog1(BuildContext context) {

    // set up the buttons
    Widget cancelButton = FlatButton(
      child: Text("Cancel"),
      onPressed:  () {Navigator.of(context).pop();},
    );
    Widget continueButton = FlatButton(
      child: Text("Continue"),
      onPressed:  () {Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => TutorBootcamp5()));},
    );

    //! set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Correct! 😃", style: TextStyle(color: Colors.green)),
      content: Text("Your answer is correct! Would you like to continue?"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    //! show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  //! Alert Dialog to tell you if you were incorrect

  showAlertDialog2(BuildContext context) {
    
    Widget continueButton = FlatButton(
      child: Text("Continue"),
      onPressed:  () {Navigator.of(context).pop();},
    );

    //! set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Wrong 💩", style: TextStyle(color: Colors.red)),
      content: Text("Your answer is incorrect. Try again!"),
      actions: [
        continueButton,
      ],
    );

    //! show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }


  //! Question and buttons to answer
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size; // size of the screen
    return Scaffold(  
      body: Container(
        child: Center(
          child: Column(  
                
                children: [
                  SizedBox(height: screenSize.height/25,),
                  Align(
                    alignment: Alignment.topRight,
                    child: Column(
                      children: [
                        RaisedButton(  
                          onPressed: () {Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => TutorBootcamp4()));}, 
                          color: Colors.greenAccent,
                          child: Text("Back"),
                        ),

                        SizedBox(width: screenSize.width/3),

                      ],
                    ),
                  ),
                  
                  SizedBox(height: 150,),

                  Row(
                    children: [
                      SizedBox(width: screenSize.width/4,),
                      Text("Question 4:", style: TextStyle(fontSize: 20, color: Colors.black38, fontWeight: FontWeight.bold),),
                    ],
                  ), // Question

                  SizedBox(height: screenSize.height/50,),

                  Text("What is the Quiz?", style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),), // Question
                  SizedBox(height: 50,),



                  //! Answers !\\
                  
                  RaisedButton(  
                    elevation: 5,
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                      side: BorderSide(color: Colors.black, width: 1)
                    ),
                    child: SizedBox(child: Text("Where you make a video", textAlign: TextAlign.center,), width: screenSize.width/1.7,),
                    onPressed: () {showAlertDialog2(context);}, // Says you were incorrect
                  ),
                  
                  RaisedButton(  
                    elevation: 5,
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                      side: BorderSide(color: Colors.black, width: 1,)
                    ),
                    child: SizedBox(child: Text("The place where you conclude", textAlign: TextAlign.center,), width: screenSize.width/1.7,),
                    onPressed: () {showAlertDialog2(context);}, // Says you were incorrect
                  ),

                  RaisedButton(  
                    elevation: 5,
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                      side: BorderSide(color: Colors.black, width: 1)
                    ),
                    child: SizedBox(child: Text("You intruduce you post", textAlign: TextAlign.center,), width: screenSize.width/1.7,),
                    onPressed: () {showAlertDialog2(context);}, // Says you were incorrect
                  ),

                  RaisedButton(  
                    elevation: 5,
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                      side: BorderSide(color: Colors.black, width: 1)
                    ),
                          child: SizedBox(child: Text("Questions about each body paragraph", textAlign: TextAlign.center,), width: screenSize.width/1.7,),
                          onPressed: () {showAlertDialog1(context);}, // Says you were correct
                        ),

                  
                ],
              ),
        ),
      ),
    );
  }
  
}



///
//! End of bootcamp
/// 

class TutorBootcamp5 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size; // size of the screen
    
    return Scaffold(
      body: PageView(  
        scrollDirection: Axis.horizontal,
        children: [
          Container(
            color: Colors.white,
            child: Column(  
              children: [
                SizedBox(height: 91,),
                Container(
                  child: Center(child: Image.asset("asset/tutor_slides/tutorslide7.png")),
                  color: Colors.white,
                ),
                Row(
                  children: [
                    SizedBox(width: screenSize.width/4,),
                    RaisedButton(  
                      onPressed: () {Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => TutorBootcampQuestion4()));}, 
                      color: Colors.greenAccent,
                      child: Text("Back"),
                    ),
                    SizedBox(width: screenSize.width/50,),
                    RaisedButton(  
                      onPressed: () {Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => RootScreen()));}, 
                      color: Colors.greenAccent,
                      child: Text("Next"),
                    ),
                  ],
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