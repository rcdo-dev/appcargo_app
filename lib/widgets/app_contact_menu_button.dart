import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:flutter_skywalker_core/src/constants/dimen.dart';
import 'package:flutter_skywalker_core/src/widgets/sky_text.dart';

void _defaultCallback() {}

class AppContactMenuButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  final double fontSize;
  final int maxLines;
  final double borderRadius;
  final Color textColor;
  final Color buttonColor;
  final FontWeight fontWeight;
  final Icon inlineIcon;
  final Icon topIcon;
  final Color borderColor;
  final double borderWidth;
  final double iconRightPadding;
  final String secondText;
  final double secondFontSize;
  final int secondMaxLines;
  final Color secondColor;
  final FontWeight secondFontWeight;
  final EdgeInsets padding;

  const AppContactMenuButton({
    Key key,
    this.onPressed = _defaultCallback,
    this.text = "",
    this.fontSize = 12,
    this.maxLines = 1,
    this.borderRadius = 0,
    this.textColor = Colors.black,
    this.buttonColor = Colors.blue,
    this.fontWeight = FontWeight.normal,
    this.borderColor = Colors.white,
    this.borderWidth = 0,
    this.iconRightPadding = 5,
    this.inlineIcon,
    this.topIcon,
    this.secondText,
    this.secondFontSize = 12,
    this.secondMaxLines = 1,
    this.secondColor = Colors.black,
    this.secondFontWeight = FontWeight.normal,
    this.padding,
  })  : assert(null != text),
        super(key: key);

  /// There are 6 possible configurations to the button layout.
  Widget _buildButtonLayout(
      {Widget startIcon,
        Widget topIcon,
        SkyText primaryText,
        SkyText secondaryText}) {
    // We initialize in the 'inverse' order, as it is simpler
    Widget primaryTextWidget,
        secondaryTextWidget,
        topIconWidget,
        startIconWidget;

    if (null != primaryText) {
      primaryTextWidget = Container(
        child: FittedBox(fit: BoxFit.cover, child: primaryText),
      );
    }

    if (null != secondaryText) {
      secondaryTextWidget = Container(
        child: FittedBox(fit: BoxFit.cover, child: secondaryText),
      );
    }

    if (null != startIcon) {
      startIconWidget = Container(
        padding: EdgeInsets.only(right: iconRightPadding),
        child: FittedBox(
          fit: BoxFit.cover,
          child: startIcon,
        ),
      );
    }

    if (null != topIcon) {
      topIconWidget = Container(
        child: FittedBox(
          fit: BoxFit.cover,
          child: topIcon,
        ),
      );
    }

    Column primaryColumn = Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        topIconWidget,
        primaryTextWidget,
        secondaryTextWidget,
      ].where((w) => null != w).toList(),
    );

    if (null != startIconWidget) {
      return Container(
        padding: padding,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[startIconWidget, primaryColumn],
        ),
      );
    } else {
      return Container(
        padding: padding,
        child: primaryColumn,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    SkyText primaryText, secondaryText;

    if (null != this.text) {
      primaryText = SkyText(
        this.text,
        fontSize: this.fontSize,
        maxLines: this.maxLines,
        textColor: this.textColor,
        fontWeight: this.fontWeight,
      );
    }

    if (null != this.secondText) {
      secondaryText = SkyText(
        this.secondText,
        fontSize: this.secondFontSize,
        maxLines: this.secondMaxLines,
        textColor: this.secondColor,
        fontWeight: this.secondFontWeight,
      );
    }

    Widget content = _buildButtonLayout(
      startIcon: this.inlineIcon,
      topIcon: this.topIcon,
      primaryText: primaryText,
      secondaryText: secondaryText,
    );

    return PlatformButton(
      color: buttonColor,
      android: (context) {
        return MaterialRaisedButtonData(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            side: BorderSide(color: borderColor, width: borderWidth),
          ),
        );
      },
      ios: (context){
        return CupertinoButtonData(
          padding: EdgeInsets.symmetric(vertical: 5, horizontal: 25),
          borderRadius: BorderRadius.circular(borderRadius),
        );
      },
      child: content,
      onPressed: onPressed,
    );
  }
}
