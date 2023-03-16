import 'package:app_cargo/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

class AppWidgetButtonSecondUI extends StatelessWidget {
  final Widget widget;
  final Function onPressed;
  final Color backgroundColor;

  const AppWidgetButtonSecondUI(
      {Key key,
      this.widget,
      this.onPressed,
      this.backgroundColor = AppColors.light_grey02})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (Theme.of(context).platform == TargetPlatform.iOS) {
      return Container(
        padding: EdgeInsets.all(2),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
            color: AppColors.blue,
          ),
        ),
        child: PlatformButton(
          child: widget,
          onPressed: onPressed,
          color: AppColors.white,
          disabledColor: AppColors.white,
          ios: (context) {
            return CupertinoButtonData(
                padding: EdgeInsets.symmetric(horizontal: 12));
          },
        ),
      );
    } else {
      return GestureDetector(
        onTap: onPressed,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            shape: BoxShape.rectangle,
            border: new Border.all(
              color: AppColors.light_grey02,
            ),
            color: this.backgroundColor,
          ),
          child: widget,
        ),
      );
    }
  }
}
