import 'package:flutter/material.dart';
import 'package:makeshift_homeschool_app/services/auth.dart';
import 'package:makeshift_homeschool_app/shared/constants.dart';
import 'package:makeshift_homeschool_app/shared/exportShared.dart';
import 'package:makeshift_homeschool_app/widgets/activity_button.dart';
import 'package:provider/provider.dart';

/// Builds the main screen where the user can pick what activities they want to
/// do: Study, Teach
class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var auth = Provider.of<AuthProvider>(context);
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;

    return FutureBuilder(
      future: auth.getUserInformation(),
      builder: (context, snapshot) {
          if (snapshot.hasData) {
          var userData = snapshot.data;
          return Scaffold(
            appBar: AppBar(
              // title: Text("Hi, Testing!"),
              title: Text("Hi, ${userData["username"]}!"),
            ),

            body: SafeArea( // Safe Area to prevent widgets
              child: Container(
                // decoration: BoxDecoration(  
                //   gradient: LinearGradient(
                //     colors: [kGreenPrimary_light1,kGreenPrimary],
                //     begin: Alignment.topLeft,
                //     end: Alignment.bottomRight
                //   ),
                // ),
                color: kGreenSecondary,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[

                    Container(
                      height: screenHeight * 0.25,
                      width: screenWidth,
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Image.asset('asset/images/greet.png'),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ActivityButton(
                        color: kGreenSecondary_analogous2,
                        height: screenHeight * 0.20,
                        width: screenWidth,
                        function: () {},
                        name: "Boot Camp",
                        imageLocation: "asset/images/campFire.png",
                      ),
                    ),

                    FittedBox(

                        child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[

                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ActivityButton(
                            color: kGreenPrimary,
                            height: screenHeight * 0.20,
                            width: screenWidth/2,
                            function: () {},
                            name: "Study",
                            imageLocation: "asset/images/books.png",
                        ),
                          ),



                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ActivityButton(
                            color: kGreenPrimary,
                            height: screenHeight * 0.20,
                            width: screenWidth/2,
                            function: () {},
                            name: "Teach",
                            imageLocation: "asset/images/teach.png",
                          ),
                        ),
                        ],
                      ),
                    )

                    
                    

                  ],
                ),
              ),
            )
          );
        } else {
          return LoadingScreen();
        }
      },
    );
  }
}
