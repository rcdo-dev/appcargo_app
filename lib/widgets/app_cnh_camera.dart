import 'package:flutter/material.dart';

import 'app_camera.dart';

class AppCNHCamera extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Widget mask = Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          new Padding(
              padding: new EdgeInsets.all(25.0),
              child: Image.asset(
                "assets/images/cnh_model.png",
                fit: BoxFit.cover,
              ))
        ]);
    return AppCamera(
      mask: mask,
    );
  }
}
