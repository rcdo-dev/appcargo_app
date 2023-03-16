import 'package:flutter/material.dart';

class AppRadioButton extends StatefulWidget {
  final List<String> radioOptions;
  final Function selectedOptionCallback;

  const AppRadioButton(
      {Key key,
      @required this.radioOptions,
      @required this.selectedOptionCallback})
      : super(key: key);

  @override
  _AppRadioButtonState createState() => _AppRadioButtonState();
}

class _AppRadioButtonState extends State<AppRadioButton> {
  String radioItem;
  Function optionCallback;

  @override
  void initState() {
    super.initState();
    setState(() {
      radioItem = widget.radioOptions[0];
      optionCallback = widget.selectedOptionCallback;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: buildRadioOptionsFromList(),
    );
  }

  List<Widget> buildRadioOptionsFromList() {
    List<Widget> radioList = [];
    for (String option in widget.radioOptions) {
      radioList.add(RadioListTile(
        groupValue: radioItem,
        title: Text(option),
        value: option,
        onChanged: (val) {
          setState(() {
            radioItem = val;
            this.optionCallback(val);
          });
        },
      ));
    }

    return radioList;
  }
}
