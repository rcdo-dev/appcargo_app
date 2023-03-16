import 'package:app_cargo/constants/app_colors.dart';
import 'package:app_cargo/db/current_freight_dao.dart';
import 'package:app_cargo/db/database_provider.dart';
import 'package:app_cargo/db/freight_proposals_dao.dart';
import 'package:app_cargo/di/container.dart';
import 'package:app_cargo/domain/freight_details/freight_details.dart';
import 'package:app_cargo/screens/freight/widget/AppFreightItem.dart';
import 'package:app_cargo/services/freight/freight_mock_service.dart';
import 'package:app_cargo/services/freight/freight_service.dart';
import 'package:app_cargo/services/me/me_service.dart';
import 'package:app_cargo/widgets/app_action_button.dart';
import 'package:app_cargo/widgets/app_loading_widget.dart';
import 'package:app_cargo/widgets/app_scaffold.dart';
import 'package:app_cargo/widgets/app_small_button.dart';
import 'package:flutter/material.dart';
import 'package:app_cargo/constants/dimen.dart';
import 'package:flutter_skywalker_core/flutter_skywalker_core.dart';

import '../../routes.dart';

class FreightCurrent extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => FreightCurrentState();
}

class FreightCurrentState extends State<FreightCurrent> {
  final MeService _meService = DIContainer().get<MeService>();
  final FreightMockService _freightService = DIContainer().get<FreightMockService>();
  FreightDetails _currentFreightDetails;
  Future _loaded;
  
  @override
  void initState() {
    super.initState();
    _loaded = _freightService.getCurrentFreight().then((listFreightDetailsDB){
      _currentFreightDetails = listFreightDetailsDB;
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: "FRETES",
      body: Column(
        children: <Widget>[
          FutureBuilder(
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.done:
                  if (snapshot.hasData) {
                    return _buildProposalsButton(snapshot.data);
                  } else {
                    return _buildProposalsButton(0);
                  }
                  break;
                default:
                  return Container(
                    height: 55,
                    child: FittedBox(
                      fit: BoxFit.fitHeight,
                      child: AppLoadingWidget(),
                    ),
                  );
              }
            },
            future: _meService.getProposalsQuantity(),
          ),
          AppSmallButton(
            text: "PROCURAR POR FRETES",
            icon: Icon(
              Icons.search,
              color: AppColors.yellow,
            ),
            textColor: AppColors.blue,
            verticalPadding: Dimen.vertical_padding + 2,
            onPressed: () {
              Navigator.pushNamed(context, Routes.freightSearch);
            },
          ),
          Container(
            child: Column(
              children: <Widget>[
                Container(
                  child: Container(
                    decoration: new BoxDecoration(
                      color: AppColors.white,
                      borderRadius: new BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                    padding: EdgeInsets.symmetric(
                        horizontal: Dimen.horizontal_padding,
                        vertical: Dimen.horizontal_padding),
                    child: Column(
                      children: <Widget>[
                        Container(
                          child: SkyText(
                            "SEU FRETE ATUAL",
                            textColor: AppColors.yellow,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                        FutureBuilder(
                          builder: (context, snapshot) {
                            switch (snapshot.connectionState) {
                              case ConnectionState.done:
                                return _buildCurrentFreight();
                                break;
                              default:
                                return AppLoadingWidget();
                            }
                          },
                          future: _loaded,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          AppActionButton(
            "MEUS FRETES",
            onPressed: () {
              Navigator.pushNamed(context, Routes.freightHistory);
            },
            borderColor: AppColors.white,
          )
        ],
      ),
    );
  }

  Widget _buildCurrentFreight() {
    if (_currentFreightDetails != null) {
      return Container(
        child: AppFreightItem(
          _currentFreightDetails,
        ),
      );
    } else {
      return Container(
        alignment: Alignment.center,
        child: SkyText(
          "Você está sem carga no momento.",
          fontSize: 25,
          textColor: AppColors.green,
        ),
      );
    }
  }

  Widget _buildProposalsButton(int quantityProposals) {
    return AppSmallButton(
      text: "VOCÊ TEM  " + quantityProposals.toString() + " PROPOSTAS",
      icon: Icon(
        Icons.info_outline,
        color: AppColors.yellow,
      ),
      onPressed: () {
        Navigator.pushNamed(context, Routes.freightProposals);
      },
      verticalPadding: Dimen.vertical_padding + 2,
    );
  }
}
