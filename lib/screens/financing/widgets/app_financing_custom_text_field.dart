import 'package:app_cargo/constants/app_colors.dart';
import 'package:flutter/material.dart';

class AppFinancingCustomTextField extends StatelessWidget {
  final Color containerColor;
  final double containerHeight;
  final String hintText;
  final Widget prefix;
  final TextInputType textInputType;
  final TextEditingController controller;
  final bool enabled;
  final Function onChanged;

  const AppFinancingCustomTextField(this.hintText,
      {@required this.controller,
      this.containerColor = AppColors.light_grey,
      this.containerHeight = 40,
      this.prefix,
      this.textInputType = TextInputType.text,
      this.enabled = true,
      this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: this.textInputType == TextInputType.multiline
          ? 120
          : this.containerHeight,
      // width: 150,
      margin: EdgeInsets.only(bottom: 10),
      padding: EdgeInsets.only(left: 10, right: 10, bottom: 5, top: 5),
      decoration: BoxDecoration(
        color: this.containerColor,
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      child: TextField(
        controller: this.controller,
        keyboardType: this.textInputType,
        maxLines: this.textInputType == TextInputType.multiline ? 8 : 1,
        maxLength: this.textInputType == TextInputType.multiline ? 1000 : 50,
        enabled: this.enabled,
        onChanged: this.onChanged,
        decoration: InputDecoration(
            hintText: this.hintText,
            hintStyle: TextStyle(
                color: Colors.grey[500],
                fontSize: 14,
                fontWeight: FontWeight.bold),
            border: InputBorder.none,
            prefix: this.prefix,
            counterText: ''),
      ),
    );
  }
}
