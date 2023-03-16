import 'package:app_cargo/constants/app_colors.dart';
import 'package:flutter/material.dart';

class TextUtil extends StatelessWidget{

  final String text;
  final double textSize;
  final Color textColor;
  final FontWeight fontWeight;


  const TextUtil(
      this.text,{
        this.textColor = AppColors.black,
        this.textSize: 16,
        this.fontWeight = FontWeight.normal,
        Key key,
      }) : super(key: key);
  @override
  Widget build(BuildContext context) {

    return Text(
      this.text,
      textAlign: TextAlign.left,
      style: TextStyle(
          color: this.textColor,
          fontSize: this.textSize,
          fontWeight: this.fontWeight
      ),
    );
  }
}
