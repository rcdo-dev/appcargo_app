import 'package:app_cargo/domain/chat/chat_member.dart';
import 'package:app_cargo/domain/freight_details/freight_details.dart';
import 'package:app_cargo/screens/chat/chat_screen.dart';
import 'package:app_cargo/widgets/app_save_button.dart';
import 'package:app_cargo/widgets/app_scaffold.dart';
import 'package:flutter_skywalker_core/flutter_skywalker_core.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/material.dart';
import 'package:app_cargo/constants/dimen.dart';
import 'package:app_cargo/constants/app_colors.dart';

import '../../routes.dart';

class FreightAccepted extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> args;
    FreightDetails freightDetails;

    args = ModalRoute.of(context).settings.arguments;
    if (null != args && args.isNotEmpty) {
      freightDetails = args["freightDetails"] as FreightDetails;
    }

    return AppScaffold(
      title: "FRETES",
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
                    padding: EdgeInsets.symmetric(
                      vertical: Dimen.vertical_padding + 10,
                    ),
                    child: SkyText(
                      "PARABÉNS!",
                      textColor: AppColors.green,
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(
                      vertical: Dimen.vertical_padding + 10,
                    ),
                    child: SkyText(
                      "Seu novo frete foi adicionado a sua lista de fretes!",
                      textColor: AppColors.blue,
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(bottom: 20),
                    child: Column(
                      children: <Widget>[
                        AppSaveButton(
                          "VER AS INFORMAÇÕES DO FRETE",
                          onPressed: () {
                            Navigator.pushNamed(context, Routes.freightInfo);
                          },
                        ),
                        AppSaveButton(
                          "FALAR COM A EMPRESA",
                          onPressed: () {
                            Navigator.pushNamed(
                              context, Routes.driverAndFreightChat,
                              arguments: {
                                "otherChatMember": ChatMember.from(freightDetails.freightCompany),
                              },
                            );
                          },
                        ),
                        AppSaveButton(
                          "IR PARA O MENU PRINCIPAL",
                          onPressed: () {
                            Navigator.of(context).popUntil(
                                (Route<dynamic> route) => route.isFirst);
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  _launchURL(phone) async {
    String url = 'whatsapp://send?phone=' + phone;
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
