import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:makeshift_homeschool_app/services/new_post_provider.dart';
import 'package:makeshift_homeschool_app/shared/colorPalete.dart';
import 'package:provider/provider.dart';
import 'package:image_picker_for_web/image_picker_for_web.dart';

/// Builds the Image Widget that lets users pick images from their mobile phones
/// or their Desktop depending on if it's being used on Desktop Browser, iOS, Android
/// 
/// First provides a default image and on tap, let's the user pick an image.
/// The displayed image will change based on what the user picks.

class ImageField extends StatefulWidget {
  /*
    This widgrt takes in the desired height and width of the image by %
    For example, image's height can be 50% of the screens height and width can
    be 70% of the screens width 
  */
  final imageHeight;
  final imageWidth;

  // If Post is being edited, show the photo url from Firebase that is attached to the post 
  final String editImageUrl;

  // Constructor. Need height, width and image url
  // editImageUrl = null if not editing a post
  const ImageField({Key key, this.imageHeight, this.imageWidth, this.editImageUrl}):super(key: key);

  @override
  _ImageFieldState createState() => _ImageFieldState();
}

class _ImageFieldState extends State<ImageField> {
  // Default to be shown before a user selects an image
  Image _onScreenImage = Image.asset("asset/images/imagePlaceHolder.png");
  // File to be uploaded after user selects their target file
  File _userSelectedImage;

  /// Widget
  /// Prompts the user if they want to get their profie image from their
  /// camera or library
  ///  @param - current widget tree context so it can show on top of it
  /// NOTE: Different popups depending on if it is Web Browser or mobile
  void _buildImagePickerPopUpMenu(context, double height, double width, NewPostProvider newPostProvider) {
    showModalBottomSheet(
        context: context, // context of the widget this prompt is showing on
        builder: (BuildContext contx) {
          return Container(
            height: height * 0.20,
            child: Wrap(
              spacing: 5.0,
              children: <Widget>[

                // WEB CODE
                if (kIsWeb) ...[
                  ListTile(
                    leading: Icon(Icons.upload_file),
                    title: Text("Upload an Image"),
                    onTap: () {
                      Navigator.of(context).pop();
                      _chooseImageWeb(height, width, newPostProvider);
                    },
                  ),
                ],

                // MOBILE CODE
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

  /// IMAGE PICKER FOR MOBILE
  /// User picks an image from their library or camera
  /// @param - source is where the user wants to pick their profile image
  Future<void> _chooseImageFromSource(ImageSource source, double height, double width, NewPostProvider newPostProvider) async {

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

    // Pass the file to the NewPostProvider. It will take care of uploading images
    newPostProvider.setNewPostImageFile = _userSelectedImage;
  }

  
  /// IMAGE PICKER FOR WEB 
  /// The Webapp loads image data as a blob for the website, so it is a network object
  /// and not an image. So the original method .path will not work.
  ///
  /// Original path = user/image.png
  /// Webapp Path = http://website.com/imageData <- This is not an actual path to the image location where it can be extracted
  Future<void> _chooseImageWeb(double height, double width, NewPostProvider newPostProvider) async {
    
    // Instaniate the image picker 
    ImagePickerPlugin imagePicker = ImagePickerPlugin(); 

    // Pick the image
    final pickedImage = await imagePicker.pickImage(
        maxHeight: height,
        maxWidth: width,
        source: ImageSource.gallery); // ask for permission

    // Valid image file
    if (pickedImage != null) {
      // Convert it to bytes because Web does not have access to the physical copy of the image on 
      // the users computer
      Uint8List imageBytes = await pickedImage.readAsBytes();

      // Mobile version used _userSelectedImage to upload and show the image
      // Web version, the File is a network image and can be used to display it
      // Not not upload bc it does not have access to the file itself
      setState(() {
        _userSelectedImage = File(pickedImage.path); // set the image path
      });

      // Like Mobile, but additional imageBytes for image upload to Firestore
      newPostProvider.setNewPostImageFile = _userSelectedImage;
      newPostProvider.setByteData = imageBytes;
    }

    
  }

  /// Builds the widget for users to see
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    var newPostProvider = Provider.of<NewPostProvider>(context);

    return GestureDetector(

      // Tap the container with the image, bring up an option to get an image from gallery
      onTap: () {
        _buildImagePickerPopUpMenu(context, screenSize.height, screenSize.width, newPostProvider);
      },

      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[

          // Not editing and is in mobile mode
          if (widget.editImageUrl.isEmpty && !kIsWeb) ...[
            Container(
                height: 200,
                width: 400,
                child: _userSelectedImage == null
                    ? _onScreenImage
                    // Mobile has abs path to the image location so ref it locally using file
                    : Image.file(_userSelectedImage)),  
          ] 
          // Not editing and is on browser mode
          else if (widget.editImageUrl.isEmpty && kIsWeb) ...[
            Container(
                height: 200,
                width: 400,
                child: _userSelectedImage == null
                    ? _onScreenImage
                    // Browser's image path is stored in the network and not from abs path
                    : Image.network(_userSelectedImage.path)),
          ] 

          // Is editing, show the image in the image box instead of the placeholder
          // To-do: Test if this works for browser mode
          else ...[
            Container(
              decoration:
                  BoxDecoration(border: Border.all(color: Colors.black)),
              child: Image.network(widget.editImageUrl),
            )
          ],
          // Does not allow to clear the image because we cant change images as of now
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
