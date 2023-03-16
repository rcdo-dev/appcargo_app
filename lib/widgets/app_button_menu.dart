import 'package:app_cargo/constants/app_colors.dart';
import 'package:flutter/material.dart';

class AppButtonMenu extends StatelessWidget {
  final Color color;
  final String asset;
  final double assetPadding;
  final Color backgroundAssetImage;
  final String textButton;
  final VoidCallback onPressed;

  const AppButtonMenu({
    Key key,
    this.color,
    this.asset,
    this.assetPadding = 5.0,
    this.backgroundAssetImage,
    this.textButton,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(
        8.0,
      ),
      child: RaisedButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            10.0,
          ),
        ),
        color: color,
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(
                top: 10,
              ),
              child: Container(
                height: 90,
                width: 100,
                decoration: BoxDecoration(
                  color: backgroundAssetImage,
                  borderRadius: BorderRadius.circular(
                    10.0,
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.all(
                    assetPadding,
                  ),
                  child: Image.asset(
                    asset,
                  ),
                ),
              ),
            ),
            Text(
              textButton,
              style: TextStyle(
                fontSize: 19,
                color: AppColors.blue,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        onPressed: onPressed,
      ),
    );
  }
}
