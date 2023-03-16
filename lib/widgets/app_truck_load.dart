import 'package:app_cargo/di/container.dart';
import 'package:app_cargo/domain/truck/truck.dart';
import 'package:app_cargo/widgets/app_dropdown_button.dart';
import 'package:flutter/material.dart';

class AppTruckLoad extends StatefulWidget {
  final Function onChanged;
  final TrailerType currentItem;
  final bool enable;

  const AppTruckLoad({Key key, this.onChanged, this.currentItem, this.enable = true})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _AppTruckLoadState();
}

class _AppTruckLoadState extends State<AppTruckLoad> {

  @override
  Widget build(BuildContext context) {
    return AppDropdownButton.enumerated(
      DIContainer().get<TrailerTypeHelper>(),
      onChanged: widget.onChanged,
      createFriendlyFirstItem: true,
      currentItem: widget.currentItem,
      enable: widget.enable,
    );
  }
}
