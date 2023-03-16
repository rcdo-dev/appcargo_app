import 'package:app_cargo/constants/app_colors.dart';
import 'package:flutter/widgets.dart';

class AppHorizontalDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SizedBox(height: 10),
        Container(
          width: 300,
          height: 1,
          color: AppColors.yellow,
        ),
        SizedBox(height: 10),
      ],
    );
  }
}