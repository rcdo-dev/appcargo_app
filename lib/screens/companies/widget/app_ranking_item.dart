import 'package:app_cargo/constants/app_colors.dart';
import 'package:app_cargo/constants/dimen.dart';
import 'package:app_cargo/di/container.dart';
import 'package:app_cargo/domain/freight_company_summary/freight_company_summary.dart';
import 'package:app_cargo/services/freight_company/freight_company_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_skywalker_core/flutter_skywalker_core.dart';

import '../../../routes.dart';

class AppRankingItem extends StatefulWidget {
  final FreightCompanySummary freightCompanySummary;
  final String companyRanking;

  const AppRankingItem({Key key, this.freightCompanySummary, this.companyRanking}) : super(key: key);
  
  @override
  State<StatefulWidget> createState() => _AppRankingItemState(freightCompanySummary, companyRanking);
}

class _AppRankingItemState extends State<AppRankingItem>{
  FreightCompanyService _freightCompanyService = DIContainer().get<FreightCompanyService>();
  final FreightCompanySummary _freightCompanySummary;
  final String companyRanking;
  
  _AppRankingItemState(this._freightCompanySummary, this.companyRanking);
  
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: Dimen.vertical_padding),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Container(
                child: SkyText(
                  companyRanking ?? _freightCompanySummary.positionInRanking.toString(),
                  textColor: AppColors.green,
                  fontSize: 20,
                  textAlign: TextAlign.start,
                ),
              ),
            ),
            Expanded(
              flex: 6,
              child: Container(
                child: SkyText(
                  _freightCompanySummary.name,
                  textColor: AppColors.blue,
                  fontSize: 20,
                  textAlign: TextAlign.start,
                ),
              ),
            ),
          ],
        ),
      ),
      onTap: (){
        Navigator.pushNamed(context, Routes.carrierInfo, arguments: {"freightCompanyHash":_freightCompanySummary.hash});
      },
    );
  }
}