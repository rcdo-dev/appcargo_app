import 'package:app_cargo/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_skywalker_core/flutter_skywalker_core.dart';

class AppText extends StatelessWidget {
  final String text;
  final Color textColor;
  final double fontSize;
  final FontWeight weight;
  final TextAlign textAlign;

  const AppText(
    this.text, {
    this.textColor = AppColors.blue,
    this.fontSize = 17,
    this.textAlign = TextAlign.center,
    this.weight = FontWeight.normal,
  });

  const AppText.defaultText(
    this.text, {
    bold = false,
    this.textColor = AppColors.blue,
    this.fontSize = 17,
  })  : weight = bold ? FontWeight.bold : FontWeight.normal,
        textAlign = TextAlign.center;

  const AppText.fieldLabel(
    this.text, {
    double fontSize = 16,
    this.textColor = AppColors.blue,
    this.weight = FontWeight.normal,
  })  : fontSize = fontSize,
        textAlign = TextAlign.center;

  const AppText.errorText(this.text)
      : textColor = Colors.red,
        fontSize = 17,
        weight = FontWeight.normal,
        textAlign = TextAlign.center;

  @override
  Widget build(BuildContext context) => SkyText(
        text,
        textColor: textColor,
        fontSize: fontSize,
        textAlign: textAlign,
        fontWeight: weight,
      );
}
