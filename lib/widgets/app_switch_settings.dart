import 'package:app_cargo/constants/app_colors.dart';
import 'package:app_cargo/constants/dimen.dart';
import 'package:flutter_skywalker_core/src/widgets/sky_switch.dart';
import 'package:flutter_skywalker_core/src/widgets/sky_text.dart';
import 'package:flutter/material.dart';

class AppSwitchSetting extends StatelessWidget {
  final String title;
  final String description;

  final int maxLines;

  final double titleSize;
  final double descriptionSize;

  final bool enable;
  final FontWeight titleFontWeight;

  final Function onChanged;

  final Color switchTrackColor;
  final Color switchActiveColor;
  final Color titleColor;
  final Color descriptionColor;

  const AppSwitchSetting({
    Key key,
    this.title = "Setting",
    this.description = "",
    this.enable = false,
    this.switchTrackColor = AppColors.transparent_green,
    this.switchActiveColor = AppColors.green,
    this.titleColor = AppColors.blue,
    this.descriptionColor = AppColors.light_blue,
    this.titleSize = 18,
    this.descriptionSize = 16,
    this.maxLines = 2,
    this.onChanged,
    this.titleFontWeight = FontWeight.bold,
  });

  @override
  Widget build(BuildContext context) {
    Widget descriptionWidget;
    if (description != null) {
      descriptionWidget = Container(
        child: SkyText(
          description,
          textAlign: TextAlign.left,
          fontSize: descriptionSize,
          textColor: descriptionColor,
          maxLines: maxLines,
        ),
      );
    }
    return Container(
      padding: EdgeInsets.symmetric(vertical: Dimen.vertical_padding + 5),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  padding:
                      EdgeInsets.symmetric(vertical: Dimen.vertical_padding),
                  child: SkyText(
                    title,
                    fontSize: titleSize,
                    textColor: titleColor,
                    fontWeight: titleFontWeight,
                  ),
                ),
                descriptionWidget,
              ],
            ),
          ),
          SkySwitch(
            onChanged: onChanged,
            activeTrackColor: switchTrackColor,
            activeColor: switchActiveColor,
            isSwitched: enable,
          ),
        ],
      ),
    );
  }
}
