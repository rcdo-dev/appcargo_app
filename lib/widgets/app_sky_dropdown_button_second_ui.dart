import 'package:flutter/material.dart';
import 'package:flutter_skywalker_core/src/widgets/sky_text.dart';

typedef String OptionTitleResolver<T>(T t);

String _defaultTitleResolver(Object val) {
  return val.toString();
}

// TODO: REFACTOR THIS TO USE CUPERTINO PICKER TOO

class AppSkyDropdownButtonSecondUI<T> extends StatefulWidget {
  final List<T> items;
  final Color textColor;
  final Color dropdownIconColor;
  final double fontSize;
  final OptionTitleResolver<T> resolver;
  final Function onChanged;
  final T currentItem;
  final bool createFriendlyFirstItem;
  final bool isExpanded;
  final bool isDense;
  final bool enable;
  final String friendlyFirstItemText;
  final double dropDownWidth;
  final double dropDownHeight;

  const AppSkyDropdownButtonSecondUI({
    Key key,
    this.items,
    this.resolver = _defaultTitleResolver,
    this.textColor = Colors.black,
    this.dropdownIconColor = Colors.blue,
    this.fontSize = 15,
    this.onChanged,
    this.currentItem,
    this.createFriendlyFirstItem = false,
    this.isExpanded = false,
    this.isDense = true,
    this.friendlyFirstItemText,
    this.enable = true,
    this.dropDownWidth,
    this.dropDownHeight,
  }) : super(key: key);

  @override
  _SkyDropdownButtonState createState() => _SkyDropdownButtonState<T>(
        enable: enable,
        items: items,
        textColor: textColor,
        fontSize: fontSize,
        dropdownIconColor: dropdownIconColor,
        resolver: resolver,
        onChanged: onChanged,
        currentItem: currentItem,
        isExpanded: isExpanded ?? false,
        isDense: isDense ?? true,
        createFriendlyFirstItem: createFriendlyFirstItem ?? false,
        friendlyFirstItemText: friendlyFirstItemText,
        dropDownWidth: dropDownWidth,
      dropDownHeight: dropDownHeight,
      );
}

class _SkyDropdownButtonState<T>
    extends State<AppSkyDropdownButtonSecondUI<T>> {
  final List<T> items;
  final Color textColor;
  final Color dropdownIconColor;
  final double fontSize;
  final OptionTitleResolver<T> resolver;
  final Function onChanged;
  final bool isExpanded;
  final bool isDense;
  final bool enable;
  final bool createFriendlyFirstItem;
  final String friendlyFirstItemText;
  final double dropDownWidth;
  final double dropDownHeight;

  List<DropdownMenuItem<T>> _dropDownMenuItems;
  T currentItem;

  _SkyDropdownButtonState(
      {this.enable,
      this.onChanged,
      this.items,
      this.textColor,
      this.fontSize,
      this.dropdownIconColor,
      this.resolver,
      this.isExpanded,
      this.isDense,
      this.currentItem,
      this.createFriendlyFirstItem,
      this.friendlyFirstItemText,
      this.dropDownWidth, this.dropDownHeight})
      : assert(null != resolver);

  @override
  void initState() {
    _dropDownMenuItems = _buildDropdownItems();

    if (!createFriendlyFirstItem) {
      currentItem = currentItem ?? _dropDownMenuItems[0].value;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: Container(
        width: dropDownWidth ?? MediaQuery.of(context).size.width,
        height: dropDownHeight ?? 30,
        child: DropdownButton(
          isExpanded: isExpanded,
          items: _dropDownMenuItems,
          value: currentItem,
          onChanged: changedDropDownItem,
          icon: Icon(
            Icons.keyboard_arrow_down,
            color: dropdownIconColor,
          ),
          style: TextStyle(fontSize: fontSize, color: textColor),
          isDense: isDense,
        ),
      ),
    );
  }

  List<DropdownMenuItem<T>> _buildDropdownItems() {
    List<DropdownMenuItem<T>> items = List();

    if (this.createFriendlyFirstItem) {
      items.add(_createDropdownMenuItem(null, title: friendlyFirstItemText));
    }

    for (T item in this.items) {
      // here we are creating the drop down menu items, you can customize the item right here
      // but I'll just use a simple text for this
      items.add(_createDropdownMenuItem(item));
    }
    return items;
  }

  DropdownMenuItem<T> _createDropdownMenuItem(
    T item, {
    String title,
  }) =>
      DropdownMenuItem(
        value: item,
        child: SkyText(
          title ?? resolver(item),
          textColor: textColor,
          fontSize: fontSize,
        ),
      );

  void changedDropDownItem(T selectedOption) {
    if (enable) {
      onChanged(selectedOption);
      setState(() {
        currentItem = selectedOption;
      });
    }
  }
}
