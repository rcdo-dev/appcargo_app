import 'package:app_cargo/constants/dimen.dart';
import 'package:app_cargo/domain/freight_company_detail/freight_company_detail.dart';
import 'package:app_cargo/domain/freight_company_feedback/freight_company_feedback.dart';
import 'package:app_cargo/domain/util/map_utils.dart';
import 'package:app_cargo/domain/util/number_formatters.dart';
import 'package:flutter/material.dart';
import 'package:flutter_skywalker_core/src/widgets/sky_text.dart';
import 'package:flutter_skywalker_core/src/widgets/sky_button.dart';
import 'package:app_cargo/constants/app_colors.dart';

import '../../../routes.dart';

class AppCarrierInfo extends StatelessWidget {
  final FreightCompanyDetail _freightCompanyDetail;

  const AppCarrierInfo(this._freightCompanyDetail, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            padding: EdgeInsets.symmetric(vertical: Dimen.vertical_padding),
            alignment: Alignment.center,
            height: 90,
            width: 90,
            decoration: BoxDecoration(
              border: Border.all(width: 1.0, color: AppColors.blue),
              borderRadius: BorderRadius.all(
                  Radius.circular(5.0) //         <--- border radius here
                  ),
            ),
            child: Image.network(
              _freightCompanyDetail.photo,
              fit: BoxFit.cover,
              alignment: Alignment.center,
            ),
          ),
          Container(
            padding:
                EdgeInsets.symmetric(vertical: Dimen.horizontal_padding + 15),
            child: Column(
              children: <Widget>[
                Container(
                  alignment: Alignment.center,
                  child: SkyText(
                    _freightCompanyDetail.name,
                    textColor: AppColors.blue,
                    fontSize: 20,
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(
                      vertical: Dimen.vertical_padding + 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: starsRating(_freightCompanyDetail.rating, 25),
                  ),
                ),
                Container(
                  alignment: Alignment.topLeft,
                  child: SkyText(
                    "Localizaçao",
                    textColor: AppColors.blue,
                    fontSize: 20,
                  ),
                ),
                Container(
                  alignment: Alignment.topLeft,
                  child: SkyText(
                    _freightCompanyDetail.address.formatted,
                    textColor: AppColors.green,
                    fontSize: 20,
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(top: 10),
                  alignment: Alignment.topLeft,
                  child: SkyText(
                    "Telefone",
                    textColor: AppColors.blue,
                    fontSize: 20,
                  ),
                ),
                Container(
                  alignment: Alignment.topLeft,
                  child: SkyText(
                    _freightCompanyDetail.contact!= null
                      ? Formatter.phone(
                      _freightCompanyDetail.contact)
                      : "Não informado.",
                    textColor: AppColors.green,
                    fontSize: 20,
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(top: 10),
                  alignment: Alignment.topLeft,
                  child: SkyText(
                    "Colocaçao na avaliação geral",
                    textColor: AppColors.blue,
                    fontSize: 20,
                  ),
                ),
                Container(
                  alignment: Alignment.topLeft,
                  child: SkyText(
                    _freightCompanyDetail.rankingPosition.toString(),
                    textColor: AppColors.green,
                    fontSize: 20,
                  ),
                )
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.only(bottom: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                /*Expanded(
                  child: Container(
                    height: 50,
                    padding: EdgeInsets.only(right: 5),
                    child: SkyButton(
                      textColor: AppColors.blue,
                      text: "VER NO MAPA",
                      inlineIcon: Icon(
                        Icons.location_on,
                        color: AppColors.blue,
                      ),
                      buttonColor: AppColors.white,
                      borderRadius: 10,
                      borderColor: AppColors.blue,
                      onPressed: () {
                        MapUtils.openMap(
                            num.parse(_freightCompanyDetail
                                .address.position.latitude),
                            num.parse(_freightCompanyDetail
                                .address.position.longitude));
                      },
                    ),
                  ),
                ),*/
                Expanded(
                  child: Container(
                    height: 50,
                    child: SkyButton(
                      textColor: AppColors.blue,
                      text: "AVALIAR",
                      inlineIcon: Icon(
                        Icons.star,
                        color: AppColors.blue,
                      ),
                      buttonColor: AppColors.white,
                      borderRadius: 10,
                      fontSize: 19,
                      borderColor: AppColors.blue,
                      onPressed: () {
                        Navigator.pushNamed(
                          context,
                          Routes.evaluateCompany,
                          arguments: {
                            "freightCompanyDetail": _freightCompanyDetail
                          },
                        );
                      },
                    ),
                  ),
                )
              ],
            ),
          ),
//          Container(
//            padding: EdgeInsets.symmetric(vertical: Dimen.horizontal_padding),
//            height: 50,
//            child: SkyButton(
//              textColor: AppColors.blue,
//              text: "FAZER RECLAMÃO",
//              inlineIcon: Icon(
//                Icons.error_outline,
//                color: AppColors.blue,
//              ),
//              buttonColor: AppColors.white,
//              borderRadius: 10,
//              borderColor: AppColors.blue,
//              onPressed: () {
//                Navigator.pushNamed(
//                  context,
//                  Routes.makeComplaint,
//                  arguments: {
//                    "freightCompanyDetail": _freightCompanyDetail
//                  },
//                );
//              },
//            ),
//          ),
          Container(
            width: 300,
            height: 1,
            color: AppColors.yellow,
          ),
          Container(
            padding:
                EdgeInsets.symmetric(vertical: Dimen.horizontal_padding + 5),
            child: SkyText(
              "Principais Avaliações",
              textColor: AppColors.blue,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: Dimen.vertical_padding),
            child: Column(
              children: ratings(),
            ),
          )
        ],
      ),
    );
  }

  List<Widget> starsRating(int rating, double size) {
    List<Widget> list = new List(5);
    for (int i = 0; i < rating; i++) {
      list[i] = new Container(
          child: Icon(
        Icons.star,
        color: AppColors.green,
        size: size,
      ));
    }

    for (int f = rating; f < 5; f++) {
      list[f] = new Container(
          child: Icon(
        Icons.star_border,
        color: AppColors.green,
        size: size,
      ));
    }

    return list;
  }

  List<Widget> ratings() {
    List<Widget> list = new List();
    for (FreightCompanyFeedback feedback
        in _freightCompanyDetail.highlightedFeedback) {
      if(feedback.driver == null)
        continue;
      list.add(
        new Container(
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.symmetric(
                        vertical: Dimen.vertical_padding,
                        horizontal: Dimen.horizontal_padding),
                    child: SkyText(
                      feedback.driver,
                      textColor: AppColors.green,
                      fontSize: 20,
                    ),
                  ),
                  Container(
                    child: Row(
                      children: starsRating(feedback.rating, 15),
                    ),
                  ),
                ],
              ),
              Container(
                padding: EdgeInsets.symmetric(
                    vertical: Dimen.vertical_padding,
                    horizontal: Dimen.horizontal_padding),
                alignment: Alignment.topLeft,
                child: SkyText(
                  feedback.description,
                  textColor: AppColors.blue,
                  textAlign: TextAlign.start,
                  fontSize: 17,
                ),
              )
            ],
          ),
        ),
      );
    }

    return list;
  }
}
