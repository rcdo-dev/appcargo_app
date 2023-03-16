import 'package:flutter_skywalker_core/src/widgets/sky_flat_button.dart';
import 'package:flutter/material.dart';
import 'package:app_cargo/constants/app_colors.dart';

class BottomButtons extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5),
      alignment: Alignment.bottomCenter,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(
              flex: 1,
              child: Container(
                child: SkyFlatButton(textColor: AppColors.blue,
                  text: "Não tenho cadastro",
                  fontSize: 15,
                ),
              )),
          Expanded(
              flex: 1,
              child: Container(
                child: SkyFlatButton(textColor: AppColors.blue,
                  text: "Sou da transportadora",
                  fontSize: 15,
                ),
              )),
        ],
      ),
    );
  }
}
