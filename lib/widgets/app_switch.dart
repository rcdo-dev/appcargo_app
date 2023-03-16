import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

class AppSwitch extends StatefulWidget{
  final Function onChange;
  final bool value;

  const AppSwitch({Key key, this.onChange, this.value}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _AppSwitchState(onChange, value);

}

class _AppSwitchState extends State<AppSwitch>{
  final Function onChange;
  bool value;
  _AppSwitchState(this.onChange, this.value);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 35,
      child: FittedBox(
        fit: BoxFit.fitHeight,
        child: CupertinoSwitch(
          value:value,
          onChanged: (value) {
            setState(() {
              this.value = value;
              onChange(value);
            });

          },
        ),
      ),
    );
  }
}
