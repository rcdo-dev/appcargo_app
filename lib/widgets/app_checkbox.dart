import 'package:app_cargo/constants/app_colors.dart';
import 'package:flutter/material.dart';

class AppCheckbox extends StatefulWidget {
  final bool isCheck;
  final Function onChanged;

  const AppCheckbox({Key key, this.isCheck = false, this.onChanged})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _AppCheckboxState(isCheck, onChanged);
}

class _AppCheckboxState extends State<AppCheckbox> {
  bool isCheck;
  final Function onChanged;

  _AppCheckboxState(this.isCheck, this.onChanged);

  @override
  Widget build(BuildContext context) {
    return Checkbox(
      value: isCheck,
      onChanged: (bool changed) {
        setState(() {
          isCheck = changed;
          onChanged(changed);
        });
      },
      checkColor: AppColors.white,
      activeColor: AppColors.green,
      materialTapTargetSize: MaterialTapTargetSize.padded,
    );
  }
}
