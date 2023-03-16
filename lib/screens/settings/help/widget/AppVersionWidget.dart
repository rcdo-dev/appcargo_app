import 'package:app_cargo/constants/app_colors.dart';
import 'package:app_cargo/di/container.dart';
import 'package:app_cargo/services/config/config_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_skywalker_core/flutter_skywalker_core.dart';

class AppVersionWidget extends StatefulWidget {
  @override
  _AppVersionWidgetState createState() => _AppVersionWidgetState();
}

class _AppVersionWidgetState extends State<AppVersionWidget> {
  final ConfigurationService configurationService =
  DIContainer().get<ConfigurationService>();

  String _appVersion;

  @override
  void initState() {
    super.initState();
    configurationService.appVersion.then((appVersionData) {
      setState(() {
        _appVersion = appVersionData;
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 15, bottom: 15),
      child: SkyText(
        "Versão do aplicativo: ${_appVersion ?? ""}",
        fontSize: 18,
        textColor: AppColors.blue,
      ),
    );
  }
}
