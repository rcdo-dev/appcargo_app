import 'package:app_cargo/constants/app_colors.dart';
import 'package:app_cargo/constants/dimen.dart';
import 'package:app_cargo/di/container.dart';
import 'package:app_cargo/domain/freight_company_summary/freight_company_summary.dart';
import 'package:app_cargo/domain/freight_company_summary_pageable/freight_company_summary_pageable.dart';
import 'package:app_cargo/domain/freight_summary/paged_freightco_summary.dart';
import 'package:app_cargo/screens/companies/widget/app_ranking_item.dart';
import 'package:app_cargo/services/freight_company/freight_company_mock_service.dart';
import 'package:app_cargo/services/freight_company/freight_company_service.dart';
import 'package:app_cargo/widgets/app_loading_widget.dart';
import 'package:app_cargo/widgets/app_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_skywalker_core/flutter_skywalker_core.dart';

class RankingCompanies extends StatelessWidget {
  final FreightCompanyService _freightCompanyService =
  DIContainer().get<FreightCompanyService>();
  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: "EMPRESA",
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
                  alignment: Alignment.center,
                  child: SkyText(
                    "LISTA DE TRANSPORTADORAS\nCADASTRADAS",
                    textColor: AppColors.green,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Container(
                  padding:
                  EdgeInsets.symmetric(vertical: Dimen.horizontal_padding),
                  child: FutureBuilder(
                    builder: (context, snapshot) {
                      switch (snapshot.connectionState) {
                        case ConnectionState.done:
                          if (snapshot.hasData) {
                            return Column(
                              children: ranking(snapshot.data),
                            );
                          }
                          return Container(
                            child: SkyText(
                              "Ainda não existem dados cadastrados.",
                              textColor: AppColors.green,
                              fontSize: 25,
                            ),
                          );
                          break;
                        default:
                          return AppLoadingWidget();
                      }
                    },
                    future: _freightCompanyService.getCompanyByRanking(0, 500),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> ranking(PagedFreightCoSummary _ranking) {
    List<Widget> list = new List<Widget>();
    for (int i = 0; i < _ranking.recordsTotal; i++) {
      try {
        list.add(
          Container(
            child: AppRankingItem(
              freightCompanySummary: _ranking.data[i],
              companyRanking: i.toString(),
            ),
          ),
        );
      }catch(error) {}
    }

    return list;
  }
}
