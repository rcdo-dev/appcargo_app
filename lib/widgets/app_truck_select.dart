import 'package:app_cargo/constants/app_colors.dart';
import 'package:app_cargo/constants/dimen.dart';
import 'package:app_cargo/di/container.dart';
import 'package:app_cargo/domain/truck/truck.dart';
import 'package:app_cargo/screens/signup/widget/app_truck_type.dart';
import 'package:flutter/material.dart';
import 'package:flutter_skywalker_core/flutter_skywalker_core.dart';

import 'app_widget_button.dart';

class AppTruckTypeWidget extends StatefulWidget {
  final Function onChanged;
  final TruckType defaultValue;
  final bool enable;

  const AppTruckTypeWidget({Key key, this.onChanged, this.defaultValue, this.enable = true})
      : super(key: key);

  @override
  _AppTruckTypeWidgetState createState() =>
      _AppTruckTypeWidgetState();
}

class _AppTruckTypeWidgetState extends State<AppTruckTypeWidget> {
  final TruckWeightHelper truckWeights = DIContainer().get<TruckWeightHelper>();
  TruckType selectedTruckType;

  Widget _value = Container(
    height: 50,
    alignment: Alignment.center,
    child: SkyText(
      "Selecionar tipo do caminhao",
      fontSize: 17,
      textColor: AppColors.blue,
    ),
  );

  _AppTruckTypeWidgetState();

  void initState() {
    super.initState();
    if (widget.defaultValue != null) {
      _value = AppTruckType(type: widget.defaultValue);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AppWidgetButton(
      widget: _value,
      onPressed: () {
        if(widget.enable) {
          return showDialog(
            context: context,
            child: AlertDialog(
              shape: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide(
                  style: BorderStyle.solid,
                  color: AppColors.blue,
                ),
              ),
              title: SkyText(
                "Escolha o tipo do seu caminhão",
                fontSize: 25,
                textAlign: TextAlign.center,
                textColor: AppColors.green,
                fontWeight: FontWeight.bold,
              ),
              content: SingleChildScrollView(
                child: Column(
                  children: _optionsBuilder(),
                ),
              ),
            ),
          ).then((option) {
            widget.onChanged(option);
          });
        }
        return null;
      },
    );
  }

  List<Widget> _optionsBuilder() {
    List<Widget> options = new List<Widget>();

    for (TruckWeight truckWeight in truckWeights.values()) {
      for (TruckType type in truckWeights.typesFor(truckWeight)) {
        Widget widget = AppTruckType(
          type: type,
        );

        options.add(Container(
          padding: EdgeInsets.symmetric(
            vertical: Dimen.vertical_padding,
            horizontal: Dimen.horizontal_padding,
          ),
          child: AppWidgetButton(
            widget: widget,
            onPressed: () {
              setState(() {
                _value = widget;
                Navigator.pop(context, type);
              });
            },
          ),
        ));
      }
    }

    return options;
  }
}
