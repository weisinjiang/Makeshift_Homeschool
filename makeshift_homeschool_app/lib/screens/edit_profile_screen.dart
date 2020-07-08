import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:makeshift_homeschool_app/shared/constants.dart';
import 'package:provider/provider.dart';
import '../services/auth.dart';
import 'package:image_picker/image_picker.dart'; // load images

class EditProfileScreen extends StatefulWidget {
  final currentData; // Pass in a snapshot of the current data when this edit screen is pushed to the stack
  const EditProfileScreen({Key key, this.currentData}) : super(key: key);

  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  File _imageFile = null;
  String _newUserName;
  String _newBio;
  bool updateProfileInfo = false;
  // Update data as key value pairs

  /// **************************************************************************
  /// Build UI Method                                                          *
  ///***************************************************************************

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    var auth = Provider.of<AuthProvider>(context); // Used to call Auth method

    // Stores current data, but updates if there is a change
    Map<String, String> toUpdateData = {
      "username": widget.currentData["username"],
      "bio": widget.currentData["bio"]
    };

    // Pick an image by source: Gallery or Camera
    Future<void> _chooseNewProfilePicture(ImageSource source) async {
      ImagePicker imagePicker = ImagePicker();
      final pickedImage = await imagePicker.getImage(
          source: source, maxHeight: 180, maxWidth: 180);
      setState(() {
        _imageFile = File(pickedImage.path);
      });
      await auth.uploadProfileImage(_imageFile);
    }

    //Remove Image
    void _clearNewProfilePictureSelection() {
      setState(() {
        _imageFile = null;
      });
    }

    // When users want to change their profile picture, they can pick from
    // library or camera
    void _buildImagePickerPopUpMenu(context) {
      showModalBottomSheet(
          context: context,
          builder: (BuildContext contx) {
            return Container(
              child: Wrap(
                children: <Widget>[
                  ListTile(
                    title: Text("Choose from Library"),
                    onTap: () {
                      _chooseNewProfilePicture(ImageSource.gallery);
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            );
          });
    }

    return Scaffold(
      // appBar: AppBar(
      //   title: Text("Edit Profile"),
      // ),

      body: Container(
        height: screenSize.height,
        width: screenSize.width,
        child: Column(
          children: <Widget>[
            // Avatar in the Center of the screen
            Padding(
                padding: const EdgeInsets.all(20.0),
                child: Center(
                    child: CircleAvatar(
                        radius: 50,
                        backgroundImage: _imageFile != null
                            ? FileImage(_imageFile)
                            : NetworkImage(widget.currentData["photoURL"]),
                        backgroundColor: Colors.transparent))),

            // Change Profile Picture Button
            FlatButton(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                child: Text(
                  "Change Profile Photo",
                  style: TextStyle(
                      color: Colors.blue, fontWeight: FontWeight.bold),
                ),
                onPressed: () {
                  // bring up menu
                  _buildImagePickerPopUpMenu(context);
                }),

            // Form to change the user's information
            Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  //User name
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      initialValue: widget.currentData["username"],
                      decoration: InputDecoration(
                        labelText: "Username",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.vertical()),
                      ),
                      onChanged: (_) => updateProfileInfo = true,
                      onSaved: (newUsername) =>
                          toUpdateData["username"] = newUsername,
                    ),
                  ),

                  //Bio
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      initialValue: widget.currentData["bio"], //! Change
                      decoration: InputDecoration(
                        labelText: "Bio",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.vertical()),
                      ),
                      onChanged: (_) => updateProfileInfo = true,
                      validator: (newBio) {
                        if (newBio.length > 150) {
                          return "Character limit is 150. Current: ${newBio.length}";
                        }
                        return null;
                      },
                      onSaved: (newBio) => toUpdateData["bio"] = newBio,
                    ),
                  ),

                  // //Email Cant change email when account is made
                  // Padding(
                  //   padding: const EdgeInsets.all(8.0),
                  //   child: TextFormField(
                  //     initialValue: widget.currentData["email"],
                  //     decoration: InputDecoration(
                  //       labelText: "Email Address",
                  //       border: OutlineInputBorder(
                  //           borderRadius: BorderRadius.circular(10)),
                  //     ),
                  //   ),
                  // ),

                  // Save button to pop the screen when done
                  RaisedButton(
                    child: Text("Save"),
                    color: kGreenPrimary,
                    onPressed: () async {
                      if (updateProfileInfo) {
                        _formKey.currentState.save(); // Save the data
                        await auth.updateProfileInformation(toUpdateData);
                        _formKey.currentState.reset(); // Clear
                      }
                      Navigator.of(context).pop();
                    },
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
