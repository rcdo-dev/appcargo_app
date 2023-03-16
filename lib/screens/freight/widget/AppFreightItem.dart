import 'package:app_cargo/constants/app_colors.dart';
import 'package:app_cargo/constants/dimen.dart';
import 'package:app_cargo/di/container.dart';
import 'package:app_cargo/domain/chat/chat_member.dart';
import 'package:app_cargo/domain/freight_details/freight_details.dart';
import 'package:app_cargo/domain/freight_summary/freight_summary.dart';
import 'package:app_cargo/domain/util/map_utils.dart';
import 'package:app_cargo/domain/util/number_formatters.dart';
import 'package:app_cargo/services/freight/freight_mock_service.dart';
import 'package:app_cargo/services/freight/freight_service.dart';
import 'package:app_cargo/widgets/app_action_button.dart';
import 'package:app_cargo/widgets/app_loading_dialog.dart';
import 'package:app_cargo/widgets/app_save_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_skywalker_core/flutter_skywalker_core.dart';

import '../../../routes.dart';
import '../freight_info.dart';
import '../freight_proposal.dart';

class AppFreightItem extends StatelessWidget {
  final FreightDetails freightDetails;
  final FreightSummary freightSummary;
  final bool proposal;

  const AppFreightItem(
    this.freightDetails, {
    Key key,
    this.proposal = false,
    this.freightSummary,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String mainRoute;
    if (proposal) {
      mainRoute = Routes.freightProposal;
    } else {
      mainRoute = Routes.freightInfo;
    }

    if (freightDetails != null) {
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
                      padding: EdgeInsets.all(Dimen.horizontal_padding),
                      child: SkyText(
                        freightDetails.code,
                        textColor: AppColors.blue,
                        fontWeight: FontWeight.bold,
                        fontSize: 19,
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
                      child: FadeInImage.assetNetwork(
                        placeholder: "assets/images/loadingImage.gif",
                        image: freightDetails.freightCompany.photo,
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
                          horizontal: Dimen.horizontal_padding),
                      child: SkyText(
                        "Origem",
                        textColor: AppColors.blue,
                        fontSize: 14,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                          vertical: Dimen.vertical_padding - 2,
                          horizontal: Dimen.horizontal_padding),
                      child: SkyText(
                        "Destino",
                        textColor: AppColors.blue,
                        fontSize: 14,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                          vertical: Dimen.vertical_padding - 2,
                          horizontal: Dimen.horizontal_padding),
                      child: SkyText(
                        "Distância",
                        textColor: AppColors.blue,
                        fontSize: 14,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                          vertical: Dimen.vertical_padding - 2,
                          horizontal: Dimen.horizontal_padding),
                      child: SkyText(
                        "Situação",
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
                          vertical: Dimen.vertical_padding - 2),
                      child: SkyText(
                        freightDetails.from.cityName +
                            "/" +
                            freightDetails.from.stateAcronym,
                        textColor: AppColors.green,
                        fontSize: 14,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                        vertical: Dimen.vertical_padding - 2,
                      ),
                      child: SkyText(
                        freightDetails.to.cityName +
                            "/" +
                            freightDetails.to.stateAcronym,
                        textColor: AppColors.green,
                        fontSize: 14,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                        vertical: Dimen.vertical_padding - 2,
                      ),
                      child: SkyText(
                        Formatter.meterToKilometer(
                            int.parse(freightDetails.distanceInMeters)),
                        textColor: AppColors.green,
                        fontSize: 14,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                        vertical: Dimen.vertical_padding - 2,
                      ),
                      child: SkyText(
                        freightDetails.status.name(),
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
                          MapUtils.openMap(
                              double.parse(freightDetails
                                  .freightCompany.address.position.latitude),
                              double.parse(freightDetails
                                  .freightCompany.address.position.latitude));
                        },
                      ),
                    ),
                    Container(
                      height: 50,
                      padding: EdgeInsets.only(right: 2),
                      child: SkyButton(
                        textColor: AppColors.blue,
                        text: "FALAR COM A EMPRESA",
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
                              "otherChatMember": ChatMember.from(freightDetails.freightCompany),
                            },
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              child: AppSaveButton(
                "MAIS INFORMAÇÕES",
                onPressed: () {
                  Navigator.pushNamed(context, mainRoute,
                      arguments: {'freightDetails': freightDetails});
                },
              ),
            ),
          ],
        ),
      );
    } else {
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
                      padding: EdgeInsets.symmetric(
                          vertical: Dimen.vertical_padding),
                      child: SkyText(
                        freightSummary.code,
                        textColor: AppColors.blue,
                        fontWeight: FontWeight.bold,
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
                        borderRadius: BorderRadius.all(Radius.circular(
                                5.0) //         <--- border radius here
                            ),
                      ),
                      child: FadeInImage.assetNetwork(
                        placeholder: "assets/images/loadingImage.gif",
                        image: freightSummary.photoUrl,
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
                          horizontal: Dimen.horizontal_padding),
                      child: SkyText(
                        "Origem",
                        textColor: AppColors.blue,
                        fontSize: 14,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                          vertical: Dimen.vertical_padding - 2,
                          horizontal: Dimen.horizontal_padding),
                      child: SkyText(
                        "Destino",
                        textColor: AppColors.blue,
                        fontSize: 14,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                          vertical: Dimen.vertical_padding - 2,
                          horizontal: Dimen.horizontal_padding),
                      child: SkyText(
                        "Distância",
                        textColor: AppColors.blue,
                        fontSize: 14,
                      ),
                    )
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.symmetric(
                          vertical: Dimen.vertical_padding - 2),
                      child: SkyText(
                        freightSummary.from.cityName +
                            "/" +
                            freightSummary.from.stateAcronym,
                        textColor: AppColors.green,
                        fontSize: 14,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                        vertical: Dimen.vertical_padding - 2,
                      ),
                      child: SkyText(
                        freightSummary.to.cityName +
                            "/" +
                            freightSummary.to.stateAcronym,
                        textColor: AppColors.green,
                        fontSize: 14,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                        vertical: Dimen.vertical_padding - 2,
                      ),
                      child: SkyText(
                        Formatter.meterToKilometer(
                            int.parse(freightSummary.distanceInMeters)),
                        textColor: AppColors.green,
                        fontSize: 14,
                      ),
                    )
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
                        text: "FALAR COM A EMPRESA",
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
                              "otherChatMember": ChatMember.from(freightDetails.freightCompany),
                            },
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              child: AppSaveButton(
                "MAIS INFORMAÇÕES",
                onPressed: () {
                  final FreightService _freightService =
                      DIContainer().get<FreightService>();
                  showLoadingThenOkDialog(
                          context,
                          _freightService
                              .getFreightDetails(freightSummary.hash))
                      .then((FreightDetails value) {
                    Navigator.pushNamed(context, mainRoute,
                        arguments: {'freightDetails': value});
                  });
                },
              ),
            ),
          ],
        ),
      );
    }
  }
}
