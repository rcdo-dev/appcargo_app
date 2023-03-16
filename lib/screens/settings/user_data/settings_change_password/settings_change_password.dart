import 'package:app_cargo/constants/app_colors.dart';
import 'package:app_cargo/constants/dimen.dart';
import 'package:app_cargo/di/container.dart';
import 'package:app_cargo/domain/password_update/password_update.dart';
import 'package:app_cargo/services/me/me_service.dart';
import 'package:app_cargo/widgets/app_loading_dialog.dart';
import 'package:app_cargo/widgets/app_password_field.dart';
import 'package:app_cargo/widgets/app_save_button.dart';
import 'package:app_cargo/widgets/app_scaffold.dart';
import 'package:app_cargo/widgets/show_message_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_skywalker_core/flutter_skywalker_core.dart';

import '../../../../routes.dart';

part 'settings_change_password_controller.dart';

class SettingsChangePasswordData extends StatefulWidget {
  final MeService meService = DIContainer().get<MeService>();

  @override
  State<StatefulWidget> createState() =>
      _SettingsChangePasswordDataState(meService);
}

class _SettingsChangePasswordDataState
    extends State<SettingsChangePasswordData> {
  final MeService meService;
  SettingsChangePasswordController _changePasswordController;

  void initState() {
    super.initState();
    _changePasswordController = new SettingsChangePasswordController();
  }

  _SettingsChangePasswordDataState(this.meService);

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: "CONFIGURAÇÕES",
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              color: AppColors.white,
            ),
            padding: EdgeInsets.symmetric(
                vertical: Dimen.horizontal_padding,
                horizontal: Dimen.horizontal_padding),
            child: Column(
              children: <Widget>[
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.symmetric(
                            vertical: Dimen.vertical_padding,
                            horizontal: Dimen.horizontal_padding - 5),
                        child: Icon(
                          Icons.lock,
                          size: 25,
                          color: AppColors.blue,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                            vertical: Dimen.vertical_padding,
                            horizontal: Dimen.horizontal_padding - 5),
                        child: SkyText(
                          "TROCAR A SENHA",
                          fontSize: 25,
                          textColor: AppColors.blue,
                        ),
                      )
                    ],
                  ),
                ),
                AppPasswordField(
                  "Senha Atual",
                  controller: _changePasswordController.oldPassword,
                ),
                AppPasswordField(
                  "Nova Senha",
                  controller: _changePasswordController.newPassword,
                ),
                AppPasswordField(
                  "Repetir nova senha",
                  controller: _changePasswordController.repeatNewPassword,
                ),
                AppSaveButton(
                  "TROCAR A SENHA",
                  onPressed: () {
                    _updatePassword(context);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _updatePassword(BuildContext context) {
    if (_changePasswordController.newPassword.text !=
            _changePasswordController.repeatNewPassword.text ||
        _changePasswordController.newPassword.text == "" ||
        _changePasswordController.repeatNewPassword.text == "" ||
        _changePasswordController.oldPassword.text == "") {
      showMessageDialog(context,
          type: DialogType.WARNING, message: "A senhas devem ser iguais!");
      return;
    }
    
    if(_changePasswordController.newPassword.text.length < 8){
      showMessageDialog(context, type: DialogType.WARNING, message: "A senha deve possuir ao menos 8 caracteres");
      return;
    }

    showLoadingThenOkDialog(
      context,
      meService.updatePassword(
        _changePasswordController.getPasswordUpdate(),
      ),
    );
  }
}
