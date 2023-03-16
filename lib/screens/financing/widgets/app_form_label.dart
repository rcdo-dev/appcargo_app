import 'package:app_cargo/constants/app_colors.dart';
import 'package:app_cargo/widgets/app_text.dart';
import 'package:flutter/material.dart';

class AppFormLabel extends StatelessWidget {

  String labelText;
  FontWeight fontWeight;
  double fontSize;
  Color textColor;

  AppFormLabel({@required this.labelText, this.fontWeight = FontWeight.normal, this.fontSize = 13, this.textColor = AppColors.grey});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
            width: MediaQuery
                .of(context)
                .size
                .width,
            alignment: Alignment.centerLeft,
            child: AppText(
              this.labelText,
              fontSize: this.fontSize,
              textColor: this.textColor,
              weight: this.fontWeight,
            )),
        SizedBox(height: 5),

      ],
    );
  }
}
