import 'package:flutter/material.dart';
import 'package:show_more_text_popup/show_more_text_popup.dart';

class AppCustomToolTip {
  final String text;
  final double width;
  final double height;
  final Color textColor;
  final Color backgroundColor;
  final GlobalKey<State<StatefulWidget>> widgetKey;
  final VoidCallback onDismiss;

  AppCustomToolTip({
    this.text,
    this.width = 240.0,
    this.height = 50.0,
    this.textColor,
    this.backgroundColor,
    this.widgetKey,
    this.onDismiss,
  });

  void customToolTip({BuildContext context}) {
    return ShowMoreTextPopup(
      context,
      text: text,
      width: width,
      height: height,
      backgroundColor: backgroundColor,
      padding: EdgeInsets.all(14.0),
      onDismiss: onDismiss,
      textStyle: TextStyle(
        color: textColor,
        fontWeight: FontWeight.bold,
        fontSize: 12.0,
      ),
    ).show(
      widgetKey: widgetKey,
    );
  }
}
