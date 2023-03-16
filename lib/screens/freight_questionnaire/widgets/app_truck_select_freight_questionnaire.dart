import 'package:app_cargo/constants/app_colors.dart';
import 'package:app_cargo/constants/dimen.dart';
import 'package:app_cargo/di/container.dart';
import 'package:app_cargo/domain/truck/truck.dart';
import 'package:app_cargo/screens/signup/widget/app_truck_type.dart';
import 'package:app_cargo/widgets/app_widget_button.dart';
import 'package:app_cargo/widgets/app_widget_button_second_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_skywalker_core/flutter_skywalker_core.dart';

class AppTruckSelectFreightQuestionnaire extends StatefulWidget {
  final Function onChanged;
  final TruckType defaultValue;
  final bool enable;

  const AppTruckSelectFreightQuestionnaire(
      {Key key, this.onChanged, this.defaultValue, this.enable = true})
      : super(key: key);

  @override
  _AppTruckTypeWidgetState createState() => _AppTruckTypeWidgetState();
}

class _AppTruckTypeWidgetState
    extends State<AppTruckSelectFreightQuestionnaire> {
  final TruckWeightHelper truckWeights = DIContainer().get<TruckWeightHelper>();
  TruckType selectedTruckType;

  Widget _value = Container(
    height: 50,
    alignment: Alignment.centerLeft,
    padding: EdgeInsets.symmetric(horizontal: 10),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        SkyText(
          "Escolha uma das opções",
          fontSize: 13,
          textColor: AppColors.dark_grey02,
        ),
        Icon(
          Icons.keyboard_arrow_down,
          color: AppColors.dark_grey02,
        )
      ],
    ),
  );

  _AppTruckTypeWidgetState();

  void initState() {
    super.initState();
    if (widget.defaultValue != null) {
      // _value = AppTruckType(type: widget.defaultValue);
      _value = Container(
        width: 666,
        margin: EdgeInsets.symmetric(vertical: 5),
        padding: EdgeInsets.symmetric(vertical: Dimen.vertical_padding),
        child: Column(
          children: <Widget>[
            Container(
              height: 50,
              width: 150,
              padding: EdgeInsets.symmetric(vertical: 5),
              child: SkyText(
                "Selecione um tipo de veículo...".toUpperCase(),
                textColor: AppColors.green,
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),
            ),
          ],
        ),
      );
      ;
    }
  }

  @override
  Widget build(BuildContext context) {
    return AppWidgetButtonSecondUI(
      widget: _value,
      backgroundColor: AppColors.light_grey,
      onPressed: () {
        if (widget.enable) {
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
