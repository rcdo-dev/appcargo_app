import 'package:app_cargo/constants/app_colors.dart';
import 'package:app_cargo/constants/dimen.dart';
import 'package:app_cargo/domain/freight_company_detail/freight_company_detail.dart';
import 'package:app_cargo/screens/companies/widget/app_evaluate_company.dart';
import 'package:app_cargo/widgets/app_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_skywalker_core/flutter_skywalker_core.dart';

import '../../routes.dart';

class EvaluateCompany extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    FreightCompanyDetail _freightCompanyDetail;
    Map<String, dynamic> args = ModalRoute.of(context).settings.arguments;
    if (null != args && args.isNotEmpty) {
      _freightCompanyDetail = args["freightCompanyDetail"] as FreightCompanyDetail;
    }
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
                  padding:
                      EdgeInsets.symmetric(vertical: Dimen.horizontal_padding),
                  child: SkyText(
                    "AVALIAR",
                    fontSize: 25,
                    textColor: AppColors.blue,
                  ),
                ),
                AppEvaluateCompany(_freightCompanyDetail),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
