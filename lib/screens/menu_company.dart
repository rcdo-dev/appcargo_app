import 'package:app_cargo/constants/app_colors.dart';
import 'package:app_cargo/constants/dimen.dart';
import 'package:app_cargo/di/container.dart';
import 'package:app_cargo/services/config/config_service.dart';
import 'package:app_cargo/services/me/me_service.dart';
import 'package:app_cargo/services/vouchers_service/vouchers_service.dart';
import 'package:app_cargo/widgets/app_loading_dialog.dart';
import 'package:app_cargo/widgets/app_scaffold.dart';
import 'package:app_cargo/widgets/show_message_dialog.dart';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_skywalker_core/flutter_skywalker_core.dart';
import 'package:flutter/services.dart';
import 'dart:async';

import '../routes.dart';

class MenuCompany extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MenuCompanyState();
}

class _MenuCompanyState extends State<MenuCompany> {
  ConfigurationService _configurationService =
      DIContainer().get<ConfigurationService>();
  VouchersService _voucherService = DIContainer().get<VouchersService>();
  Future _loaded;
  String qrCode;

  void initState() {
    super.initState();
    _loaded = _configurationService.cleanDbBeforeLogin();
  }

  @override
  Widget build(BuildContext context) {
    return _buildBody(context);
  }

  Widget _buildBody(BuildContext context) {
    return AppScaffold(
      showAppBar: false,
      body: Container(
        padding: EdgeInsets.only(
            left: Dimen.horizontal_padding,
            right: Dimen.horizontal_padding,
            top: MediaQuery.of(context).padding.top +
                (MediaQuery.of(context).size.height * 0.085) +
                Dimen.horizontal_padding),
        alignment: Alignment.center,
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(
                  top: Dimen.horizontal_padding,
                  bottom: Dimen.horizontal_padding),
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
              padding: EdgeInsets.all(Dimen.horizontal_padding),
              height: 200,
              width: 200,
              child: SkyButton(
                topIcon: Icon(
                  Icons.camera_alt,
                  color: AppColors.green,
                  size: 50,
                ),
                fontWeight: FontWeight.bold,
                text: "ESCANEAR",
                textColor: AppColors.blue,
                buttonColor: AppColors.white,
                fontSize: 35,
                borderRadius: 5,
                onPressed: () {
                  scan();
                },
                padding: EdgeInsets.symmetric(vertical: Dimen.vertical_padding),
              ),
            ),
            Container(
              padding: EdgeInsets.all(Dimen.vertical_padding),
              width: 200,
              child: SkyButton(
                inlineIcon: Icon(
                  Icons.directions_run,
                  color: AppColors.green,
                  size: 30,
                ),
                textColor: AppColors.blue,
                text: "SAIR",
                buttonColor: AppColors.white,
                borderRadius: 10,
                fontSize: 20,
                onPressed: () {
                  DIContainer().get<ConfigurationService>().deleteAccessToken();
                  Navigator.pushNamedAndRemoveUntil(
                      context, Routes.index, (object) => false);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future scan() async {
    try {
      String barcode = await BarcodeScanner.scan();
      setState(() => this.qrCode = barcode);
      showLoadingThenOkDialog(
          context, _voucherService.validateDriverQrCode(qrCode));
    } on PlatformException catch (e) {
      if (e.code == BarcodeScanner.CameraAccessDenied) {
        setState(() {
          this.qrCode = 'Usuário não concedeu permissão para a câmera';
        });
      } else {
        setState(() => this.qrCode = 'Unknown error: $e');
      }
    } on FormatException {
      setState(() => this.qrCode = '(Não foi possível ler o código)');
    } catch (e) {
      setState(() => this.qrCode = 'Unknown error: $e');
    }
  }
}
