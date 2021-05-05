import 'package:flutter/material.dart';

Widget buildStudentProfile(
    BuildContext context, String profilepicture, String username, String uid) {
  return Container(
    child: InkWell(
      child: Center(
        child: Column(
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(profilepicture),
            ),
            Text(username)
          ],
        ),
      ),
    ),
  );
}
