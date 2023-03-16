import 'package:app_cargo/constants/app_colors.dart';
import 'package:app_cargo/di/container.dart';
import 'package:app_cargo/domain/city/city.dart';
import 'package:app_cargo/domain/geo/distance_dto.dart';
import 'package:app_cargo/domain/geo/lat_lng.dart';
import 'package:app_cargo/domain/geo/origin_and_destiny.dart';
import 'package:app_cargo/domain/minimum_freight/minimum_freight_load_type.dart';
import 'package:app_cargo/domain/minimum_freight/minimum_freight_load_type_helper.dart';
import 'package:app_cargo/domain/minimum_freight/minimum_freight_truck_axles.dart';
import 'package:app_cargo/domain/minimum_freight/minimum_freight_truck_axles_helper.dart';
import 'package:app_cargo/domain/minimum_freight/minimum_freight_type.dart';
import 'package:app_cargo/domain/minimum_freight/minimum_freight_type_helper.dart';
import 'package:app_cargo/screens/minimum_freight/minimum_freight_controller.dart';
import 'package:app_cargo/screens/minimum_freight/minimum_freight_dialog.dart';
import 'package:app_cargo/services/geo_service/geo_service.dart';
import 'package:app_cargo/widgets/app_city_state_dropdown.dart';
import 'package:app_cargo/widgets/app_dropdown_button.dart';
import 'package:app_cargo/widgets/app_save_button.dart';
import 'package:app_cargo/widgets/app_scaffold.dart';
import 'package:app_cargo/widgets/app_text_field.dart';
import 'package:app_cargo/widgets/show_message_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_skywalker_core/flutter_skywalker_core.dart';

class MinimumFreightScreen extends StatefulWidget {
  @override
  _MinimumFreightScreenState createState() => _MinimumFreightScreenState();
}

class _MinimumFreightScreenState extends State<MinimumFreightScreen> {
  final MinimumFreightLoadTypeHelper _minimumFreightLoadTypeHelper =
      DIContainer().get<MinimumFreightLoadTypeHelper>();
  final MinimumFreightTruckAxlesHelper _minimumFreightTruckAxlesHelper =
      DIContainer().get<MinimumFreightTruckAxlesHelper>();
  final MinimumFreightTypeHelper _minimumFreightTypeHelper =
      DIContainer().get<MinimumFreightTypeHelper>();
  final MinimumFreightController _minimumFreightController =
      MinimumFreightController();
  final GeoService _geoService = DIContainer().get<GeoService>();

  final TextEditingController _distanceTextController = TextEditingController();

  MinimumFreightType _currentFreightType;
  MinimumFreightTruckAxles _currentFreightTruckAxles;
  MinimumFreightLoadType _currentFreightLoadType;

  LatLng origin;
  LatLng destiny;

  int distance = 0;

  @override
  void initState() {
    super.initState();

    _distanceTextController.text = "$distance";
  }

  void _changeDistance(int newDistance) {
    setState(() {
      _distanceTextController.text = "$newDistance";
    });
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: "Calculadora frete mínimo",
      showMenu: false,
      showAppBar: true,
      scrollable: true,
      verticalPadding: 20,
      body: Container(
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(bottom: 10),
              alignment: Alignment.topLeft,
              child: SkyText(
                "Origem do frete",
                textColor: AppColors.blue,
                fontSize: 17,
              ),
            ),
            Container(
                padding: const EdgeInsets.only(bottom: 20),
                child: AppCityStateDropdown(
                  onCityChanged: (City city) {
                    if (origin == null)
                      origin = new LatLng();
                    if (city == null) return;
                    if (city.latitude == null || city.longitude == null)
                      return;
                    origin.latitude = city.latitude;
                    origin.longitude = city.longitude;

                    if (origin != null && destiny != null) {
                      OriginAndDestiny originAndDestiny = OriginAndDestiny();
                      originAndDestiny.origin = origin;
                      originAndDestiny.destiny = destiny;
                      _geoService
                          .getDistanceInMetersBetweenTwoPoints(originAndDestiny)
                          .then((distance) {
                        DistanceDTO distanceDTO = distance;
                        _changeDistance(distanceDTO.distance ~/ 1000);
                      });
                    }
                  },
                  onStateChanged: (state) {
                    origin = null;
                    setState(() {
                      distance = 0;
                      _distanceTextController.text = "$distance";
                    });
                  },
                )),
            Container(
              padding: EdgeInsets.only(bottom: 10),
              alignment: Alignment.topLeft,
              child: SkyText(
                "Destino do frete",
                textColor: AppColors.blue,
                fontSize: 17,
              ),
            ),
            Container(
                padding: EdgeInsets.only(bottom: 15),
                child: AppCityStateDropdown(
                  onCityChanged: (City city) {
                    if (destiny == null)
                      destiny = new LatLng();
                    if (city == null) return;
                    if (city.latitude == null || city.longitude == null)
                      return;
                    destiny.latitude = city.latitude;
                    destiny.longitude = city.longitude;

                    if (origin != null && destiny != null) {
                      OriginAndDestiny originAndDestiny = OriginAndDestiny();
                      originAndDestiny.origin = origin;
                      originAndDestiny.destiny = destiny;
                      _geoService
                          .getDistanceInMetersBetweenTwoPoints(originAndDestiny)
                          .then((distance) {
                        DistanceDTO distanceDTO = distance;
                        _changeDistance(distanceDTO.distance ~/ 1000);
                      });
                    }
                  },
                  onStateChanged: (state) {
                    destiny = null;
                    setState(() {
                      distance = 0;
                      _distanceTextController.text = "$distance";
                    });
                  },
                )),
            AppTextField(
              textEditingController: _distanceTextController,
              label: "Distância (km)",
              enable: false,
              inputType: TextInputType.number,
            ),
            Container(
              padding: const EdgeInsets.only(top: 20),
              alignment: Alignment.center,
              child: SkyText(
                "Tipo do frete",
                textColor: AppColors.blue,
                fontSize: 17,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20, bottom: 15),
              child: AppDropdownButton<MinimumFreightType>(
                enable: true,
                createFriendlyFirstItem: true,
                friendlyFirstItemText: "Selecione...",
                items: _minimumFreightTypeHelper.values(),
                resolver: (MinimumFreightType option) => option.name(),
                onChanged: (MinimumFreightType freightType) {
                  _currentFreightType = freightType;
                },
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 10),
              alignment: Alignment.center,
              child: SkyText(
                "Número de eixos",
                textColor: AppColors.blue,
                fontSize: 17,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20, bottom: 15),
              child: AppDropdownButton<MinimumFreightTruckAxles>(
                enable: true,
                createFriendlyFirstItem: true,
                friendlyFirstItemText: "Selecione...",
                items: _minimumFreightTruckAxlesHelper.values(),
                resolver: (MinimumFreightTruckAxles option) => option.name(),
                onChanged: (MinimumFreightTruckAxles freightTruckAxles) {
                  _currentFreightTruckAxles = freightTruckAxles;
                },
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 10),
              alignment: Alignment.center,
              child: SkyText(
                "Tipo de carga",
                textColor: AppColors.blue,
                fontSize: 17,
              ),
            ),
            Padding(
                padding: EdgeInsets.only(top: 20, bottom: 15),
                child: AppDropdownButton<MinimumFreightLoadType>(
                  enable: true,
                  createFriendlyFirstItem: true,
                  friendlyFirstItemText: "Selecione",
                  items: _minimumFreightLoadTypeHelper.values(),
                  resolver: (MinimumFreightLoadType option) => option.name(),
                  onChanged: (MinimumFreightLoadType freightLoadType) {
                    _currentFreightLoadType = freightLoadType;
                  },
                )),
            Container(
              padding: EdgeInsets.only(top: 20),
              child: AppSaveButton(
                "Calcular",
                onPressed: () {
                  if (_distanceTextController.text == null ||
                      _distanceTextController.text.isEmpty) {
                    showMessageDialog(context,
                        type: DialogType.ERROR, message: "Informe a distância");
                    return;
                  }

                  double distanceInKilometers = 0.0;

                  try {
                    distanceInKilometers =
                        double.parse(_distanceTextController.text);
                  } catch (ex) {
                    showMessageDialog(context,
                        type: DialogType.ERROR,
                        message: "Insira a distância no formato correto");
                    return;
                  }

                  if (origin == null || destiny == null) {
                    showMessageDialog(context,
                        type: DialogType.ERROR,
                        message: "Preencha a origem e o destino corretamente");
                    return;
                  }

                  if (distanceInKilometers < 1) {
                    showMessageDialog(context,
                        type: DialogType.ERROR,
                        message: "A distância deve ser maior que zero");
                    return;
                  }

                  String errors = _minimumFreightController.validate(
                      distanceInKilometers,
                      _currentFreightType,
                      _currentFreightLoadType,
                      _currentFreightTruckAxles);

                  if (errors != null) {
                    showMessageDialog(context,
                        type: DialogType.ERROR, message: errors);
                  } else {
                    double displacementCost =
                        _minimumFreightController.calculateDisplacementCost(
                            distanceInKilometers,
                            _currentFreightType,
                            _currentFreightLoadType,
                            _currentFreightTruckAxles);

                    double loadAndUnloadCost =
                        _minimumFreightController.calculateLoadAndUnloadCost(
                            _currentFreightType,
                            _currentFreightLoadType,
                            _currentFreightTruckAxles);

                    if (displacementCost == null || loadAndUnloadCost == null) {
                      showMessageDialog(context,
                          type: DialogType.ERROR,
                          message:
                              "Quantidade de eixos inválida para o tipo de carga");
                    } else {
                      double total = _minimumFreightController.calculateTotal(
                          displacementCost, loadAndUnloadCost);

                      showMinimumFreightDialog(
                          context, displacementCost, loadAndUnloadCost, total);
                    }
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
