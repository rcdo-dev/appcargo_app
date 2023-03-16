import 'package:app_cargo/constants/app_colors.dart';
import 'package:flutter/material.dart';

class AppOmniMenuOptionButton extends StatelessWidget {
  final String textButton;
  final double textButtonSize;
  final Color buttonColor;
  final Function onPressedCallback;

  AppOmniMenuOptionButton({
    @required this.onPressedCallback,
    @required this.textButton,
    this.textButtonSize = 20,
    this.buttonColor = AppColors.partner_light_green,
  });

  @override
  Widget build(BuildContext context) {
    return ButtonTheme(
      minWidth: 230,
      height: 60,
      child: RaisedButton(
        onPressed: this.onPressedCallback,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            20,
          ),
        ),
        color: this.buttonColor,
        child: Text(
          this.textButton,
          style: TextStyle(
            fontSize: this.textButtonSize,
            color: AppColors.white,
            fontWeight: FontWeight.w700,
            fontStyle: FontStyle.italic,
          ),
        ),
      ),
    );
  }
}
