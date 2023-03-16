import 'package:app_cargo/constants/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_skywalker_core/flutter_skywalker_core.dart';

Future<T> showMinimumFreightDialog<T>(BuildContext context,
    double displacementCost, double loadAndUnloadCost, double total) {
  return showDialog(
      context: context,
      child: SimpleDialog(
        title: SkyText(
          "Calculo frete mínimo",
          fontSize: 22,
          fontWeight: FontWeight.bold,
          textColor: AppColors.green,
        ),
        children: <Widget>[
          Container(
              padding: EdgeInsets.symmetric(horizontal: 25),
              child: SkyText(
                "Deslocamento = R\$ ${displacementCost.toStringAsFixed(2)}",
                fontSize: 17,
                textAlign: TextAlign.left,
              )),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 25),
            child: SkyText(
              "Carga e descarga = R\$ ${loadAndUnloadCost.toStringAsFixed(2)}",
              fontSize: 17,
              textAlign: TextAlign.left,
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 25),
            child: SkyText(
              "TOTAL",
              fontSize: 14,
              fontWeight: FontWeight.bold,
              textAlign: TextAlign.center,
              textColor: AppColors.green,
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 5),
            child: SkyText(
              "R\$ ${total.toStringAsFixed(2)}",
              fontSize: 26,
              textAlign: TextAlign.center,
            ),
          )
        ],
      ));
}
