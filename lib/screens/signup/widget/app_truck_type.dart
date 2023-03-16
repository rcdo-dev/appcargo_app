import 'package:app_cargo/constants/app_colors.dart';
import 'package:app_cargo/constants/dimen.dart';
import 'package:app_cargo/domain/truck/truck.dart';
import 'package:flutter/material.dart';
import 'package:flutter_skywalker_core/flutter_skywalker_core.dart';

class AppTruckType extends StatelessWidget {
  final String truckImage;
  final String description;
  final TruckType type;

  AppTruckType({
    Key key,
    this.type,
  })  : description = type.name(),
        truckImage = "assets/truckImages/" + type.imagePath,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 666,
      padding: EdgeInsets.symmetric(vertical: Dimen.vertical_padding),
      child: Column(
        children: <Widget>[
          Container(
            child: Image.asset(
              truckImage,
              fit: BoxFit.contain,
              height: 50,
            ),
          ),
          Container(
            width: 150,
            padding: EdgeInsets.symmetric(vertical: 5),
            child: SkyText(
              description,
              textAlign: TextAlign.center,
              textColor: AppColors.green,
              fontWeight: FontWeight.bold,
              fontSize: 17,
            ),
          ),
        ],
      ),
    );
  }
}

/*
return Container(
      height: 80,
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 47,
            child: Container(
              child: Image.asset(
                truckImage,
                fit: BoxFit.fill,
              ),
            ),
          ),
          Expanded(
            flex: 53,
            child: Container(
              child: SkyText(
                description,
                textAlign: TextAlign.center,
                textColor: AppColors.blue,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Container(
            width: 50,
            alignment: Alignment.center,
            child: SkyText(
              tons,
              textColor: AppColors.blue,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
 */
