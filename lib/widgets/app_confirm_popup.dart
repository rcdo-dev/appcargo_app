import 'package:app_cargo/constants/app_colors.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_skywalker_core/flutter_skywalker_core.dart';

Future<T> showAppConfirmPopup<T>(
  BuildContext context,
  String title,
  String content,
  String confirmOptionTitle,
  VoidCallback onConfirm, {
  String cancelOptionTitle,
  VoidCallback onCancel,
  titleColor = AppColors.green,
  contentColor = AppColors.blue,
}) {
  return showSkyConfirmPopup<T>(
    context,
    title,
    content,
    confirmOptionTitle,
    onConfirm,
    titleColor: titleColor,
    contentColor: contentColor,
    confirmOptionButtonBackgroundColor: AppColors.green,
    cancelOptionTitle: cancelOptionTitle,
    onCancel: onCancel,
  );
}
