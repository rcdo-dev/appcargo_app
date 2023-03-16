import 'package:app_cargo/constants/app_colors.dart';
import 'package:app_cargo/widgets/app_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_skywalker_core/flutter_skywalker_core.dart';

class AppCard extends StatelessWidget {
  final String title;
  final Widget child;
  final List<AppCardAction> actions;

  AppCard({this.child, this.title, this.actions});

  AppCard.withTitle(this.title, {this.child, this.actions});

  @override
  Widget build(BuildContext context) {
    List<Widget> children = List();

    if (null != title) {
      children.add(Padding(
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 7),
        child: AppText(
          title,
          textAlign: TextAlign.start,
          fontSize: 20,
          weight: FontWeight.bold,
        ),
      ));
    }

    if (null != child) {
      children.add(child);
    }

    if (null != this.actions) {
      List<Widget> actionButtons = List();

      for (AppCardAction action in this.actions) {
        actionButtons.add(SkyFlatButton(
          text: action.title,
          onPressed: action.onClick,
          fontSize: 12,
        ));
      }

      children.add(Padding(
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 7),
        child: Row(
          children: actionButtons,
        ),
      ));
    }

    return Container(
      alignment: Alignment.centerLeft,
      width: 666,
      decoration: BoxDecoration(
        color: Color(0xffffffff),
        borderRadius: BorderRadius.all(Radius.circular(5)),
        border: Border.all(color: AppColors.blue),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: children,
      ),
    );
  }
}

class AppCardAction {
  final String title;
  final VoidCallback onClick;

  AppCardAction(this.title, {this.onClick});
}
