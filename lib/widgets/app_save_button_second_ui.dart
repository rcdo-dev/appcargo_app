import 'package:app_cargo/constants/app_colors.dart';
import 'package:app_cargo/constants/dimen.dart';
import 'package:app_cargo/widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_skywalker_core/src/widgets/sky_button.dart';

class AppSaveButtonSecondUI extends StatelessWidget {
  final Color textColor;
  final Color buttonColor;
  final double borderRadius;
  final String text;
  final FontWeight textWeight;
  final double fontSize;
  final double buttonWidth;
  final Function onPressed;
  final bool autofocus;

  const AppSaveButtonSecondUI(
    this.text, {
    Key key,
    this.textColor = AppColors.white,
    this.buttonColor = AppColors.green,
    this.borderRadius = 20,
    this.textWeight = FontWeight.normal,
    this.fontSize = 17,
    this.buttonWidth = 666,
    this.onPressed,
    this.autofocus = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isAndroid = Theme.of(context).platform == TargetPlatform.android;

    return Container(
      padding: EdgeInsets.symmetric(vertical: Dimen.vertical_padding),
      width: buttonWidth,
      height: isAndroid ? 46 : null,
      child: RaisedButton(
        child: AppText(
          text,
          textColor: textColor,
          textAlign: TextAlign.center,
          fontSize: 14,
          weight: textWeight,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
        color: AppColors.yellow,
        onPressed: onPressed,
        autofocus: autofocus,
      ),
    );
  }
}
