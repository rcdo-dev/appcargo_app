import 'package:app_cargo/constants/app_colors.dart';
import 'package:app_cargo/constants/dimen.dart';
import 'package:app_cargo/widgets/app_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_skywalker_core/flutter_skywalker_core.dart';

class OldAppVersion extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _OldAppVersionState();
}

class _OldAppVersionState extends State<OldAppVersion> {
  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      showAppBar: false,
      scrollable: false,
      body: Container(
        padding: EdgeInsets.all(Dimen.horizontal_padding),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              
              padding: EdgeInsets.only(
                  bottom: Dimen.horizontal_padding + 50),
              child: FittedBox(
                fit: BoxFit.fill,
                child: Image.asset(
                  "assets/images/logo.png",
                  height: 120,
                  width: 180,
                ),
              ),
            ),
            Container(
              child: SkyText(
                "Seu aplicativo aparentemente está desatualizado. Por favor, atualize-o e tente novamente",
                fontSize: 25,
                textColor: AppColors.blue,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
