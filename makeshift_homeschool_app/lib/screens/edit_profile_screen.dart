import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:makeshift_homeschool_app/shared/constants.dart';
import 'package:provider/provider.dart';
import '../services/auth.dart';
import 'package:image_picker/image_picker.dart'; // load images

/// This screen deals with the popup that appears when a user
/// wants to edit their profile information:
///   1. Profile Picture
///   2. Username
///   3. Bio
/// It looks for any updates and updates it on Firestore.

class EditProfileScreen extends StatefulWidget {
  final currentData; // Pass in a snapshot of the current data when this edit screen is pushed to the stack
  const EditProfileScreen({Key key, this.currentData}) : super(key: key);

  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  File _imageFile = null; // When users select an image file
  bool updateProfileInfo = false; // Check if name/bio is changed

  /// **************************************************************************
  /// Build UI Method
  ///***************************************************************************

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    var auth = Provider.of<AuthProvider>(
        context); // Used to call Auth method above the widget tree

    // Stores current data, but updates if there is a change
    Map<String, String> toUpdateData = {
      "username": widget.currentData["username"],
      "bio": widget.currentData["bio"]
    };

    // Preset Profile Images for user to select from
    List<Image> preSetProfileImages = [
      Image.asset("asset/profile_images/bird.png"),
      Image.asset("asset/profile_images/cat.png"),
      Image.asset("asset/profile_images/dog.png"),
      Image.asset("asset/profile_images/frog.png"),
      Image.asset("asset/profile_images/lion.png")
    ];

    /// ************************************************************************
    ///   Method
    ///   User picks an image from their library or camra
    ///   @param - source is where the user wants to pick their profile image
    ///*************************************************************************

    Future<void> _chooseNewProfileImageFromSource(ImageSource source) async {
      ImagePicker imagePicker = ImagePicker();
      final pickedImage = await imagePicker.getImage(
          // ask for permission
          source: source,
          maxHeight: 180,
          maxWidth: 180);
      setState(() {
        _imageFile = File(pickedImage.path); // set the image path
      });
      await auth.uploadProfileImage(_imageFile); // upload to Firestore
    }

    Widget profileImageList() {
      return Container(
        height: screenSize.height * 50,
        width: screenSize.width,
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: preSetProfileImages.length,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              height: 110,
              width: 110,
              child: preSetProfileImages[index],
            );
          },
        ),
      );
    }

    void _showProfileImagePopupSelector() {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Select an Image"),
              content: profileImageList(),
              actions: <Widget>[
                FlatButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text("Save"))
              ],
            );
          });
    }

    /// ************************************************************************
    ///   Widget
    ///   Prompts the user if they want to get their profie image from their
    ///   camera or library
    ///   @param - current widget tree context so it can show on top of it
    ///*************************************************************************
    void _buildImagePickerPopUpMenu(context) {
      showModalBottomSheet(
          context: context, // context of the widget this prompt is showing on
          builder: (BuildContext contx) {
            return Container(
              child: Wrap(
                children: <Widget>[
                  ListTile(
                    title: Text("Choose from Library"),
                    onTap: () {
                      _chooseNewProfileImageFromSource(ImageSource.gallery);
                      Navigator.of(context).pop();
                    },
                  ),
                  ListTile(
                    title: Text("Update Profile Picture"),
                    onTap: () {
                      _showProfileImagePopupSelector();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            );
          });
    }

    /// ************************************************************************
    ///   Widget
    ///   Main UI that shows on the screen
    ///*************************************************************************
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
                        // if a new image is selected, show it, otherwise current
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
                      initialValue: widget.currentData["bio"],
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