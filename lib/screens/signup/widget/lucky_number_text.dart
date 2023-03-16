import 'package:app_cargo/constants/app_colors.dart';
import 'package:app_cargo/widgets/app_text.dart';
import 'package:flutter/material.dart';

class LuckyNumberText extends StatelessWidget {
  final String text;
  final double fontSize;
  final FontWeight fontWeight;
  final double verticalMargin;
  final double horizontalMargin;

  LuckyNumberText(this.text, {this.fontWeight = FontWeight.normal, this.verticalMargin = 15, this.horizontalMargin = 35, this.fontSize = 16});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: horizontalMargin, vertical: verticalMargin),
      child: AppText(
        text,
        textAlign: TextAlign.left,
        textColor: AppColors.dark_grey02,
        fontSize: this.fontSize,
        weight: fontWeight,
      ),
    );
  }
}
