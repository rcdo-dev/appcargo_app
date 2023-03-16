import 'package:app_cargo/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_skywalker_core/flutter_skywalker_core.dart';

const Icon defaultIcon = Icon(
  Icons.warning,
  color: AppColors.yellow,
  size: 40,
);

enum DialogType { WARNING, SUCCESS, ERROR, INFO }

class DialogTypeHelper {
  static Icon getIcon(DialogType dialogType) {
    switch (dialogType) {
      case DialogType.WARNING:
        return Icon(
          Icons.warning,
          color: AppColors.yellow,
          size: 40,
        );
        break;
      case DialogType.SUCCESS:
        return Icon(
          Icons.check,
          color: AppColors.green,
          size: 40,
        );
      case DialogType.ERROR:
        return Icon(
          Icons.error_outline,
          color: Colors.red,
          size: 40,
        );
      case DialogType.INFO:
        return Icon(
          Icons.info_outline,
          color: AppColors.blue,
          size: 40,
        );
        break;
    }
  }
  static Color getColor(DialogType dialogType) {
    switch (dialogType) {
      case DialogType.WARNING:
        return AppColors.yellow;
        break;
      case DialogType.SUCCESS:
        return Colors.green;
      case DialogType.ERROR:
        return Colors.red;
        break;
      case DialogType.INFO:
        return AppColors.blue;
        break;
    }
  }
}

Future<T> showMessageDialog<T>(
  BuildContext context, {
  DialogType type = DialogType.WARNING,
  /*Color textColor = AppColors.yellow,*/
  String message = "Warning Message",
  /*Icon icon = defaultIcon,*/
}) {
  return showDialog(
    context: context,
    child: SimpleDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      backgroundColor: Color(0x00ffffff),
      children: <Widget>[
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              width: 666,
              alignment: Alignment.bottomCenter,
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(90),
                    topRight: Radius.circular(90)),
                child: Container(
                    width: 60,
                    height: 50,
                    color: AppColors.white,
                    alignment: Alignment.center,
                    child: DialogTypeHelper.getIcon(type)),
              ),
            ),
            Container(
              alignment: Alignment.topCenter,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                width: 666,
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: SkyText(
                  message,
                  fontSize: 20,
                  textColor: DialogTypeHelper.getColor(type),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
      ],
    ),
  );
}
