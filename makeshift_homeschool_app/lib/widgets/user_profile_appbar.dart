import 'package:flutter/material.dart';
import 'package:makeshift_homeschool_app/screens/edit_profile_screen.dart';
import 'package:makeshift_homeschool_app/screens/user_post.dart';
import 'package:makeshift_homeschool_app/services/auth.dart';
import 'package:provider/provider.dart';

/*
  Generates the appbar for the Profile screen and list of actions that
  users can perform.
*/
class UserProfileAppBar extends StatelessWidget implements PreferredSizeWidget {
  const UserProfileAppBar({
    Key key,
    @required final this.screenSize,
    this.appBar,
  }) : super(key: key);

  final AppBar appBar;
  final Size screenSize;

  @override
  Size get preferredSize => Size.fromHeight(appBar.preferredSize.height);

  @override
  Widget build(BuildContext context) {
    AuthProvider authProvider =
        Provider.of<AuthProvider>(context, listen: false);
    Map<String, String> userData = authProvider.getUser;

    return AppBar(
      backgroundColor: Colors.cyan,
      elevation: 0.0,
      title: Text("Profile"),
      actions: <Widget>[
        IconButton(
            icon: Icon(Icons.more_horiz),
            onPressed: () {
              showModalBottomSheet(
                  isDismissible: true,
                  backgroundColor: Colors.transparent,
                  context: context,
                  builder: (context) {
                    return Container(
                      height: screenSize.height * 0.40,
                      child: Column(
                        //crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          Container(
                            height: screenSize.height * 0.06,
                            width: screenSize.width * 0.85,
                            child: RaisedButton(
                              color: Colors.transparent,
                              child: Text(
                                "Edit Profile",
                                style: TextStyle(
                                    color: Colors.blue,
                                    fontWeight: FontWeight.bold),
                              ),
                              onPressed: () {
                                Navigator.of(context).pop();
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => EditProfileScreen(
                                            currentData: userData)));
                                
                              },
                            ),
                          ),
                          Container(
                            height: screenSize.height * 0.06,
                            width: screenSize.width * 0.85,
                            child: RaisedButton(
                              color: Colors.transparent,
                              child: Text(
                                "My Posts",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                              onPressed: () {
                                Navigator.of(context).pop();
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => UserPosts()));
                              },
                            ),
                          ),
                          Container(
                            height: screenSize.height * 0.06,
                            width: screenSize.width * 0.85,
                            child: RaisedButton(
                              color: Colors.transparent,
                              child: Text(
                                "My Drafts",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                              onPressed: () {
                                Navigator.of(context).pop();
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => UserPosts()));
                              },
                            ),
                          ),

                          Container(
                            height: screenSize.height * 0.06,
                            width: screenSize.width * 0.85,
                            child: RaisedButton(
                              color: Colors.transparent,
                              child: Text(
                                "Sign Out",
                                style: TextStyle(
                                    color: Colors.red,
                                    fontWeight: FontWeight.bold),
                              ),
                              onPressed: () async {
                                Navigator.of(context).pop(); // pop the popup
                                // pop until the stack is the first index
                                Navigator.of(context)
                                    .popUntil((route) => route.isFirst);
                                // signout so Provider can swap the screen
                                await authProvider.signOut();
                              },
                            ),
                          ),
                        ],
                      ),
                    );
                  });
            })
      ],
    );
  }
}
