import 'package:app_cargo/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';

import 'app_text_field.dart';

class AppPasswordField extends StatefulWidget {
  final String hint;
  final String label;
  final Function onChanged;
  final TextEditingController controller;

  const AppPasswordField(this.label, {Key key, this.onChanged, this.controller, this.hint})
      : super(key: key);

  @override
  _AppPasswordFieldState createState() =>
      _AppPasswordFieldState(label, onChanged, controller, hint);
}

class _AppPasswordFieldState extends State<AppPasswordField> {
  final String hint;
  final String label;
  final ValueChanged<String> onChanged;
  final TextEditingController controller;
  bool show = true;

  _AppPasswordFieldState(this.label, this.onChanged, this.controller, this.hint);

  @override
  Widget build(BuildContext context) {
    return AppTextField(
      textEditingController: controller,
      label: label,
      hint: hint,
      prefixIcon: Icon(
        Icons.lock,
        color: AppColors.yellow,
      ),
      labelColor: AppColors.blue,
      obscureText: show,
      suffixIcon: IconButton(
        icon: Icon(
          Icons.remove_red_eye,
          color: AppColors.blue,
        ),
        onPressed: () {
          setState(
            () {
              if (show)
                show = false;
              else
                show = true;
            },
          );
        },
      ),
      onChanged: onChanged,
    );
  }
}
