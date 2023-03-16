import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AppGalleryPicker extends StatefulWidget {
  AppGalleryPicker() : super();

  final String title = "Flutter Pick Image demo";

  @override
  _AppGalleryPickerState createState() => _AppGalleryPickerState();
}

class _AppGalleryPickerState extends State<AppGalleryPicker> {
  Future<File> imageFile;

  pickImageFromGallery(ImageSource source) {
    setState(() {
      imageFile = ImagePicker.pickImage(source: source);
    });
  }

  Widget showImage() {
    return FutureBuilder<File>(
      future: imageFile,
      builder: (BuildContext context, AsyncSnapshot<File> snapshot) {
        if (snapshot.connectionState == ConnectionState.done &&
            snapshot.data != null) {
          return Image.file(
            snapshot.data,
            width: 300,
            height: 300,
          );
        } else if (snapshot.error != null) {
          return const Text(
            'Error Picking Image',
            textAlign: TextAlign.center,
          );
        } else {
          return const Text(
            'No Image Selected',
            textAlign: TextAlign.center,
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            showImage(),
            RaisedButton(
              child: Text("Select Image from Gallery"),
              onPressed: () {
                pickImageFromGallery(ImageSource.gallery);
              },
            ),
          ],
        ),
      ),
    );
  }
}
