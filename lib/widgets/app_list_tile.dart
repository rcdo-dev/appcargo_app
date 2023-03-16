import 'package:flutter/widgets.dart';

import '../constants/app_colors.dart';
import '../constants/app_colors.dart';
import '../constants/app_colors.dart';
import '../constants/app_colors.dart';
import '../constants/app_colors.dart';
import '../constants/dimen.dart';
import 'app_text.dart';

class AppListTile extends StatelessWidget {
//  final Widget leading;
//  final Widget trailing
  final String title;
  final String subtitle;
  final String thirdLine;
  final bool enabled;
  final bool selected;
  final bool dense;
  final Function onTap;

  final Color bgColor;
  final Color borderColor;
  final double borderWidth;
  final BorderRadiusGeometry borderRadius;

  AppListTile({
    this.title,
    this.subtitle,
    this.thirdLine,
    this.enabled,
    this.selected,
    this.dense,
    this.onTap,
    this.borderRadius,
    this.bgColor = AppColors.white,
    this.borderColor = AppColors.black,
    this.borderWidth = 0,
  });

  @override
  Widget build(BuildContext context) {
    Decoration decoration;
    Color bgColor;

    if (0 == borderWidth) {
      bgColor = this.bgColor;
    } else {
      decoration = BoxDecoration(
        border: Border.all(
          color: borderColor,
          width: borderWidth,
        ),
        borderRadius: borderRadius,
        color: this.bgColor,
      );
    }

    Widget content = Container(
      padding: EdgeInsets.symmetric(
        vertical: Dimen.vertical_padding,
        horizontal: Dimen.horizontal_padding,
      ),
      decoration: decoration,
      color: bgColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          AppText(
            title,
            fontSize: 18,
            textAlign: TextAlign.start,
            weight: FontWeight.bold,
            textColor: AppColors.black,
          ),
          if (null != subtitle)
            AppText(
              subtitle,
              fontSize: 14,
              textAlign: TextAlign.start,
              weight: FontWeight.normal,
              textColor: AppColors.dark_grey,
            ),
          if (null != thirdLine)
            AppText(
              thirdLine,
              fontSize: 14,
              textAlign: TextAlign.start,
              weight: FontWeight.normal,
              textColor: Color.fromRGBO(100, 100, 100, 1),
            ),
        ],
      ),
    );

    return null != onTap
        ? GestureDetector(
            child: content,
            onTap: onTap,
          )
        : content;
  }
}
