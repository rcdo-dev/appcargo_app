import 'package:app_cargo/constants/app_colors.dart';
import 'package:app_cargo/constants/dimen.dart';
import 'package:app_cargo/di/container.dart';
import 'package:app_cargo/domain/freight_company_summary/freight_company_summary.dart';
import 'package:app_cargo/screens/companies/freightco_search_result.dart';
import 'package:app_cargo/screens/companies/widget/app_clickable_image.dart';
import 'package:app_cargo/services/me/me_service.dart';
import 'package:app_cargo/widgets/app_action_button.dart';
import 'package:app_cargo/widgets/app_loading_widget.dart';
import 'package:app_cargo/widgets/app_scaffold.dart';
import 'package:app_cargo/widgets/app_small_button.dart';
import 'package:app_cargo/widgets/app_text_button.dart';
import 'package:app_cargo/widgets/app_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_skywalker_core/flutter_skywalker_core.dart';

import '../../routes.dart';

class CompaniesMenu extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _CompaniesMenuState();
}

class _CompaniesMenuState extends State<CompaniesMenu> {
  MeService _meService = DIContainer().get<MeService>();
  Widget _frequentlyCompanies;

  void initState() {
    super.initState();
    _frequentlyCompanies = Container();
    _buildRecentlyWorkedCompanies();
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: "EMPRESA",
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(bottom: Dimen.horizontal_padding),
            child: AppActionButton(
              "VER EMPRESAS CADASTRADAS",
              fontSize: 20,
              borderColor: Colors.white,
              cupertinoHeightButton: 50,
              onPressed: () {
                Navigator.pushNamed(context, Routes.rankingCompanies);
              },
            ),
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              color: AppColors.white,
            ),
            padding: EdgeInsets.symmetric(
              vertical: Dimen.horizontal_padding,
              horizontal: Dimen.horizontal_padding,
            ),
            child: Column(
              children: <Widget>[
                Container(
                  width: 250,
                  padding: EdgeInsets.symmetric(
                    vertical: Dimen.vertical_padding,
                    horizontal: Dimen.horizontal_padding - 5,
                  ),
                  child: SkyText(
                    "Transportadoras com as quais já trabalhou",
                    fontSize: 20,
                    textColor: AppColors.blue,
                  ),
                ),
                Container(
                  padding:
                      EdgeInsets.symmetric(vertical: Dimen.horizontal_padding),
                  child: Container(
                    padding: EdgeInsets.symmetric(
                        vertical: Dimen.horizontal_padding),
                    width: 666,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(
                          color: AppColors.yellow,
                        )),
                    child: _frequentlyCompanies,
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(
                    vertical: Dimen.vertical_padding,
                  ),
                  child: SkyText(
                    "Buscar transportadora",
                    textColor: AppColors.blue,
                    fontSize: 17,
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(
                    vertical: Dimen.vertical_padding,
                  ),
                  child: AppTextField(
                    inputAction: TextInputAction.search,
                    onSubmitted: (val) {
                      Navigator.pushNamed(
                        context,
                        Routes.freightCoSearchResults,
                        arguments: FreightCoSearchArguments(val),
                      );
                    },
                    prefixIcon: Icon(
                      Icons.search,
                      color: AppColors.blue,
                      size: 25,
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _buildRecentlyWorkedCompanies() {
    setState(() {
      _frequentlyCompanies = AppLoadingWidget();
    });
    _meService
        .getRecentlyFrightCompanies()
        .then((List<FreightCompanySummary> frequentlyCompanies) {
      List<Widget> _companiesWidget1 = new List<Widget>();
      List<Widget> _companiesWidget2 = new List<Widget>();
      int cont = 0;
      for (FreightCompanySummary _company in frequentlyCompanies) {
        if (cont < 3) {
          _companiesWidget1.add(
            Expanded(
              flex: 1,
              child: Container(
                child: AppClickableImage(
                  imageLink: _company.photo,
                  onTap: () {
                    Navigator.pushNamed(context, Routes.carrierInfo,
                        arguments: {"freightCompanyHash": _company.hash});
                  },
                ),
              ),
            ),
          );
        } else {
          _companiesWidget2.add(
            Expanded(
              flex: 1,
              child: Container(
                child: AppClickableImage(
                  imageLink: _company.photo,
                  onTap: () {
                    Navigator.pushNamed(context, Routes.carrierInfo,
                        arguments: {"freightCompanyHash": _company.hash});
                  },
                ),
              ),
            ),
          );
        }
        cont++;
      }
      setState(() {
        _frequentlyCompanies = Column(
          children: <Widget>[
            Row(
              children: _companiesWidget1,
            ),
            Row(
              children: _companiesWidget2,
            ),
          ],
        );
        if (frequentlyCompanies.length == 0) {
          _frequentlyCompanies = Container(
            child: SkyText(
              "Aceite fretes para ver as transportadoras com as quais já trabalhou",
              fontSize: 20,
              textColor: AppColors.green,
            ),
            padding: EdgeInsets.symmetric(vertical: Dimen.horizontal_padding),
          );
        }
      });
    });
  }
}
