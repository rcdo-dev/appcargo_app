import 'package:app_cargo/constants/app_colors.dart';
import 'package:app_cargo/constants/default_api_errors.dart';
import 'package:app_cargo/di/container.dart';
import 'package:app_cargo/domain/city/city.dart';
import 'package:app_cargo/domain/freight_details/freight_details.dart';
import 'package:app_cargo/domain/freight_search/freight_search_query.dart';
import 'package:app_cargo/domain/lat_lng/lat_lng.dart';
import 'package:app_cargo/domain/location/location.dart';
import 'package:app_cargo/services/freight/freight_mock_service.dart';
import 'package:app_cargo/services/freight/freight_service.dart';
import 'package:app_cargo/services/location/location_service.dart';
import 'package:app_cargo/widgets/app_checkbox.dart';
import 'package:app_cargo/widgets/app_city_state_dropdown.dart';
import 'package:app_cargo/widgets/app_horizontal_divider.dart';
import 'package:app_cargo/widgets/app_loading_dialog.dart';
import 'package:app_cargo/widgets/app_save_button.dart';
import 'package:app_cargo/widgets/app_scaffold.dart';
import 'package:app_cargo/widgets/show_message_dialog.dart';
import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:app_cargo/constants/dimen.dart';
import 'package:flutter_background_geolocation/flutter_background_geolocation.dart'
as Geolocator;
import 'package:flutter_skywalker_core/flutter_skywalker_core.dart';
import 'package:numberpicker/numberpicker.dart';

import '../../../../routes.dart';

part 'freight_search_controller.dart';

class FreightSearch extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => FreightSearchState();
}

class FreightSearchState extends State<FreightSearch> {
  final FreightService _freightService = DIContainer().get<FreightService>();
  final LocationService _locationService = DIContainer().get<LocationService>();
  FreightSearchController _freightSearchController;
  
  void initState() {
    super.initState();
    _freightSearchController = new FreightSearchController();
  }
  
  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: "FRETES",
      body: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(Dimen.horizontal_padding),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(15)),
            child: Column(
              children: <Widget>[
                Container(
                  padding:
                  EdgeInsets.symmetric(vertical: Dimen.vertical_padding),
                  alignment: Alignment.center,
                  child: SkyText(
                    "Informe a localização para\nvisualizar fretes compatíveis",
                    textColor: AppColors.green,
                    textAlign: TextAlign.center,
                    fontSize: 25,
                  ),
                ),
                Container(
                  padding:
                  EdgeInsets.symmetric(vertical: Dimen.horizontal_padding),
                  child: SkyText(
                    "Local de Origem (obrigatorio)",
                    fontWeight: FontWeight.bold,
                    textColor: AppColors.blue,
                    fontSize: 20,
                  ),
                ),
                AppCityStateDropdown(
                  onCityChanged: _onFromCityChanged,
                  showCitySelect: false,
                ),
                Container(
                  padding:
                  EdgeInsets.symmetric(vertical: Dimen.horizontal_padding),
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.symmetric(
                          vertical: Dimen.vertical_padding,
                          horizontal: Dimen.horizontal_padding),
                        child: SkyText(
                          "Raio do local de origem (Km)",
                          fontSize: 16,
                          textColor: AppColors.blue,
                          textAlign: TextAlign.start,
                        ),
                      ),
                      Container(
                        height: 100,
                        width: 80,
                        child: FittedBox(
                          fit: BoxFit.cover,
                          child: NumberPicker.integer(
                            initialValue: 0,
                            minValue: 0,
                            maxValue: 1000,
                            onChanged: (value) {
                              _freightSearchController.fromRadius = value;
                            },
                            scrollDirection: Axis.vertical,
                            step: 10,
                            itemExtent: 33,
                            highlightSelectedValue: true,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: AppColors.grey),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                AppHorizontalDivider(),
                Container(
                  padding:
                  EdgeInsets.symmetric(vertical: Dimen.horizontal_padding),
                  child: SkyText(
                    "Local de Destino (opcional)",
                    fontWeight: FontWeight.bold,
                    textColor: AppColors.blue,
                    fontSize: 20,
                  ),
                ),
                AppCityStateDropdown(
                  onCityChanged: _onToCityChanged,
                  showCitySelect: false,
                ),
                Container(
                  padding:
                  EdgeInsets.symmetric(vertical: Dimen.horizontal_padding),
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.symmetric(
                          vertical: Dimen.vertical_padding,
                          horizontal: Dimen.horizontal_padding),
                        child: SkyText(
                          "Raio do local de destino (Km)",
                          fontSize: 16,
                          textColor: AppColors.blue,
                          textAlign: TextAlign.start,
                        ),
                      ),
                      Container(
                        height: 100,
                        width: 80,
                        child: FittedBox(
                          fit: BoxFit.cover,
                          child: NumberPicker.integer(
                            initialValue: 0,
                            minValue: 0,
                            maxValue: 1000,
                            onChanged: (value) {
                              _freightSearchController.toRadius = value;
                            },
                            scrollDirection: Axis.vertical,
                            step: 10,
                            itemExtent: 33,
                            highlightSelectedValue: true,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: AppColors.grey),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                AppHorizontalDivider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    SkyText(
                      "Até o valor máximo da ANTT?",
                      fontSize: 18,
                      textColor: AppColors.blue,
                      textAlign: TextAlign.start,
                    ),
                    AppCheckbox(
                      onChanged: (bool changed) {
                        _freightSearchController.antt = changed;
                      },
                      isCheck: _freightSearchController.antt,
                    ),
                  ],
                ),
                Container(
                  padding:
                  EdgeInsets.symmetric(vertical: Dimen.horizontal_padding),
                  child: AppSaveButton(
                    "BUSCAR",
                    onPressed: () {
                      _searchByFreightSearchQuery(context);
                    },
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(top: Dimen.horizontal_padding),
                  child: SkyText(
                    "Buscar qualquer frete\npróximo a mim",
                    fontSize: 17,
                    textColor: AppColors.blue,
                  ),
                ),
                Container(
                  padding:
                  EdgeInsets.symmetric(vertical: Dimen.horizontal_padding),
                  child: AppSaveButton(
                    "BUSCAR QUALQUER",
                    onPressed: () {
                      _searchByActualPosition(context);
                    },
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
  
  void _onFromCityChanged(City fromCity) {
    _freightSearchController.fromCity = fromCity;
  }
  
  void _onToCityChanged(City toCity) {
    _freightSearchController.toCity = toCity;
  }
  
  void _searchByFreightSearchQuery(BuildContext context) {
    if (_freightSearchController.fromCity == null ||
      _freightSearchController.fromRadius == 0) {
      showMessageDialog(context,
        message: "Selecione a cidade e o raio de busca do frete.");
      return;
    }
    showLoadingDialog(context);
    _freightService
      .searchFreights(_freightSearchController.getFreightSearchQuery())
      .then(
        (searchResult) {
        if (searchResult is List<FreightDetails>) {
          Navigator.popAndPushNamed(
            context,
            Routes.freightResultSearch,
            arguments: {
              "searchResult": searchResult,
              "fromCity": _freightSearchController.fromCity,
            },
          );
        }
      },
    );
  }
  
  void _searchByActualPosition(BuildContext context) {
    showLoadingDialog(context);
    _locationService.getCurrentLocation().then((currentLocation) {
      if (currentLocation is Geolocator.Location) {
        LatLng position = new LatLng(
          latitude: currentLocation.coords.latitude.toString(),
          longitude: currentLocation.coords.longitude.toString());
        _freightSearchController.position = position;
        print(LatLng.toJson(position));
        return _freightService
          .searchFreights(
          _freightSearchController.getFreightSearchQueryPosition())
          .then(
            (searchResult) {
            if (searchResult is List<FreightDetails>) {
              Navigator.popAndPushNamed(
                context,
                Routes.freightResultSearch,
                arguments: {
                  "searchResult": searchResult,
                  "fromState": null,
                  "fromCity": null,
                },
              );
            }
          },
        );
      }
      return null;
    });
  }

//  void _showRadiusDialog(BuildContext context, bool from) {
//    showDialog(
//      context: context,
//      child: SimpleDialog(
//        shape: RoundedRectangleBorder(
//          borderRadius: BorderRadius.circular(10),
//        ),
//        children: <Widget>[
//          Container(
//            padding: EdgeInsets.all(Dimen.vertical_padding),
//            child: Column(
//              children: <Widget>[
//                Container(
//                  child: SkyText(
//                    "Raio de busca",
//                    textColor: AppColors.green,
//                    textAlign: TextAlign.center,
//                    fontSize: 25,
//                  ),
//                ),
//                Container(
//                  padding:
//                      EdgeInsets.symmetric(vertical: Dimen.horizontal_padding),
//                  child: SkyText(
//                    "Visualizar cargas em um espaço de ...",
//                    textColor: AppColors.blue,
//                    textAlign: TextAlign.center,
//                    fontSize: 20,
//                  ),
//                ),
//                Container(
//                  width: 150,
//                  padding: EdgeInsets.symmetric(
//                      horizontal: Dimen.horizontal_padding),
//                  child: AppTextField(
//                    inputType: TextInputType.numberWithOptions(decimal: false),
//                    suffixIcon: Container(
//                      width: 50,
//                      alignment: Alignment.center,
//                      child: SkyText("KM"),
//                    ),
//                    onChanged: (text) {
//                      if (from)
//                        _freightSearchController.fromRadius = text;
//                      else
//                        _freightSearchController.toRadius = text;
//                    },
//                  ),
//                ),
//                Container(
//                  padding:
//                      EdgeInsets.symmetric(vertical: Dimen.horizontal_padding),
//                  child: SkyText(
//                    "do meu veículo",
//                    textColor: AppColors.blue,
//                    textAlign: TextAlign.center,
//                    fontSize: 20,
//                  ),
//                ),
//                Container(
//                  alignment: Alignment.center,
//                  child: AppSaveButton(
//                    "SALVAR",
//                    onPressed: () {
//                      Navigator.pop(context);
//                    },
//                  ),
//                ),
//              ],
//            ),
//          )
//        ],
//      ),
//    );
//  }
}
