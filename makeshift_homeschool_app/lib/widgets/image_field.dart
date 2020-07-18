import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:makeshift_homeschool_app/services/auth.dart';
import 'package:makeshift_homeschool_app/services/new_post_provider.dart';
import 'package:provider/provider.dart';

/// First provides an empty image and on tap, let's the user pick an image

class ImageField extends StatefulWidget {
  /// This widgrt takes in the desired height and width of the image by %
  /// For example, image's height can be 50% of the screens height and width can
  /// be 70% of the screens width
  final imageHeight;
  final imageWidth;

  const ImageField({Key key, this.imageHeight, this.imageWidth})
      : super(key: key);
  @override
  _ImageFieldState createState() => _ImageFieldState();
}

class _ImageFieldState extends State<ImageField> {
  /// Default to be shown before a user selects an image
  Image _onScreenImage = Image.asset("asset/images/imagePlaceHolder.png");
  File _userSelectedImage;

  /// ************************************************************************
  ///   Widget
  ///   Prompts the user if they want to get their profie image from their
  ///   camera or library
  ///   @param - current widget tree context so it can show on top of it
  ///*************************************************************************
  void _buildImagePickerPopUpMenu(context, double height, double width) {
    showModalBottomSheet(
        context: context, // context of the widget this prompt is showing on
        builder: (BuildContext contx) {
          return Container(
            height: height * 0.20,
            child: Wrap(
              spacing: 5.0,
              children: <Widget>[
                /// Choose from Camera Roll
                ListTile(
                  title: Text("Choose from Library"),
                  onTap: () {
                    _chooseImageFromSource(ImageSource.gallery, height, width);
                    Navigator.of(context).pop();
                  },
                ),

                /// Take a picture
                ListTile(
                  title: Text("Take a Photo"),
                  onTap: () {
                    _chooseImageFromSource(ImageSource.camera, height, width);
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          );
        });
  }

  /// ************************************************************************
  ///   Method
  ///   User picks an image from their library or camra
  ///   @param - source is where the user wants to pick their profile image
  ///*************************************************************************

  Future<File> _chooseImageFromSource(
      ImageSource source, double height, double width) async {
    ImagePicker imagePicker = ImagePicker();
    final pickedImage = await imagePicker.getImage(
        // ask for permission
        source: source,
        maxHeight: height * widget.imageHeight,
        maxWidth: width * widget.imageWidth);
    setState(() {
      _userSelectedImage = File(pickedImage.path); // set the image path
    });
    return File(pickedImage.path);
    //await auth.uploadProfileImage(_imageFile); // upload to Firestore
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    var newPostProvider = Provider.of<NewPostProvider>(context);

    return GestureDetector(
      // Tap the container with the image, bring up an option to get an image from gallery
      onTap: () {
        _buildImagePickerPopUpMenu(
            context, screenSize.height, screenSize.width);
      },
      child: Column(
        children: <Widget>[
          Container(
              decoration:
                  BoxDecoration(border: Border.all(color: Colors.black)),
              child: _userSelectedImage == null
                  ? _onScreenImage
                  : Image.file(_userSelectedImage)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              RaisedButton(
                  child: Text("Save Image"),
                  onPressed: () { // Save image into newpostprovider
                    newPostProvider.setNewPostImageFile = _userSelectedImage;
                    
                  }),
              RaisedButton(
                  child: Text("Clear Image"),
                  onPressed: () {
                    newPostProvider.setNewPostImageFile = null;
                    setState(() {
                      _userSelectedImage = null;
                    });
                  })
            ],
          ),
        ],
      ),
    );
  }
}
