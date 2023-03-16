import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_skywalker_core/flutter_skywalker_core.dart';

class DynamicCheckBox extends StatefulWidget {
  final String text;
  final double textSize;
  bool flag;
  Function onChanged;

  DynamicCheckBox(this.text, this.flag, {this.textSize = 13, this.onChanged});

  @override
  _DynamicCheckBoxState createState() => _DynamicCheckBoxState(text, flag,
      textSize: textSize, onChanged: onChanged);
}

class _DynamicCheckBoxState extends State<DynamicCheckBox> {
  final String text;
  final double textSize;
  bool flag;
  Function onChanged;

  _DynamicCheckBoxState(this.text, this.flag, {this.textSize, this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5),
      child: Row(
          children: <Widget>[
            SizedBox(
              width: 25,
              child: Checkbox(
                value: flag,
                onChanged: (bool value) {
                  setState(() {
                    onChanged(value);
                    flag = value;
                  });
                },
              ),
            ),
            SkyText(
              text,
              fontSize: textSize,
            ),
          ]),
    );
  }
}
