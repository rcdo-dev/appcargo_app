import 'package:app_cargo/constants/app_colors.dart';
import 'package:app_cargo/constants/dimen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_skywalker_core/src/widgets/sky_button.dart';

class AppSaveButton extends StatelessWidget {
  final Color textColor;
  final Color buttonColor;
  final double borderRadius;
  final String text;
  final double fontSize;
  final double buttonWidth;
  final Function onPressed;

  const AppSaveButton(
    this.text, {
    Key key,
    this.textColor = AppColors.white,
    this.buttonColor = AppColors.green,
    this.borderRadius = 20,
    this.fontSize = 17,
    this.buttonWidth = 666,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isAndroid = Theme.of(context).platform == TargetPlatform.android;

    return Container(
      padding: EdgeInsets.symmetric(vertical: Dimen.vertical_padding),
      width: buttonWidth,
      height: isAndroid ? 46 : null,
      child: SkyButton(
        textColor: textColor,
        buttonColor: buttonColor,
        borderRadius: borderRadius,
        text: text,
        fontSize: fontSize,
        onPressed: onPressed,
      ),
    );
  }
}
