import 'package:app_cargo/constants/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_skywalker_core/flutter_skywalker_core.dart';

typedef OnClickCallback = void Function();

class AppTextButton extends StatelessWidget {
  final String text;
  final Color textColor;
  final OnClickCallback onClick;
  final double fontSize;

  const AppTextButton(
    this.text, {
    this.fontSize = 15,
    this.textColor = AppColors.black,
    this.onClick,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SkyFlatButton(
        textColor: textColor,
        fontSize: fontSize,
        text: text,
        onPressed: onClick,
      ),
    );
  }
}
