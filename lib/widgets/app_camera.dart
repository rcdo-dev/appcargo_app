import 'dart:io';

import 'package:app_cargo/constants/app_colors.dart';
import 'package:app_cargo/constants/dimen.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

import 'app_save_button.dart';
import 'app_scaffold.dart';

// A screen that allows users to take a picture using a given camera.
class AppCamera extends StatefulWidget {
  final Widget mask;

  const AppCamera({Key key, this.mask}) : super(key: key);

  @override
  AppCameraState createState() => AppCameraState(mask);
}

class AppCameraState extends State<AppCamera> {
  final Widget mask;
  CameraController _controller;
  Future<void> _initializeControllerFuture;

  AppCameraState(this.mask);

  @override
  void initState() {
    super.initState();
    availableCameras().then((cameras) {
      // To display the current output from the Camera,
      // create a CameraController.
      _controller = CameraController(
        // Get a specific camera from the list of available cameras.
        cameras.first,
        // Define the resolution to use.
        ResolutionPreset.high,
      );

      SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

      setState(() {
        // Next, initialize the controller. This returns a Future.
        _initializeControllerFuture = _controller.initialize();
      });
    });
  }

  @override
  void dispose() {
    // Dispose of the controller when the widget is disposed.
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Wait until the controller is initialized before displaying the
      // camera preview. Use a FutureBuilder to display a loading spinner
      // until the controller has finished initializing.
      body: FutureBuilder<void>(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            // If the Future is complete, display the preview.
            return Container(
              color: AppColors.green,
              padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
              child: Stack(
                children: <Widget>[
                  CameraPreview(_controller),
                  mask,
                ],
              ),
            );
          } else {
            // Otherwise, display a loading indicator.
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.green,
        child: RotatedBox(
          quarterTurns: 0,
          child: Icon(Icons.camera_alt),
        ),
        // Provide an onPressed callback.
        onPressed: () async {
          // Take the Picture in a try / catch block. If anything goes wrong,
          // catch the error.
          try {
            // Ensure that the camera is initialized.
            await _initializeControllerFuture;

            // Construct the path where the image should be saved using the
            // pattern package.
            final path = join(
              // Store the picture in the temp directory.
              // Find the temp directory using the `path_provider` plugin.
              (await getTemporaryDirectory()).path,
              '${DateTime.now()}.png',
            );

            // Attempt to take a picture and log where it's been saved.
            await _controller.takePicture(path);

            // If the picture was taken, display it on a new screen.
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DisplayPictureScreen(imagePath: path),
              ),
            );
          } catch (e) {
            // If an error occurs, log the error to the console.
            print(e);
          }
        },
      ),
    );
  }
}

// A widget that displays the picture taken by the user.
class DisplayPictureScreen extends StatelessWidget {
  final String imagePath;

  const DisplayPictureScreen({Key key, this.imagePath}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    File imageFile = File(imagePath);

    return AppScaffold(
      showMenu: false,
      scrollable: false,
      title: "Ficou bom?",
      body: Container(
        padding: EdgeInsets.all(Dimen.horizontal_padding),
        child: Stack(
          children: <Widget>[
            Container(
              alignment: Alignment.topCenter,
              padding: EdgeInsets.only(top: 25),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  border: Border.all(color: AppColors.blue),
                ),
                child: ClipRRect(
                  borderRadius: new BorderRadius.circular(8.0),
                  child: Image.file(
                    imageFile,
                    fit: BoxFit.cover,
                    height: (MediaQuery.of(context).size.height -
                        (MediaQuery.of(context).size.height * 0.3)),
                  ),
                ),
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height -
                  (MediaQuery.of(context).size.height * 0.15),
              alignment: Alignment.bottomCenter,
              child: Container(
                padding: EdgeInsets.all(Dimen.horizontal_padding),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: Container(
                        padding: EdgeInsets.only(right: 10),
                        child: AppSaveButton(
                          "NÃO",
                          textColor: AppColors.green,
                          buttonColor: AppColors.white,
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(
                        padding: EdgeInsets.only(left: 10),
                        child: AppSaveButton(
                          "SIM",
                          onPressed: () {
                            Navigator.pop(context, File(imagePath));
                            Navigator.pop(context, File(imagePath));
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
