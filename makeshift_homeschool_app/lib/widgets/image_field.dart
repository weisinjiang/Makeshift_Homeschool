import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:makeshift_homeschool_app/services/new_post_provider.dart';
import 'package:makeshift_homeschool_app/shared/colorPalete.dart';
import 'package:provider/provider.dart';

/// First provides an empty image and on tap, let's the user pick an image

class ImageField extends StatefulWidget {
  /// This widgrt takes in the desired height and width of the image by %
  /// For example, image's height can be 50% of the screens height and width can
  /// be 70% of the screens width
  final imageHeight;
  final imageWidth;
  final String editImageUrl;

  const ImageField(
      {Key key, this.imageHeight, this.imageWidth, this.editImageUrl})
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
  void _buildImagePickerPopUpMenu(
      context, double height, double width, NewPostProvider newPostProvider) {
    showModalBottomSheet(
        context: context, // context of the widget this prompt is showing on
        builder: (BuildContext contx) {
          return Container(
            height: height * 0.20,
            child: Wrap(
              spacing: 5.0,
              children: <Widget>[
                // Web Version
                if (kIsWeb) ...[
                  ListTile(
                    leading: Icon(Icons.upload_file),
                    title: Text("Upload an Image"),
                    onTap: () {
                      _chooseImageWeb(height, width, newPostProvider);
                      Navigator.of(context).pop();
                    },
                  ),
                ],

                // Mobile Version
                if (!kIsWeb) ...[
                  /// Choose from Camera Roll
                  ListTile(
                    leading: Icon(Icons.photo),
                    title: Text("Choose from Library"),
                    onTap: () {
                      _chooseImageFromSource(
                          ImageSource.gallery, height, width, newPostProvider);
                      Navigator.of(context).pop();
                    },
                  ),

                  /// Take a picture
                  ListTile(
                    leading: Icon(Icons.camera_alt),
                    title: Text("Take a Photo"),
                    onTap: () {
                      _chooseImageFromSource(
                          ImageSource.camera, height, width, newPostProvider);
                      Navigator.of(context).pop();
                    },
                  ),
                ]
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

  Future<void> _chooseImageFromSource(ImageSource source, double height,
      double width, NewPostProvider newPostProvider) async {
    ImagePicker imagePicker = ImagePicker();
    final pickedImage =
        await imagePicker.getImage(source: source); // ask for permission

    /// Crop the image
    if (pickedImage != null) {
      File croppedImage = await ImageCropper.cropImage(
          sourcePath: pickedImage.path,
          maxWidth: 400,
          maxHeight: 200,
          // wide x image and not a long y image
          aspectRatio: CropAspectRatio(ratioX: 16.0, ratioY: 9.0));
      if (croppedImage != null) {
        setState(() {
          _userSelectedImage = File(croppedImage.path); // set the image path
        });
      }
    }

    newPostProvider.setNewPostImageFile = _userSelectedImage;
    //return File(pickedImage.path);
    //await auth.uploadProfileImage(_imageFile); // upload to Firestore
  }

  Future<void> _chooseImageWeb(
      double height, double width, NewPostProvider newPostProvider) async {
    FilePickerResult pickedImage = await FilePicker.platform.pickFiles(allowMultiple: false, type: FileType.image, withData: true);
  

    if (pickedImage != null) {
      PlatformFile file = pickedImage.files.first;
      File croppedImage = await ImageCropper.cropImage(
          sourcePath: file.path,
          maxWidth: 400,
          maxHeight: 200,
          aspectRatio: CropAspectRatio(ratioX: 16.0, ratioY: 9.0));
      if (croppedImage != null) {
        setState(() {
          _userSelectedImage = File(croppedImage.path);
        });
      }
    }
    newPostProvider.setNewPostImageFile = _userSelectedImage;
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    var newPostProvider = Provider.of<NewPostProvider>(context);

    return GestureDetector(
      // Tap the container with the image, bring up an option to get an image from gallery
      onTap: () {
        _buildImagePickerPopUpMenu(
            context, screenSize.height, screenSize.width, newPostProvider);
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          if (widget.editImageUrl.isEmpty) ...[
            Container(
                height: 200,
                width: 400,
                child: _userSelectedImage == null
                    ? _onScreenImage
                    : Image.file(_userSelectedImage)),
          ] else ...[
            Container(
              decoration:
                  BoxDecoration(border: Border.all(color: Colors.black)),
              child: Image.network(widget.editImageUrl),
            )
          ],
          SizedBox(
            height: 10,
          ),
          if (widget.editImageUrl.isEmpty)
            RaisedButton(
                child: Text("Clear Image"),
                color: kLightBlue,
                onPressed: () {
                  newPostProvider.setNewPostImageFile = null;
                  setState(() {
                    _userSelectedImage = null;
                  });
                })
        ],
      ),
    );
  }
}
