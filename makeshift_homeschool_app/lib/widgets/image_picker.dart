


import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

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
