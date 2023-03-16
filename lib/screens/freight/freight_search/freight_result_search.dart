import 'package:app_cargo/constants/app_colors.dart';
import 'package:app_cargo/di/container.dart';
import 'package:app_cargo/domain/city/city.dart';
import 'package:app_cargo/domain/freight_details/freight_details.dart';
import 'package:app_cargo/screens/freight/widget/AppFreightItem.dart';
import 'package:app_cargo/services/freight/freight_mock_service.dart';
import 'package:app_cargo/widgets/app_button_two_align.dart';
import 'package:app_cargo/widgets/app_horizontal_divider.dart';
import 'package:app_cargo/widgets/app_save_button.dart';
import 'package:app_cargo/widgets/app_scaffold.dart';
import 'package:app_cargo/widgets/app_switch_settings.dart';
import 'package:app_cargo/widgets/app_text_field.dart';
import 'package:flutter/material.dart';
import 'package:app_cargo/constants/dimen.dart';
import 'package:flutter_skywalker_core/flutter_skywalker_core.dart';

part 'freight_result_search_controller.dart';

class FreightResultSearch extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => FreightResultSearchState();
}

class FreightResultSearchState extends State<FreightResultSearch> {
  FreightResultSearchController _freightResultSearchController;
  final FreightMockService _freightService =
      DIContainer().get<FreightMockService>();
  List<FreightDetails> _searchResult;
  City _fromCity = new City(name: "erro", hash: "erro");
  Widget _searchPresentationText = Container();

  void initState() {
    _freightResultSearchController = new FreightResultSearchController();
    _searchResult = new List<FreightDetails>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> args = ModalRoute.of(context).settings.arguments;
    if (null != args && args.isNotEmpty) {
      _searchResult = args["searchResult"] as List<FreightDetails>;
      _fromCity = args["fromCity"] as City;
      print(_fromCity);
    }

    if (_fromCity != null) {
      _searchPresentationText = Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.symmetric(vertical: Dimen.vertical_padding),
            alignment: Alignment.center,
            child: SkyText(
              "${_searchResult.length} fretes encontrados com saída de ${null == _fromCity.name ? 'seu local' : _fromCity.name}",
              textColor: AppColors.green,
              textAlign: TextAlign.center,
              fontSize: 25,
            ),
          ),
          AppHorizontalDivider()
        ],
      );
    } else {
      _searchPresentationText = Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.symmetric(vertical: Dimen.vertical_padding),
            alignment: Alignment.center,
            child: SkyText(
              "${_searchResult.length} fretes encontrados com saída da sua localização atual",
              textColor: AppColors.green,
              textAlign: TextAlign.center,
              fontSize: 25,
            ),
          ),
          AppHorizontalDivider()
        ],
      );
    }

    return AppScaffold(
      title: "FRETES",
      body: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.symmetric(vertical: Dimen.horizontal_padding),
            child: SkyText(
              "Resultado da busca",
              fontSize: 30,
              textColor: AppColors.blue,
              fontWeight: FontWeight.bold,
            ),
          ),
          Container(
            padding: EdgeInsets.all(Dimen.horizontal_padding),
            decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(15)),
            child: Column(
              children: <Widget>[
                _searchPresentationText,
                _buildSearchResult(),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildSearchResult() {
    List<Widget> freightItems = new List<Widget>();
    
    for (FreightDetails item in _searchResult) {
      freightItems.add(AppFreightItem(item));
      freightItems.add(AppHorizontalDivider());
    }
    return Column(
      children: freightItems,
    );
  }

  final List<String> states = [
    "ACRE",
    "ALAGOAS",
    "AMAPÁ",
    "AMAZONAS",
    "BAHIA",
    "CEARÁ",
    "DISTRITO FEDERAL",
    "ESPÍRITO SANTO",
    "GOIÁS",
    "MARANHÃO",
    "MATO GROSSO",
    "MATO GROSSO DO SUL",
    "MINAS GERAIS",
    "PARÁ",
    "PARAÍBA",
    "PARANÁ",
    "PERNAMBUCO",
    "PIAUÍ",
    "RIO DE JANEIRO",
    "RIO GRANDE DO NORTE",
    "RIO GRANDE DO SUL",
    "RONDONIA",
    "RORAIMA",
    "SANTA CATARINA",
    "SÃO PAULO",
    "SERGIPE",
    "TOCANTINS",
  ];

  final List<String> regions = [
    "NORTE",
    "NORDESTE",
    "CENTRO-OESTE",
    "SUDESTE",
    "SUL",
  ];
}
