import 'package:flutter/material.dart';

import 'app_camera.dart';

class AppCRLVCamera extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Widget mask = Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          new Padding(
              padding: new EdgeInsets.all(25.0),
              child: Image.asset(
                "assets/images/crlv_model.png",
                fit: BoxFit.cover,
              ))
        ]);
    return AppCamera(
      mask: mask,
    );
  }
}
