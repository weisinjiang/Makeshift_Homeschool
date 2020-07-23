import 'package:flutter/material.dart';
import 'package:makeshift_homeschool_app/services/auth.dart';
import 'package:makeshift_homeschool_app/shared/constants.dart';
import 'package:provider/provider.dart';

class AppDrawer extends StatelessWidget {
  final userData;

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
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [kGreenSecondary, kGreenSecondary_analogous1],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter),
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
