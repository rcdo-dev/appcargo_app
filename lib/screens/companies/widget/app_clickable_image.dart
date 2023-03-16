import 'package:app_cargo/constants/app_colors.dart';
import 'package:app_cargo/constants/dimen.dart';
import 'package:flutter/material.dart';

class AppClickableImage extends StatelessWidget {
  final String imageLink;
  final Function onTap;
  final double imageWidth;
  final double imageHeight;

  const AppClickableImage(
      {Key key,
      this.imageLink,
      this.onTap,
      this.imageWidth = 90,
      this.imageHeight = 90})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
          vertical: Dimen.horizontal_padding,
          horizontal: Dimen.vertical_padding),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          width: imageWidth,
          height: imageHeight,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: Border.all(width: 1.0, color: AppColors.blue),
            borderRadius: BorderRadius.all(
                Radius.circular(5.0) //         <--- border radius here
                ),
          ),
          child: Image.network(
            imageLink,
            fit: BoxFit.cover,
            alignment: Alignment.center,
          ),
        ),
      ),
    );
  }
}
