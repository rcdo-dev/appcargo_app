import 'package:app_cargo/constants/app_colors.dart';
import 'package:app_cargo/constants/dimen.dart';
import 'package:app_cargo/di/container.dart';
import 'package:app_cargo/domain/chat/chat_member.dart';
import 'package:app_cargo/domain/freight_company_detail/freight_company_detail.dart';
import 'package:app_cargo/domain/freight_company_summary/freight_company_summary.dart';
import 'package:app_cargo/services/freight_company/freight_company_service.dart';
import 'package:app_cargo/widgets/app_loading_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_skywalker_core/flutter_skywalker_core.dart';

import '../routes.dart';

class AppFreightCoItem extends StatefulWidget {
  final FreightCompanySummary freightCoSummary;

  const AppFreightCoItem({Key key, this.freightCoSummary}) : super(key: key);

  @override
  State<StatefulWidget> createState() =>
      _AppFreightCoItemState(freightCoSummary);
}

class _AppFreightCoItemState extends State<AppFreightCoItem> {
  final FreightCompanyService _freightCompanyService =
      DIContainer().get<FreightCompanyService>();
  final FreightCompanySummary freightCoSummary;

  _AppFreightCoItemState(this.freightCoSummary);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.symmetric(vertical: Dimen.horizontal_padding),
            width: 666,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: Container(
                    alignment: Alignment.center,
                    padding:
                        EdgeInsets.symmetric(vertical: Dimen.vertical_padding),
                    child: SkyFlatButton(
                      text: freightCoSummary.name,
                      textColor: AppColors.blue,
                      onPressed: (){
                        Navigator.pushNamed(context, Routes.carrierInfo, arguments: {"freightCompanyHash":freightCoSummary.hash});
                      },
                      fontSize: 20,
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    alignment: Alignment.center,
                    height: 70,
                    width: 70,
                    decoration: BoxDecoration(
                      border: Border.all(width: 1.0, color: AppColors.blue),
                      borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    ),
                    child: Image.network(
                      freightCoSummary.photo,
                      fit: BoxFit.cover,
                      alignment: Alignment.center,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Row(
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.symmetric(
                      vertical: Dimen.vertical_padding - 2,
                      horizontal: Dimen.horizontal_padding,
                    ),
                    child: SkyText(
                      "Endereço",
                      textColor: AppColors.blue,
                      fontSize: 14,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(
                      vertical: Dimen.vertical_padding - 2,
                      horizontal: Dimen.horizontal_padding,
                    ),
                    child: SkyText(
                      "Contato",
                      textColor: AppColors.blue,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.symmetric(
                      vertical: Dimen.vertical_padding - 2,
                    ),
                    child: SkyText(
                      freightCoSummary.address.cityName +
                          "-" +
                          freightCoSummary.address.stateAcronym,
                      textColor: AppColors.green,
                      fontSize: 14,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(
                      vertical: Dimen.vertical_padding - 2,
                    ),
                    child: SkyText(
                      freightCoSummary.contact ?? "",
                      textColor: AppColors.green,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: Dimen.horizontal_padding),
            child: FittedBox(
              fit: BoxFit.cover,
              child: Row(
                children: <Widget>[
                  Container(
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
                        // TODO: This method should open the google maps with the company coordinates
                      },
                    ),
                  ),
                  Container(
                    height: 50,
                    padding: EdgeInsets.only(right: 2),
                    child: SkyButton(
                      textColor: AppColors.blue,
                      text: "FALAR COM A TRANSPORTADORA",
                      inlineIcon: Icon(
                        Icons.phone,
                        color: AppColors.blue,
                      ),
                      buttonColor: AppColors.white,
                      borderRadius: 10,
                      borderColor: AppColors.blue,
                      onPressed: () {
                          Navigator.pushNamed(
                              context, Routes.driverAndFreightChat,
                              arguments: {
                                "otherChatMember": ChatMember.from(freightCoSummary),
                              },
                          );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
//          Container(
//            child: AppSaveButton(
//              "MAIS INFORMAÇÕES",
//              onPressed: () {
////                Navigator.pushNamed(context, mainRoute,
////                    arguments: {'freightDetails': freightDetails});
//              },
//            ),
//          ),
        ],
      ),
    );
  }
}
