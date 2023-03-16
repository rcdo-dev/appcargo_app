import 'package:app_cargo/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:flutter_skywalker_core/flutter_skywalker_core.dart';

class AppButtonTwoAlign extends StatelessWidget {
  final String firstText;
  final String secondText;
  final Function onPressed;

  const AppButtonTwoAlign({
    Key key,
    this.firstText,
    this.secondText,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PlatformButton(
      color: AppColors.white,
      android: (context) {
        return MaterialRaisedButtonData(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side: BorderSide(color: AppColors.blue),
          ),
        );
      },
      onPressed: onPressed,
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 2,
            child: Container(
              alignment: Alignment.centerLeft,
              child: SkyText(
                firstText,
                fontSize: 17,
                textColor: AppColors.blue,
                textAlign: TextAlign.start,
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              alignment: Alignment.centerLeft,
              child: SkyText(
                secondText,
                fontSize: 17,
                textColor: AppColors.blue,
                textAlign: TextAlign.start,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
