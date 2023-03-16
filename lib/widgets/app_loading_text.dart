import 'package:app_cargo/constants/app_colors.dart';
import 'package:app_cargo/constants/dimen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_skywalker_core/flutter_skywalker_core.dart';

class AppLoadingText extends StatefulWidget {
  @override
  _AppLoadingTextState createState() => _AppLoadingTextState();
}

class _AppLoadingTextState extends State<AppLoadingText> {
  String _loadingText;
  Color color = AppColors.blue;
  Color firstColor = AppColors.blue;
  Color secondColor = AppColors.green;
  Color thirdColor = AppColors.yellow;
  bool stop = false;

  void initState() {
    _loadingText = "";
    _animateLoadingText();
    super.initState();
  }

  @override
  void dispose() {
    stop = true;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
          vertical: Dimen.horizontal_padding,
          horizontal: Dimen.horizontal_padding),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            child: SkyText(
              "Carregando",
              textColor: AppColors.blue,
              fontSize: 20,
            ),
          ),
          Container(
            width: 15,
            alignment: Alignment.centerLeft,
            child: SkyText(
              _loadingText,
              textColor: color,
              fontSize: 20,
            ),
          ),
        ],
      ),
    );
  }

  void _animateLoadingText() {
    Future.delayed(Duration(milliseconds: 500), () {
      if (!stop) {
        setState(() {
          _loadingText += ".";
          color = thirdColor;
        });
      }
    }).then((value) {
      Future.delayed(Duration(milliseconds: 500), () {
        if (!stop) {
          setState(() {
            _loadingText += ".";
            color = secondColor;
          });
        }
      }).then((value) {
        Future.delayed(Duration(milliseconds: 500), () {
          if (!stop) {
            setState(() {
              _loadingText += ".";
              color = firstColor;
            });
          }
        }).then((value) {
          Future.delayed(Duration(milliseconds: 500), () {
            if (!stop) {
              setState(() {
                _loadingText = "";
                _animateLoadingText();
              });
            } else {
              return;
            }
          });
        });
      });
    });
  }
}
