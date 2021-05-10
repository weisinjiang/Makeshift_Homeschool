import 'package:flutter/material.dart';

///Screen that tells the user about WEquil school
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
              child: Image.asset('asset/images/logo.png'),
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
              "The Makeshift Homeschool app will allow kids to teach, and learn with"
               "each other. To grow as a team, to get stronger as a team, and to"
               "inspire as a team.",
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
