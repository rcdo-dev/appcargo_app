import 'package:app_cargo/constants/app_colors.dart';
import 'package:app_cargo/constants/dimen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

import 'app_text.dart';

dynamic _defaultChangeCallback(String a) {}

class AppTextFieldSecondUI extends StatelessWidget {
  final int maxLines;

  final bool obscureText;
  final bool deobscureTextIcon;
  final bool enable;

  final double verticalContentPadding;
  final double horizontalContentPadding;
  final double borderRadius;

  final String label;

  final Color labelColor;
  final double labelSize;
  final FontWeight labelBold;

  final String hint;

  final Widget suffix;
  final Widget prefix;
  final Widget suffixIcon;
  final Widget prefixIcon;

  final EdgeInsets margin;
  final TextInputType inputType;
  final TextInputAction inputAction;
  final TextAlign textAlign;
  final TextStyle style;
  final ValueChanged<String> onChanged;
  final ValueChanged<String> onSubmitted;
  final TextEditingController textEditingController;

  const AppTextFieldSecondUI({
    Key key,
    this.label = "",
    this.inputType = TextInputType.text,
    this.inputAction,
    this.obscureText = false,
    this.deobscureTextIcon = false,
    this.textAlign = TextAlign.start,
    this.prefix,
    this.suffix,
    this.prefixIcon,
    this.suffixIcon,
    this.style,
    this.onChanged = _defaultChangeCallback,
    this.onSubmitted = _defaultChangeCallback,
    this.labelColor = Colors.blue,
    this.labelSize = 16,
    this.labelBold = FontWeight.normal,
    this.verticalContentPadding = 14,
    this.horizontalContentPadding = 8,
    this.borderRadius = 5,
    this.maxLines = 1,
    this.textEditingController,
    this.margin,
    this.hint = "",
    this.enable = true,
  }) : super(key: key);

  Widget _buildTextField(BuildContext context) {
    return Container(
      decoration: new BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius),
        shape: BoxShape.rectangle,
        border: new Border.all(
          color: AppColors.light_grey02,
        ),
        color: AppColors.light_grey02,
      ),
      child: PlatformTextField(
        enabled: enable,
        onChanged: onChanged,
        onSubmitted: onSubmitted,
        maxLines: maxLines,
        obscureText: obscureText,
        controller: textEditingController,
        keyboardType: inputType,
        textInputAction: inputAction,
        android: (context) => MaterialTextFieldData(
          decoration: InputDecoration(
            prefix: prefix,
            suffix: suffix,
            prefixIcon: prefixIcon,
            suffixIcon: suffixIcon,
            hintText: hint,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(borderRadius),
              ),
              borderSide: BorderSide.none,
            ),
            contentPadding: EdgeInsets.symmetric(
              vertical: verticalContentPadding,
              horizontal: horizontalContentPadding,
            ),
          ),
          style: style,
        ),
        ios: (context) => CupertinoTextFieldData(
          prefix: prefix,
          suffix: suffix,
          placeholder: hint,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(borderRadius),
            border: Border.all(
              color: AppColors.grey,
              style: BorderStyle.solid,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget widget = _buildTextField(context);

    if (label != "") {
      widget = Container(
        padding: EdgeInsets.symmetric(vertical: Dimen.horizontal_padding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(bottom: 10),
              margin: margin,
              child: AppText.fieldLabel(
                label,
                textColor: labelColor,
                fontSize: labelSize,
                weight: labelBold,
              ),
            ),
            widget,
          ],
        ),
      );
    }

    return widget;
  }
}
