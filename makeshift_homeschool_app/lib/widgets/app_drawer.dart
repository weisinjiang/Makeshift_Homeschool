import 'package:flutter/material.dart';
import 'package:makeshift_homeschool_app/services/auth.dart';
import 'package:makeshift_homeschool_app/shared/constants.dart';
import 'package:provider/provider.dart';

class AppDrawer extends StatelessWidget {
  final userData;

  double getLevelAsPercentage(String level) {
    if (level == "Student") {
      return 0.25;
    } else if (level == "Tutor") {
      return 0.50;
    } else if (level == "Teacher") {
      return 0.75;
    }
    return 1.0;
  }

  const AppDrawer({Key key, this.userData}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountName: Text(userData["username"]),
            accountEmail: Text(userData["level"]),
            currentAccountPicture: CircleAvatar(
              backgroundColor: kGreenSecondary,
              child: Text(userData["username"][0]),
            ),
            // decoration: BoxDecoration(
            //   gradient: LinearGradient(
            //       colors: [kGreenSecondary, kGreenSecondary_analogous1],
            //       begin: Alignment.topCenter,
            //       end: Alignment.bottomCenter),
            // ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text("Current Level"),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 40.0,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(color: Colors.black, width: 2)),
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(30)),
                child: LinearProgressIndicator(
                  value: getLevelAsPercentage(userData["level"]),
                  backgroundColor: Colors.grey[300],
                  valueColor: AlwaysStoppedAnimation<Color>(kGreenPrimary),
                  
                ),
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.power_settings_new),
            title: Text("Sign out"),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).popAndPushNamed('/login');
              Provider.of<AuthProvider>(context, listen: false).signOut();
            },
          ),
        ],
      ),
    );
  }
}
