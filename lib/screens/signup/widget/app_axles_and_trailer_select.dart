import 'package:app_cargo/constants/app_colors.dart';
import 'package:app_cargo/domain/truck/truck.dart';
import 'package:app_cargo/widgets/app_dropdown_button.dart';
import 'package:app_cargo/widgets/app_dropdown_button_second_ui.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_skywalker_core/flutter_skywalker_core.dart';

typedef OnAxlesChangedCallback = void Function(TruckAxles);
typedef OnTrailerTypeChangedCallback = void Function(TrailerType);

class AppAxlesAndTrailerSelect extends StatefulWidget {
  final TruckType truckType;

  final OnAxlesChangedCallback onAxlesChanged;
  final OnTrailerTypeChangedCallback onTrailerTypeChanged;

  final TrailerType defaultTrailerType;
  final TruckAxles defaultTruckAxles;

  AppAxlesAndTrailerSelect(this.truckType,
      {this.defaultTrailerType,
      this.defaultTruckAxles,
      this.onAxlesChanged,
      this.onTrailerTypeChanged});

  @override
  _TrailerTypeSelectState createState() => _TrailerTypeSelectState(
      truckType,
      onAxlesChanged,
      onTrailerTypeChanged,
      defaultTrailerType,
      defaultTruckAxles);
}

class _TrailerTypeSelectState extends State<AppAxlesAndTrailerSelect> {
  final TruckType truckType;

  final OnAxlesChangedCallback onAxlesChanged;
  final OnTrailerTypeChangedCallback onTrailerTypeChanged;

  final TrailerType defaultTrailerType;
  final TruckAxles defaultTruckAxles;

  bool showAxlesDropdown = false;
  bool showTrailerTypesDropdown = false;

  // Sublist of trailer types
  List<TrailerType> _utilitaryTrailerTypes;
  List<TrailerType> _normalTrailerTypes;

  // Current list values
  List<TruckAxles> _truckAxlesList;
  List<TrailerType> _trailerTypesList;

  _TrailerTypeSelectState(
      this.truckType,
      this.onAxlesChanged,
      this.onTrailerTypeChanged,
      this.defaultTrailerType,
      this.defaultTruckAxles);

  @override
  void initState() {
    super.initState();

    _utilitaryTrailerTypes = [TrailerType.ABERTO, TrailerType.FECHADO];
    _normalTrailerTypes = [
      TrailerType.BAU,
      TrailerType.BAU_FRIGORIFICO,
      TrailerType.SIDER,
      TrailerType.CACAMBA,
      TrailerType.GRADE_BAIXA,
      TrailerType.GRANELEIRA,
      TrailerType.PRANCHA,
      TrailerType.TANQUE,
      TrailerType.GAIOLA
    ];

    if (truckType == TruckType.UTILITARIO) {
      _trailerTypesList = _utilitaryTrailerTypes;

      showAxlesDropdown = false;
      showTrailerTypesDropdown = true;
    } else if (truckType == TruckType.CAMINHAO_VUC ||
        truckType == TruckType.CAMINHAO_3_4 ||
        truckType == TruckType.CAMINHAO_TOCO ||
        truckType == TruckType.CAMINHAO_TRUCK ||
        truckType == TruckType.CAMINHAO_TRACADO ||
        truckType == TruckType.CAMINHAO_BITRUCK) {
      _trailerTypesList = _normalTrailerTypes;

      showAxlesDropdown = false;
      showTrailerTypesDropdown = true;
    } else if (truckType == TruckType.CAVALO_MECANICO_TOCO ||
        truckType == TruckType.CAVALO_MECANICO_TRUCADO ||
        truckType == TruckType.CAVALO_MECANICO_TRACADO ||
        truckType == TruckType.CAVALO_MECANICO_TRACADO_8_4) {
      _truckAxlesList = TruckAxlesHelper().values();

      showAxlesDropdown = true;

      // assuming the first item is CAVALO_MECANICO_TOCO, the trailer dropdown will not appear
      showTrailerTypesDropdown = false;
    }

    if (defaultTruckAxles != null && defaultTrailerType != null) {
      setState(() {
        if (defaultTruckAxles == TruckAxles.CARRETA_2_EIXOS ||
            defaultTruckAxles == TruckAxles.CARRETA_3_EIXOS ||
            defaultTruckAxles == TruckAxles.CARRETA_4_EIXOS ||
            defaultTruckAxles == TruckAxles.CARRETA_5_EIXOS ||
            defaultTruckAxles == TruckAxles.CARRETA_6_EIXOS) {
          setState(() {
            showTrailerTypesDropdown = true;
            _trailerTypesList = _normalTrailerTypes;
            //onAxlesChanged(defaultTruckAxles);
          });
        } else {
          setState(() {
            if (defaultTruckAxles == TruckAxles.CAVALO_MECANICO) {
              showTrailerTypesDropdown = false;
            }
            //onAxlesChanged(defaultTruckAxles);
          });
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Column(
          children: <Widget>[
            if (showAxlesDropdown)
              Container(
                padding: EdgeInsets.only(bottom: 10),
                child: SkyText(
                  "Quantidade de eixos",
                  textColor: AppColors.blue,
                ),
              ),
            if (showAxlesDropdown)
              AppDropdownButtonSecondUI<TruckAxles>(
                items: _truckAxlesList,
                onChanged: (TruckAxles axles) {
                  if (axles == TruckAxles.CARRETA_2_EIXOS ||
                      axles == TruckAxles.CARRETA_3_EIXOS ||
                      axles == TruckAxles.CARRETA_4_EIXOS ||
                      axles == TruckAxles.CARRETA_5_EIXOS ||
                      axles == TruckAxles.CARRETA_6_EIXOS) {
                    setState(() {
                      showTrailerTypesDropdown = true;
                      _trailerTypesList = _normalTrailerTypes;
                      onAxlesChanged(axles);
                    });
                  } else {
                    setState(() {
                      if (axles == TruckAxles.CAVALO_MECANICO) {
                        showTrailerTypesDropdown = false;
                      }
                      onAxlesChanged(axles);
                    });
                  }
                },
                currentItem: defaultTruckAxles,
                createFriendlyFirstItem: true,
                resolver: (TruckAxles axles) => axles.name(),
              ),
            if (showTrailerTypesDropdown)
              Container(
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.only(bottom: 10, top: 10),
                alignment: Alignment.centerLeft,
                child: SkyText(
                  "Tipo da carroceria",
                  textColor: AppColors.grey,
                  fontWeight: FontWeight.bold,
                  fontSize: 19,
                  textAlign: TextAlign.left,
                ),
              ),
            if (showTrailerTypesDropdown)
              AppDropdownButtonSecondUI<TrailerType>(
                items: _trailerTypesList,
                onChanged: (TrailerType trailerType) {
                  onTrailerTypeChanged(trailerType);
                },
                currentItem: defaultTrailerType,
                createFriendlyFirstItem: true,
                resolver: (TrailerType trailerType) => trailerType.name(),
                dropTextSize: 15,
                dropIconSize: 17,
                dropDownWidth: 20,
              ),
          ],
        ),
      ],
    );
  }
}
