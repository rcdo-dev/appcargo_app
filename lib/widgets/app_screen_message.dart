import 'package:app_cargo/constants/app_colors.dart';
import 'package:app_cargo/constants/dimen.dart';
import 'package:app_cargo/widgets/show_message_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_skywalker_core/flutter_skywalker_core.dart';

class AppScreenError extends StatelessWidget {
  final DialogType dialogType;
  final String message;
  final bool onlyErrorMessage;
  final double iconSize;
  final double messageSize;

  const AppScreenError({
    Key key,
    this.dialogType = DialogType.WARNING,
    this.message =
        "Ocorreu um erro ao efetuar sua transação, tente novamente mais tarde",
    this.onlyErrorMessage = false,
    this.iconSize = 60,
    this.messageSize = 25,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double containerErrorHeight;
    if (!onlyErrorMessage)
      containerErrorHeight = MediaQuery.of(context).size.height -
          (MediaQuery.of(context).size.height * 0.2);

    Color messageColor;
    Icon messageIcon;
    switch (dialogType) {
      case DialogType.WARNING:
        messageColor = AppColors.yellow;
        messageIcon = Icon(
          Icons.warning,
          color: messageColor,
          size: iconSize,
        );
        break;
      case DialogType.SUCCESS:
        messageColor = AppColors.green;
        messageIcon = Icon(
          Icons.check,
          color: messageColor,
          size: iconSize,
        );
        break;
      case DialogType.ERROR:
        messageColor = Colors.red;
        messageIcon = Icon(
          Icons.error_outline,
          color: messageColor,
          size: iconSize,
        );
        break;
      default:
        messageColor = AppColors.yellow;
        messageIcon = Icon(
          Icons.warning,
          color: messageColor,
          size: iconSize,
        );
    }

    return Container(
      height: containerErrorHeight,
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            padding: EdgeInsets.symmetric(vertical: Dimen.horizontal_padding),
            child: messageIcon,
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: Dimen.horizontal_padding),
            child: SkyText(
              message,
              fontSize: messageSize,
              textColor: messageColor,
            ),
          ),
        ],
      ),
    );
  }
}
