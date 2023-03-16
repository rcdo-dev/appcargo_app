import 'package:app_cargo/constants/app_colors.dart';
import 'package:app_cargo/constants/dimen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_skywalker_core/flutter_skywalker_core.dart';

class AppSmallButton extends StatelessWidget {
  final Function onPressed;
  final String text;
  final Icon icon;
  final double fontSize;
  final Color textColor;
  final double verticalPadding;

  const AppSmallButton({
    Key key,
    this.onPressed,
    this.text,
    this.icon,
    this.fontSize = 15,
    this.textColor = AppColors.green,
    this.verticalPadding = Dimen.horizontal_padding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 666,
      padding: EdgeInsets.symmetric(vertical: verticalPadding),
      height: 55,
      child: SkyButton(
        text: text,
        textColor: textColor,
        inlineIcon: icon,
        buttonColor: AppColors.white,
        borderRadius: 10,
        fontSize: fontSize,
        iconRightPadding: 10,
        fontWeight: FontWeight.bold,
        onPressed: onPressed,
      ),
    );
  }
}
