import 'package:app_cargo/constants/app_colors.dart';
import 'package:flutter/material.dart';

class AppRefreshIndicator extends StatelessWidget {
  final ListView content;
  final RefreshCallback onRefresh;
  final Color refreshColor;
  final Color refreshBackgroundColor;

  const AppRefreshIndicator({
    Key key,
    this.content,
    this.onRefresh,
    this.refreshColor = AppColors.green,
    this.refreshBackgroundColor = AppColors.white,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      color: refreshColor,
      backgroundColor: refreshBackgroundColor,
      child: content,
      onRefresh: onRefresh,
    );
  }
}
