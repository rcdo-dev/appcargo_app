import 'package:app_cargo/constants/app_colors.dart';
import 'package:app_cargo/constants/dimen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_skywalker_core/src/widgets/sky_button.dart';

class AppActionButton extends StatelessWidget {
  final String text;
  final String secondText;

  final int maxLines;
  final int secondMaxLines;

  final double fontSize;
  final double buttonWidth;
  final double borderRadius;
  final double secondFontSize;
  final double cupertinoHeightButton;

  final Color textColor;
  final Color buttonColor;
  final Color borderColor;
  final Color secondColor;

  final Icon inlineIcon;

  final FontWeight fontWeight;
  final FontWeight secondFontWeight;

  final Function onPressed;

  const AppActionButton(
    this.text, {
    Key key,
    this.fontSize = 17,
    this.textColor = AppColors.blue,
    this.buttonColor = AppColors.white,
    this.borderColor = AppColors.blue,
    this.buttonWidth = 666,
    this.borderRadius = 10,
    this.inlineIcon,
    this.onPressed,
    this.maxLines = 1,
    this.fontWeight = FontWeight.normal,
    this.secondText,
    this.secondMaxLines,
    this.secondFontSize,
    this.secondColor,
    this.secondFontWeight,
    this.cupertinoHeightButton = 38,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (Theme.of(context).platform == TargetPlatform.android) {
      if (secondText != null) {
        return Container(
          padding: EdgeInsets.only(top: Dimen.vertical_padding),
          width: buttonWidth,
          child: SkyButton(
            inlineIcon: inlineIcon,
            buttonColor: buttonColor,
            borderRadius: borderRadius,
            text: text,
            borderColor: borderColor,
            textColor: textColor,
            fontSize: fontSize,
            onPressed: onPressed,
            maxLines: maxLines,
            fontWeight: fontWeight,
            secondColor: secondColor,
            secondFontSize: secondFontSize,
            secondFontWeight: secondFontWeight,
            secondMaxLines: secondMaxLines,
            secondText: secondText,
          ),
        );
      } else {
        return Container(
          padding: EdgeInsets.only(top: Dimen.vertical_padding),
          width: buttonWidth,
          height: cupertinoHeightButton,
          child: SkyButton(
            inlineIcon: inlineIcon,
            buttonColor: buttonColor,
            borderRadius: borderRadius,
            text: text,
            borderColor: borderColor,
            textColor: textColor,
            fontSize: fontSize,
            onPressed: onPressed,
            maxLines: maxLines,
            fontWeight: fontWeight,
          ),
        );
      }
    } else {
      if (secondText != null) {
        return Container(
          padding: EdgeInsets.only(top: Dimen.vertical_padding),
          width: buttonWidth,
          child: SkyButton(
            inlineIcon: inlineIcon,
            buttonColor: buttonColor,
            borderRadius: borderRadius,
            text: text,
            borderColor: borderColor,
            textColor: textColor,
            fontSize: fontSize,
            onPressed: onPressed,
            maxLines: maxLines,
            fontWeight: fontWeight,
            secondColor: secondColor,
            secondFontSize: secondFontSize,
            secondFontWeight: secondFontWeight,
            secondMaxLines: secondMaxLines,
            secondText: secondText,
          ),
        );
      } else {
        return Container(
          padding: EdgeInsets.only(top: Dimen.vertical_padding),
          width: buttonWidth,
          child: SkyButton(
            inlineIcon: inlineIcon,
            buttonColor: buttonColor,
            borderRadius: borderRadius,
            text: text,
            borderColor: borderColor,
            textColor: textColor,
            fontSize: fontSize,
            onPressed: onPressed,
            maxLines: maxLines,
            fontWeight: fontWeight,
          ),
        );
      }
    }
  }
}
