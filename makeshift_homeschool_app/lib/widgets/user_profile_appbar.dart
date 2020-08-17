import 'package:flutter/material.dart';
import 'package:makeshift_homeschool_app/screens/user_post.dart';
import 'package:makeshift_homeschool_app/services/auth.dart';
import 'package:provider/provider.dart';

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

    return AppBar(
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
                              onPressed: () async {
                                Navigator.of(context).pop();
                              },
                            ),
                          ),
                          Container(
                            height: screenSize.height * 0.06,
                            width: screenSize.width * 0.85,
                            child: RaisedButton(
                              color: Colors.transparent,
                              child: Text(
                                "See My Posts",
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
                              onPressed: () {
                                Navigator.of(context).pop(); // pop the popup
                                Navigator.of(context)
                                    .pop(); // pop profile screen
                                Navigator.of(context)
                                    .pushReplacementNamed("/login");
                                Provider.of<AuthProvider>(context,
                                        listen: false)
                                    .signOut();
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