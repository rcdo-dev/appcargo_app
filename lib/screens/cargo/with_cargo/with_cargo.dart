import 'package:app_cargo/constants/app_colors.dart';
import 'package:app_cargo/constants/dimen.dart';
import 'package:app_cargo/di/container.dart';
import 'package:app_cargo/domain/city/city.dart';
import 'package:app_cargo/domain/truck_data/change_truck_status.dart';
import 'package:app_cargo/services/me/me_service.dart';
import 'package:app_cargo/widgets/app_city_state_dropdown.dart';
import 'package:app_cargo/widgets/app_loading_dialog.dart';
import 'package:app_cargo/widgets/app_save_button.dart';
import 'package:app_cargo/widgets/app_scaffold.dart';
import 'package:app_cargo/widgets/app_text_field.dart';
import 'package:app_cargo/widgets/show_message_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:flutter_skywalker_core/flutter_skywalker_core.dart';

import '../../../routes.dart';

part 'with_cargo_controller.dart';

class WithCargo extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => WithCargoState();
}

class WithCargoState extends State<WithCargo> {
  MeService meService = DIContainer().get<MeService>();
  WithCargoController withCargoController = new WithCargoController();

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: "CARGAS",
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
                          Icons.widgets,
                          size: 25,
                          color: AppColors.green,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                            vertical: Dimen.vertical_padding,
                            horizontal: Dimen.horizontal_padding - 5),
                        child: SkyText(
                          "COM CARGA",
                          fontSize: 25,
                          textColor: AppColors.green,
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(Dimen.horizontal_padding),
                  child: SkyText(
                    "Por quantos dias irá\nficar com carga?",
                    textColor: AppColors.blue,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Container(
                  width: 70,
                  alignment: Alignment.center,
                  child: AppTextField(
                    hint: "Dias",
                    inputType: TextInputType.number,
                    textAlign: TextAlign.center,
                    textEditingController: withCargoController.howLong,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ),
                Container(
                  child: Column(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.symmetric(
                            vertical: Dimen.vertical_padding + 5),
                        child: SkyText(
                          "Qual seu destino?",
                          textColor: AppColors.blue,
                          fontSize: 25,
                          textAlign: TextAlign.center,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      AppCityStateDropdown(
                        onCityChanged: (city) {
                          withCargoController.city = city;
                        },
                        showCityAutocomplete: true,
                      ),
                    ],
                  ),
                ),
                AppSaveButton(
                  "SALVAR",
                  onPressed: () {
                    if (withCargoController.city == null || withCargoController.howLong.text.trim().length == 0) {
                      showMessageDialog(context,
                          type: DialogType.WARNING,
                          message:
                              "Por favor, informe o seu local de destino para podermos lhe fornecer novos fretes próximos");
                      return;
                    }
                    showLoadingThenOkDialog(
                      context,
                      meService.updateTruckStatus(
                        ChangeTruckStatus(
                          status: TruckStatus.LOADED,
                          data: withCargoController.getChangeTruckStatusData(),
                        ),
                      ),
                    ).then((value) {
                      Navigator.pop(context);
                    });
                  },
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
