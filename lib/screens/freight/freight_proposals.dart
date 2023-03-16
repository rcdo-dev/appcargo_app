import 'package:app_cargo/di/container.dart';
import 'package:app_cargo/domain/freight_details/freight_details.dart';
import 'package:app_cargo/screens/freight/widget/AppFreightItem.dart';
import 'package:app_cargo/services/freight/freight_mock_service.dart';
import 'package:app_cargo/services/freight/freight_service.dart';
import 'package:app_cargo/services/me/me_service.dart';
import 'package:app_cargo/widgets/app_horizontal_divider.dart';
import 'package:app_cargo/widgets/app_loading_widget.dart';
import 'package:app_cargo/widgets/app_refresh_indicator.dart';
import 'package:app_cargo/widgets/app_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:app_cargo/constants/dimen.dart';
import 'package:app_cargo/constants/app_colors.dart';
import 'package:flutter_skywalker_core/flutter_skywalker_core.dart';

class FreightProposals extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _FreightProposalsState();
}

class _FreightProposalsState extends State<FreightProposals> {
  FreightService _freightService = DIContainer().get<FreightService>();
  MeService _meService = DIContainer().get<MeService>();
  Widget _proposalsWidget = AppLoadingWidget();
  Future _loaded;

  @override
  void initState() {
    super.initState();
    _loaded = _freightService.getAllFreightProposals().then(
      (object) {
        return _buildProposalsWidgets(object);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: "PROPOSTAS",
      body: Column(
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
                  vertical: Dimen.vertical_padding),
              child: Column(
                children: <Widget>[
                  Container(
                    child: SkyText(
                      "MINHAS PROPOSTAS",
                      textColor: AppColors.blue,
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                    ),
                  ),
                  FutureBuilder(
                    future: _loaded,
                    builder: (context, snapshot) {
                      switch (snapshot.connectionState) {
                        case ConnectionState.done:
                          return _proposalsWidget;
                          break;
                        default:
                          return AppLoadingWidget();
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _buildProposalsWidgets(List<FreightDetails> dbProposals) {
    _proposalsWidget = RefreshIndicator(
      onRefresh: _refreshProposals,
      child: Column(
        children: _listFreight(dbProposals),
      ),
    );
  }

  List<Widget> _listFreight(List<FreightDetails> dbProposals) {
    List<Widget> widgets = new List<Widget>();
    print("Chegei no método");

    if (dbProposals.length == 0) {
      widgets.add(
        Container(
          height: MediaQuery.of(context).size.height -
              (MediaQuery.of(context).size.height * 0.25),
          alignment: Alignment.center,
          child: SkyText(
            "Sem propostas no momento.",
            textColor: AppColors.green,
            fontSize: 25,
          ),
        ),
      );
    }

    print("Tem proposta");

    for (FreightDetails proposal in dbProposals) {
      widgets.add(
        new Container(
          padding: EdgeInsets.symmetric(vertical: Dimen.vertical_padding + 10),
          child: AppFreightItem(
            proposal,
            proposal: true,
          ),
        ),
      );
      widgets.add(AppHorizontalDivider());
    }

    print(widgets.length);

    return widgets;
  }

  Future<void> _refreshProposals() {
    setState(() {
      _loaded = _meService.getAllDriverData().then(
        (profileSummary) {
          _freightService.getAllFreightProposals().then(
            (proposals) {
              _buildProposalsWidgets(proposals);
            },
          );
        },
      );
    });
    return _loaded;
  }
}
