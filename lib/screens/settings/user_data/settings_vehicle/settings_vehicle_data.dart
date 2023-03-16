import 'dart:io';

import 'package:app_cargo/constants/app_colors.dart';
import 'package:app_cargo/constants/dimen.dart';
import 'package:app_cargo/di/container.dart';
import 'package:app_cargo/domain/fipe_brand/fipe_brand.dart';
import 'package:app_cargo/domain/fipe_model_summary/fipe_model_summary.dart';
import 'package:app_cargo/domain/fipe_model_year_summary/fipe_model_year_summary.dart';
import 'package:app_cargo/domain/make_type.dart';
import 'package:app_cargo/domain/truck/truck.dart';
import 'package:app_cargo/domain/truck_photo/truck_photo.dart';
import 'package:app_cargo/domain/truck_photo/truck_photos.dart';
import 'package:app_cargo/domain/truck_trailer/truck_trailer.dart';
import 'package:app_cargo/domain/vehicle_data/vehicle_data.dart';
import 'package:app_cargo/screens/signup/widget/app_axles_and_trailer_select.dart';
import 'package:app_cargo/services/fipe/fipe_service.dart';
import 'package:app_cargo/services/me/me_service.dart';
import 'package:app_cargo/widgets/app_dropdown_button.dart';
import 'package:app_cargo/widgets/app_fipe_data.dart';
import 'package:app_cargo/widgets/app_horizontal_divider.dart';
import 'package:app_cargo/widgets/app_loading_dialog.dart';
import 'package:app_cargo/widgets/app_loading_widget.dart';
import 'package:app_cargo/widgets/app_save_button.dart';
import 'package:app_cargo/widgets/app_scaffold.dart';
import 'package:app_cargo/widgets/app_selectable_image.dart';
import 'package:app_cargo/widgets/app_text_field.dart';
import 'package:app_cargo/widgets/app_truck_load.dart';
import 'package:app_cargo/widgets/app_truck_select.dart';
import 'package:app_cargo/widgets/show_message_dialog.dart';
import 'package:app_cargo/widgets/specific/app_new_registration_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:flutter_skywalker_core/flutter_skywalker_core.dart';

part 'settings_vehicle_data_controller.dart';

final bool enable = true;

class SettingsVehicleData extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SettingsVehicleDataState();
}

class _SettingsVehicleDataState extends State<SettingsVehicleData> {
  final MeService _meService = DIContainer().get<MeService>();
  final bool enable = true;
  Future<VehicleData> _loaded;
  SettingsVehicleDataController _settingsVehicleDataController;

  Widget carTrackOptionsWidget;

  Widget appAxlesAndTrailerSelect;
  Widget appFipeData = Container();

  void initState() {
    super.initState();
    _loaded = _meService.getVehicleData().then((VehicleData value) {
      _settingsVehicleDataController = new SettingsVehicleDataController(value);
      showNewRegistrationInfo(context);
      _buildAppFipeData(_settingsVehicleDataController.makeType);
      print(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>" + _settingsVehicleDataController.truckLoadType.name());
      print(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>" + _settingsVehicleDataController.axles.name());
      _buildAppAxlesAndTrailerSelect(
          _settingsVehicleDataController.truckLoadType,
          _settingsVehicleDataController.axles);
      return Future.delayed(Duration(milliseconds: 250), () => value);
    });
  }

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
              vertical: Dimen.vertical_padding,
              horizontal: Dimen.horizontal_padding,
            ),
            child: Column(
              children: <Widget>[
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.symmetric(
                          vertical: Dimen.vertical_padding,
                          horizontal: Dimen.horizontal_padding - 5,
                        ),
                        child: Icon(
                          Icons.local_shipping,
                          size: 25,
                          color: AppColors.blue,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                          vertical: Dimen.vertical_padding,
                          horizontal: Dimen.horizontal_padding - 5,
                        ),
                        child: SkyText(
                          "DADOS DO VEICULO",
                          fontSize: 25,
                          textColor: AppColors.blue,
                        ),
                      )
                    ],
                  ),
                ),
                FutureBuilder(
                  future: _loaded,
                  builder: (context, snapshot) {
                    switch (snapshot.connectionState) {
                      case ConnectionState.done:
                        return Column(
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: Dimen.horizontal_padding),
                              child: AppTruckTypeWidget(
                                enable: true,
                                onChanged: (option) {
                                  setState(() {
                                    if (option != null) {
                                      _settingsVehicleDataController.truckType =
                                          option;
                                      appAxlesAndTrailerSelect = Container();
                                      appFipeData = Container();
                                      _settingsVehicleDataController.axles =
                                          null;
                                      _settingsVehicleDataController
                                          .truckLoadType = null;
                                      _settingsVehicleDataController.model =
                                          null;
                                      _settingsVehicleDataController.modelYear =
                                          null;
                                      _settingsVehicleDataController.model =
                                          null;
                                      if (option == TruckType.UTILITARIO) {
                                        _settingsVehicleDataController
                                                .makeType =
                                            MakeType.car_or_utilitary;
                                      } else {
                                        _settingsVehicleDataController
                                            .makeType = MakeType.truck;
                                      }

                                      Future.delayed(
                                          Duration(milliseconds: 300), () {
                                        _buildAppAxlesAndTrailerSelect(
                                            null, null);
                                        _buildAppFipeData(
                                            _settingsVehicleDataController
                                                .makeType);
                                      });
                                    }
                                  });
                                },
                                defaultValue: this
                                    ._settingsVehicleDataController
                                    .truckType,
                              ),
                            ),
                            appAxlesAndTrailerSelect ?? Container(),
                            AppTextField(
                              label: "Placa do caminhão",
                              labelColor: AppColors.blue,
                              textEditingController:
                                  _settingsVehicleDataController.plate,
                              enable: enable,
                            ),
                            if (null != _settingsVehicleDataController.axles &&
                                null !=
                                    _settingsVehicleDataController
                                        .truckLoadType)
                              Container(
                                  child: AppTextField(
                                      enable: enable,
                                      label: "Placa da Carroceria 1",
                                      textEditingController:
                                          _settingsVehicleDataController
                                              .trailerPlate1)),
                            if (null != _settingsVehicleDataController.axles &&
                                null !=
                                    _settingsVehicleDataController
                                        .truckLoadType)
                              Container(
                                  child: AppTextField(
                                      enable: enable,
                                      label: "Placa Carroceria 2",
                                      textEditingController:
                                          _settingsVehicleDataController
                                              .trailerPlate2)),
                            appFipeData ?? Container(),
                            if (_settingsVehicleDataController.hasCarTracker !=
                                null)
                              Container(
                                padding: EdgeInsets.only(
                                  top: Dimen.horizontal_padding,
                                  bottom: Dimen.vertical_padding,
                                ),
                                alignment: Alignment.center,
                                child: SkyText(
                                  "Possui rastreador?",
                                  fontSize: 17,
                                  textColor: AppColors.blue,
                                ),
                              ),
                            if (_settingsVehicleDataController.hasCarTracker !=
                                null)
                              Container(
                                height: 47,
                                padding: EdgeInsets.only(
                                    right: Dimen.vertical_padding),
                                child: AppDropdownButton.yesOrNo(
                                  onChanged: (bool option) {
                                    this
                                        ._settingsVehicleDataController
                                        .hasCarTracker = option;
                                  },
                                  currentItem: this
                                      ._settingsVehicleDataController
                                      .hasCarTracker,
                                  enable: enable,
                                ),
                              ),
                            AppSaveButton(
                              "SALVAR",
                              onPressed: () {
                                String error = validateData();

                                if (error.isEmpty) {
                                  if (_settingsVehicleDataController.axles ==
                                      TruckAxles.CAVALO_MECANICO) {
                                    _settingsVehicleDataController.axles = null;
                                  }

                                  if (null ==
                                          _settingsVehicleDataController
                                              .axles ||
                                      null ==
                                          _settingsVehicleDataController
                                              .truckLoadType) {
                                    _settingsVehicleDataController
                                        .trailerPlate1.text = "";
                                    _settingsVehicleDataController
                                        .trailerPlate2.text = "";
                                  }

                                  if (_settingsVehicleDataController.axles == TruckAxles.CAVALO_MECANICO) {
                                    _settingsVehicleDataController.axles = null;
                                  }

                                  showLoadingThenOkDialog(
                                      context,
                                      _meService.updateVehicleData(
                                          _settingsVehicleDataController
                                              .getVehicleData()));
                                } else {
                                  // has errors

                                  showMessageDialog(context,
                                      type: DialogType.ERROR, message: error);
                                }
                              },
                            ),
                          ],
                        );
                        break;
                      default:
                        return AppLoadingWidget();
                    }
                  },
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  String validateData() {
    if (null == _settingsVehicleDataController.truckType) {
      return "Selecione um tipo de caminhão";
    }

    if (null == _settingsVehicleDataController.truckType ||
        null == _settingsVehicleDataController.brand ||
        null == _settingsVehicleDataController.model ||
        null == _settingsVehicleDataController.modelYear ||
        (null == _settingsVehicleDataController.truckLoadType &&
            null == _settingsVehicleDataController.axles) ||
        (null == _settingsVehicleDataController.truckLoadType &&
            _settingsVehicleDataController.axles !=
                TruckAxles.CAVALO_MECANICO &&
            _settingsVehicleDataController.axles != null)) {
      return "Preencha todos os campos corretamente";
    }

    if (_settingsVehicleDataController.plate.text.trim().length <= 0) {
      return "A placa do caminhão é obrigatória";
    }

    return "";
  }

  void _buildAppAxlesAndTrailerSelect(
      TrailerType trailerType, TruckAxles truckAxles) {
    setState(() {
      appAxlesAndTrailerSelect = AppAxlesAndTrailerSelect(
        _settingsVehicleDataController.truckType,
        onAxlesChanged: (axles) {
          setState(() {
            _settingsVehicleDataController.axles = axles;
          });
        },
        onTrailerTypeChanged: (trailerType) {
          setState(() {
            _settingsVehicleDataController.truckLoadType = trailerType;
          });
        },
        defaultTrailerType: trailerType,
        defaultTruckAxles: truckAxles,
      );
    });
  }

  void _buildAppFipeData(MakeType makeType) {
    if (_settingsVehicleDataController.model == null ||
        _settingsVehicleDataController.modelYear == null ||
        _settingsVehicleDataController.model == null) {
      appFipeData = AppFipeData(
        selectedMakeType: _settingsVehicleDataController.makeType,
        onBrandChanged: (brand) {
          _settingsVehicleDataController.brand = brand;
          _settingsVehicleDataController.model = null;
          _settingsVehicleDataController.modelYear = null;
        },
        onModelChanged: (model) {
          _settingsVehicleDataController.model = model;
        },
        onModelYearChanged: (modelYear) {
          _settingsVehicleDataController.modelYear = modelYear;
          _settingsVehicleDataController.model = null;
        },
      );
    } else {
      final FIPEService fipeService = DIContainer().get<FIPEService>();

      List<FipeBrand> brands;
      List<FipeModelYearSummary> modelYears;
      List<FipeModelSummary> models;

      fipeService.getBrands(makeType).then((brandsData) {
        brands = brandsData;
        fipeService
            .getModelYears(_settingsVehicleDataController.brand)
            .then((modelYearsData) {
          modelYears = modelYearsData;
          FipeModelYearSummary currentModelYear =
              _settingsVehicleDataController.modelYear;

          for (FipeModelYearSummary mYear in modelYears) {
            if (_settingsVehicleDataController.modelYear.name == mYear.id) {
              currentModelYear = mYear;
            }
          }

          fipeService
              .getModels(_settingsVehicleDataController.brand, currentModelYear)
              .then((modelsData) {
            models = modelsData;
            Future.delayed(Duration(milliseconds: 300), () {
              setState(() {
                appFipeData = AppFipeData(
                  selectedModelYear: currentModelYear,
                  selectedBrand: _settingsVehicleDataController.brand,
                  selectedMakeType: _settingsVehicleDataController.makeType,
                  selectedModel: _settingsVehicleDataController.model,
                  brands: brands,
                  modelYears: modelYears,
                  models: models,
                  onBrandChanged: (brand) {
                    _settingsVehicleDataController.brand = brand;
                    _settingsVehicleDataController.model = null;
                    _settingsVehicleDataController.modelYear = null;
                  },
                  onModelChanged: (model) {
                    _settingsVehicleDataController.model = model;
                  },
                  onModelYearChanged: (modelYear) {
                    _settingsVehicleDataController.modelYear = modelYear;
                    _settingsVehicleDataController.model = null;
                  },
                );
              });
            });
          });
        });
      });
    }
  }
}
