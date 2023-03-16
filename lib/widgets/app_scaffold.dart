import 'package:app_cargo/constants/app_colors.dart';
import 'package:app_cargo/constants/dimen.dart';
import 'package:app_cargo/screens/chat/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:flutter_skywalker_core/flutter_skywalker_core.dart';

import '../services/notification/notification_service.dart';

class AppScaffold extends StatelessWidget {
  final String title;

  final bool showMenu;
  final bool implyLeading;
  final bool showAppBar;
  final Color appBarColor;
  final Color appBarTitleColor;
  final bool scrollable;
  final bool showBackground;

  final double verticalPadding;
  final double horizontalPadding;
  static ChatScreen chatScreen;

  List<Widget> trailingActions;

  final Widget body;
  final WillPopCallback willPopCallback;
  NotificationService notificationService = new NotificationService();

  AppScaffold({
    Key key,
    this.title = "",
    this.showMenu = true,
    this.implyLeading = true,
    this.showAppBar = true,
    this.appBarColor = AppColors.green,
    this.appBarTitleColor = AppColors.white,
    this.scrollable = true,
    this.showBackground = true,
    this.body,
    this.willPopCallback,
    this.verticalPadding = Dimen.horizontal_padding,
    this.horizontalPadding = Dimen.horizontal_padding,
    this.trailingActions,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (notificationService.isNotConfigured()) {
      notificationService.configureNotificationHandling(context);
    }

    Widget center = Container(
      alignment: Alignment.centerLeft,
      child: SkyText(
        title,
        textColor: appBarTitleColor,
        textAlign: TextAlign.center,
        fontSize: 19,
      ),
    );

    Widget menu;

    if (showMenu) {
      menu = Container(
        width: 50,
        child: FittedBox(
          fit: BoxFit.cover,
          child: SkyButton(
            borderColor: AppColors.green,
            textColor: AppColors.white,
            text: "MENU",
            buttonColor: AppColors.green,
            topIcon: Icon(
              Icons.menu,
              color: AppColors.white,
            ),
            onPressed: () {
              Navigator.of(context)
                  .popUntil((Route<dynamic> route) => route.isFirst);
            },
          ),
        ),
      );
    }

    Widget cupertinoMenu;

    if (showMenu) {
      cupertinoMenu = Container(
        width: 60,
        child: FittedBox(
          fit: BoxFit.fill,
          child: FlatButton(
            child: SkyText(
              "MENU",
              fontSize: 50,
              textColor: AppColors.white,
            ),
            textColor: AppColors.blue,
            onPressed: () {
              Navigator.of(context)
                  .popUntil((Route<dynamic> route) => route.isFirst);
            },
          ),
        ),
      );
    }

    Widget appBar;

    if (trailingActions == null) {
      trailingActions = new List<Widget>();
    }

    trailingActions.add(menu);

    if (this.showAppBar) {
      appBar = PlatformAppBar(
        backgroundColor: appBarColor,
        title: center,
        trailingActions: trailingActions.where((w) => null != w).toList(),
        automaticallyImplyLeading: implyLeading,
        // Navigation bar for the IOS app
        ios: (context) {
          return CupertinoNavigationBarData(
            actionsForegroundColor: AppColors.white,
            trailing: cupertinoMenu,
            padding: EdgeInsetsDirectional.only(),
            leading: PlatformIconButton(
              padding: EdgeInsets.all(0),
              ios: (context) {
                return CupertinoIconButtonData(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(
                      Icons.arrow_back_ios,
                      color: AppColors.white,
                      size: 25,
                    ));
              },
            ),
            automaticallyImplyLeading: true,
          );
        },
      );
    }

    Widget newBody = !this.scrollable
        ? body
        : SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.symmetric(
                vertical: verticalPadding,
                horizontal: horizontalPadding,
              ),
              child: body,
            ),
          );

    Widget scaffold = PlatformScaffold(
      appBar: appBar,
      body: Stack(
        children: <Widget>[
          this.showBackground
              ? Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/background/fundo2@3x.png"),
                      fit: BoxFit.cover,
                    ),
                  ),
                )
              : Container(
                  decoration: BoxDecoration(
                    color: AppColors.white,
                  ),
                ),
          newBody,
        ],
      ),
    );

    if (null != this.willPopCallback) {
      return WillPopScope(
        onWillPop: this.willPopCallback,
        child: scaffold,
      );
    } else {
      return scaffold;
    }
  }
}
