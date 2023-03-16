import 'package:app_cargo/constants/app_colors.dart';
import 'package:app_cargo/constants/dimen.dart';
import 'package:app_cargo/domain/truck_data/change_truck_status.dart';
import 'package:app_cargo/services/me/me_service.dart';
import 'package:app_cargo/widgets/app_save_button.dart';
import 'package:app_cargo/widgets/app_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_skywalker_core/flutter_skywalker_core.dart';

import '../../routes.dart';

class ReceiveFreight extends StatelessWidget {
  final MeService meService;
  final TruckStatus status;

  const ReceiveFreight({Key key, this.meService, this.status})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: "CARGAS",
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              color: AppColors.white,
            ),
            padding: EdgeInsets.symmetric(
                vertical: Dimen.horizontal_padding,
                horizontal: Dimen.horizontal_padding),
            child: Column(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.symmetric(
                      vertical: Dimen.vertical_padding + 10),
                  child: FittedBox(
                    fit: BoxFit.fill,
                    child: Image.asset(
                      "assets/images/logo.png",
                      height: 120,
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(
                      vertical: Dimen.vertical_padding + 15),
                  child: SkyText(
                    "EM BREVE\nVOCÊ VAI RECEBER\nOFERTAS DE FRETES!",
                    textColor: AppColors.blue,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(
                      vertical: Dimen.vertical_padding + 10),
                  child: SkyText(
                    "Fique ligado!",
                    textColor: AppColors.blue,
                    fontSize: 20,
                    textAlign: TextAlign.justify,
                  ),
                ),
                AppSaveButton(
                  "OK",
                  onPressed: () {
                    Navigator.of(context)
                        .popUntil((Route<dynamic> route) => route.isFirst);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
