import 'package:flutter/material.dart';

void showLoadingScreen(BuildContext context) {
  showDialog(
    context: context,
    child: Container(
      height: 10,
      width: 10,
      child: Image.asset(
        "assets/images/loadingImage.gif",
      ),
    ),
  );
}
