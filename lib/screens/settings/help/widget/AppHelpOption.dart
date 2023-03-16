import 'package:app_cargo/constants/dimen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_skywalker_core/src/widgets/sky_text.dart';
import 'package:expandable/expandable.dart';

class AppHelpOption extends StatelessWidget {
  final String title;
  final String description;

  final bool hasIcon;

  final double titleSize;
  final double descriptionSize;

  final Color titleColor;
  final Color descriptionColor;

  const AppHelpOption(this.title, this.description,
      {Key key,
      this.titleSize = 19,
      this.descriptionSize = 16,
      this.titleColor = Colors.blue,
      this.descriptionColor = Colors.lightBlue,
      this.hasIcon = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: Dimen.vertical_padding),
      child: Column(
        children: <Widget>[
          ExpandablePanel(
            header: Container(
              padding: EdgeInsets.symmetric(vertical: Dimen.vertical_padding),
              child: SkyText(
                title,
                fontSize: titleSize,
                textColor: titleColor,
                textAlign: TextAlign.start,
                fontWeight: FontWeight.bold,
              ),
            ),
            expanded: Container(
              padding: EdgeInsets.symmetric(vertical: Dimen.vertical_padding),
              child: SkyText(
                description,
                fontSize: descriptionSize,
                textColor: descriptionColor,
                textAlign: TextAlign.justify,
                fontWeight: FontWeight.normal,
              ),
            ),
            tapHeaderToExpand: true,
            hasIcon: hasIcon,
            tapBodyToCollapse: true,
          )
        ],
      ),
    );
  }
}
