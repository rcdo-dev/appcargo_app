import 'package:app_cargo/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:flutter_skywalker_core/flutter_skywalker_core.dart';

class AppBluetoothOn {
  Future<bool> checkBluetoothOn() async {
    FlutterBlue flutterBlue = FlutterBlue.instance;
    var flag = await flutterBlue.isOn;
    if (flag) {
      debugPrint('=================================');
      debugPrint('BLUETOOTH: LIGADO');
      debugPrint('=================================');
      return true;
    }
    debugPrint('=================================');
    debugPrint('BLUETOOTH: DESLIGADO');
    debugPrint('=================================');
    return false;
  }

  Future<void> notifyUserBluetoothOn(BuildContext context) {
    return showDialog(
      barrierDismissible: false,
      context: context,
      child: SimpleDialog(
        title: SkyText(
          "Permissões solicitadas",
          fontSize: 22,
          fontWeight: FontWeight.bold,
          textColor: AppColors.green,
        ),
        children: <Widget>[
          Container(
            padding: EdgeInsets.symmetric(horizontal: 25),
            child: SkyText(
              "Para a correta utilização de todos os serviços o App Cargo precisa que o BLUETOOTH esteja ligado.\n\nPor favor, ligue o bluetooth do seu aparelho.",
              fontSize: 17,
              textAlign: TextAlign.left,
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 5, horizontal: 25),
            child: RaisedButton(
              onPressed: () async {
                var flag = await checkBluetoothOn();
                if (flag) {
                  Navigator.pop(context);
                } else {}
              },
              child: Text("Bluetooth ligado"),
              textColor: AppColors.white,
              color: AppColors.green,
            ),
          )
        ],
      ),
    );
  }
}
