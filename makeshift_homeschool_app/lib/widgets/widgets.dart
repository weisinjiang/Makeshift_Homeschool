import 'package:flutter/material.dart';
import 'package:makeshift_homeschool_app/screens/projectIdeas.dart';
import 'package:makeshift_homeschool_app/services/auth.dart';
import 'package:provider/provider.dart';

TextStyle simpleTextStyle() {
  return TextStyle(color: Colors.white);
}

TextStyle mediumTextStyle() {
  return TextStyle(color: Colors.white, fontSize: 20);
}

TextStyle titleTextStyle() {
  return TextStyle(
      color: Colors.white, fontSize: 35, fontWeight: FontWeight.bold);
}

TextStyle subtitleTextStyle() {
  return TextStyle(
    color: Colors.grey[300],
    fontSize: 20,
  );
}

Drawer mainDrawer(BuildContext context) {
  Map<String, String> userData;
  userData = Provider.of<AuthProvider>(context, listen: false).getUser;
  return Drawer(
    child: Container(
      color: Colors.black87,
      padding: EdgeInsets.all(0),
      child: Column(
        children: [
          UserAccountsDrawerHeader(
            decoration: BoxDecoration(color: Colors.black),
            accountName: Text("${userData["username"]}"),
            accountEmail: Text("${userData["email"]}"),
            currentAccountPicture: CircleAvatar(
              backgroundColor: Colors.blue[800],
              child: Text(
                "${userData["username"][0]}",
                style: TextStyle(fontSize: 20),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(10),
            child: Column(
              children: [
                ListTile(
                  title: Text(
                    "Learn",
                    style: TextStyle(color: Colors.white),
                  ),
                  leading: Icon(
                    Icons.book,
                    color: Colors.white,
                  ),
                ),
                ListTile(
                  title: Text(
                    "Teach",
                    style: TextStyle(color: Colors.white),
                  ),
                  leading: Icon(
                    Icons.border_color,
                    color: Colors.white,
                  ),
                ),
                ListTile(
                  title: Text(
                    "Bootcamp",
                    style: TextStyle(color: Colors.white),
                  ),
                  leading: Icon(
                    Icons.fireplace,
                    color: Colors.white,
                  ),
                ),
                ListTile(
                  title: Text(
                    "Review Lessons",
                    style: TextStyle(color: Colors.white),
                  ),
                  leading: Icon(
                    Icons.check_box,
                    color: Colors.white,
                  ),
                ),
                ListTile(
                  title: Text(
                    "Parent Page",
                    style: TextStyle(color: Colors.white),
                  ),
                  leading: Icon(
                    Icons.chat,
                    color: Colors.white,
                  ),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProjectIdeas(),
                        ));
                  },
                ),
                Divider(
                  color: Colors.white,
                ),
                ListTile(
                  title: Text(
                    "Logout",
                    style: TextStyle(color: Colors.white),
                  ),
                  leading: Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    ),
  );
}
