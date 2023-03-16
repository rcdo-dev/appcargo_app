import 'package:app_cargo/constants/app_colors.dart';
import 'package:flutter/material.dart';

class AppLoadingWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 666,
      alignment: Alignment.center,
      child: Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(90), color: AppColors.white),
        alignment: Alignment.center,
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(AppColors.green),
        ),
      ),
    );
  }
}
