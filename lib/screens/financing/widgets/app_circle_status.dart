import 'package:app_cargo/constants/app_colors.dart';
import 'package:app_cargo/constants/omni_environments.dart';
import 'package:flutter/material.dart';

class AppCircleStatus extends StatelessWidget {
  final String status;

  const AppCircleStatus({Key key, @required this.status}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (status == OmniEnvironments.submittedToPreApproval ||
        status == OmniEnvironments.finishedSimulation)
      return Container(
        width: 15,
        height: 15,
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            // color: AppColors.grey),
            color: AppColors.grey),
      );
    if (status == OmniEnvironments.preApproved)
      return Container(
        width: 15,
        height: 15,
        decoration:
            BoxDecoration(shape: BoxShape.circle, color: AppColors.yellow),
      );
    if (status == OmniEnvironments.refused)
      return Container(
        width: 15,
        height: 15,
        decoration: BoxDecoration(shape: BoxShape.circle, color: AppColors.red),
      );
    if (status == OmniEnvironments.approved)
      return Container(
        width: 15,
        height: 15,
        decoration:
            BoxDecoration(shape: BoxShape.circle, color: AppColors.green),
      );

    if (status == null) {
      return Container(
        width: 15,
        height: 15,
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            // color: AppColors.grey),
            color: AppColors.grey),
      );
    }
    return null;
  }
}
