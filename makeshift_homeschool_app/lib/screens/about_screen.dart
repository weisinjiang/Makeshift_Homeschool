import 'package:flutter/material.dart';

///Screen that tells the user about Makeshift Homeschool
class AboutScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double screenHeigh = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text("About"),
      ),
      body: Container(
        margin: EdgeInsets.all(10.0),
        height: screenHeigh,
        width: screenWidth,
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
           
            
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
              child: Text("WEquil School", style: TextStyle(fontSize: 40),),
            ),
            SizedBox(height: 20.0,),

            Text(
              "What if kids could teach each other?", 
              style: TextStyle( 
                fontWeight: FontWeight.bold,
                fontSize: 18,
                decoration: TextDecoration.underline,
                )
            ),

            SizedBox(height: 10.0,),

            Text(
              "The WEquil School app is an app that allows kids to learn from kids, making them able to teach other kids! We believe that there are five principles of learning:                                                             \n1. Teach to problems not tools \n2. No grades, iterate and improve \n3. Share and learn with others \n4. Build on strengths, interests and passions \n5. Teaching is a great way to learn. \nThe WEquil School app believes that kids learn better from kids. We also think that people learn by teaching! Students earn confidence by creating value for other students. This gives them the drive to discover more and share with the world.",
               style: TextStyle(
                 height: 1.5,
               ),
               textAlign: TextAlign.center,
               
            ),

            SizedBox(height: 30.0,),

            Text("Thank you for helping grow our community!"),




          ],

        ),
      ),
    );
  }
}
