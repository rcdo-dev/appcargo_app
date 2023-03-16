import 'package:app_cargo/constants/app_colors.dart';
import 'package:flutter/material.dart';

class SocialMediaButton extends StatelessWidget {
  final String textButton;
  final String imageButton;
  final VoidCallback onPressed;

  const SocialMediaButton({
    @required this.textButton,
    @required this.imageButton,
    @required this.onPressed,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Stack(
        children: <Widget>[
          Positioned(
            left: 35,
            child: Container(
              height: 55,
              width: 260,
              child: RaisedButton(
                onPressed: onPressed,
                color: AppColors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                    10,
                  ),
                ),
                child: Row(
                  children: <Widget>[
                    SizedBox(
                      width: 20,
                    ),
                    Text(
                      textButton,
                      style: TextStyle(
                        fontSize: 19,
                        color: AppColors.black,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    SizedBox(
                      width: 80,
                    ),
                  ],
                ),
              ),
            ),
          ),
          Image.asset(
            imageButton,
            fit: BoxFit.fill,
            width: 55,
            height: 55,
          ),
        ],
      ),
    );
  }
}
