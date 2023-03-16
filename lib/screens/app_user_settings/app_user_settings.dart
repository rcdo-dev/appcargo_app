import 'package:app_cargo/constants/analytics_events_constants.dart';
import 'package:app_cargo/constants/app_colors.dart';
import 'package:app_cargo/constants/dimen.dart';
import 'package:app_cargo/constants/endpoints.dart';
import 'package:app_cargo/constants/whatsapp_constants.dart';
import 'package:app_cargo/di/container.dart';
import 'package:app_cargo/domain/profile_summary/profile_summary.dart';
import 'package:app_cargo/routes.dart';
import 'package:app_cargo/services/config/config_service.dart';
import 'package:app_cargo/widgets/app_text.dart';
import 'package:facebook_app_events/facebook_app_events.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:url_launcher/url_launcher.dart';

class AppUserSettings extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _AppUserSettingsState();
}

class _AppUserSettingsState extends State<AppUserSettings> {
  Map<String, dynamic> args;
  ProfileSummary profileSummary;
  FacebookAppEvents _facebookAppEvents = DIContainer().get<FacebookAppEvents>();
  FirebaseAnalytics _firebaseAnalytics = DIContainer().get<FirebaseAnalytics>();

  @override
  Widget build(BuildContext context) {
    args = ModalRoute.of(context).settings.arguments;
    if (null != args && args.isNotEmpty) {
      profileSummary = args["user_data"] as ProfileSummary;
    }

    return Scaffold(
      body: SingleChildScrollView(
        physics: NeverScrollableScrollPhysics(),
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                margin: EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        width: 50,
                        alignment: Alignment.center,
                        padding: EdgeInsets.only(
                            top: Dimen.horizontal_padding,
                            bottom: Dimen.horizontal_padding),
                        margin: EdgeInsets.only(top: 30, left: 15),
                        child: Image(
                          image: AssetImage("assets/images/logo.png"),
                        ),
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.only(
                          top: Dimen.horizontal_padding,
                          bottom: Dimen.horizontal_padding),
                      margin: EdgeInsets.only(top: 30),
                      child: AppText("MENU",
                          textColor: AppColors.grey, weight: FontWeight.bold),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          Routes.luckyNumber,
                          arguments: {
                            "isFromHome": true,
                          },
                        );
                      },
                      child: Container(
                        alignment: Alignment.center,
                        padding: EdgeInsets.only(
                            top: Dimen.horizontal_padding,
                            bottom: Dimen.horizontal_padding),
                        margin: EdgeInsets.only(top: 30, right: 15),
                        child: Column(
                          children: <Widget>[
                            Container(
                              child: Image.asset(
                                "assets/images/ic_clover.png",
                                width: 25,
                                fit: BoxFit.contain,
                                color: AppColors.green,
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              "N° da sorte",
                              style: TextStyle(
                                  fontSize: 10,
                                  color: AppColors.black,
                                  fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Divider(),
              SizedBox(
                height: 20,
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, Routes.settingsYourData);
                      },
                      child: Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Container(
                                  margin: EdgeInsets.only(right: 10),
                                  child: CircleAvatar(
                                    radius: 35,
                                    backgroundColor: AppColors.light_grey02,
                                    backgroundImage: NetworkImage(profileSummary
                                                .personal.personalPhotoUrl ==
                                            null
                                        ? "https://www.pngfind.com/pngs/m/292-2924858_user-icon-business-man-flat-png-transparent-png.png"
                                        : Endpoints.baseUrl +
                                            profileSummary
                                                .personal.personalPhotoUrl),
                                  ),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text("${profileSummary.personal.alias}"),
                                    Text(
                                        "Placa - ${profileSummary.vehicle.plate}"),
                                  ],
                                ),
                              ],
                            ),
                            Container(
                              margin: EdgeInsets.symmetric(horizontal: 10),
                              child: Icon(
                                Icons.keyboard_arrow_right,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Divider(),
                    SizedBox(
                      height: 20,
                    ),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.start,
                    //   children: <Widget>[
                    //     Container(
                    //       margin: EdgeInsets.only(right: 10),
                    //       width: 25,
                    //       child: Image.asset(
                    //         "assets/images/logo.png",
                    //         fit: BoxFit.cover,
                    //       ),
                    //     ),
                    //     AppText(
                    //       "Como utilizar o AppCargo",
                    //       textColor: AppColors.black,
                    //     )
                    //   ],
                    // ),
                    SizedBox(
                      height: 20,
                    ),
                    GestureDetector(
                      onTap: () {
                        _facebookAppEvents.logEvent(
                            name: AnalyticsEventsConstants.settings,
                            parameters: {
                              AnalyticsEventsConstants.action:
                                  AnalyticsEventsConstants.viewEntrance
                            });
                        _firebaseAnalytics.logEvent(
                            name: AnalyticsEventsConstants.settings,
                            parameters: {
                              AnalyticsEventsConstants.action:
                                  AnalyticsEventsConstants.viewEntrance
                            });

                        Navigator.pushNamed(context, Routes.settingsMenu);
                      },
                      child: Row(
                        children: <Widget>[
                          Container(
                              margin: EdgeInsets.only(right: 10),
                              height: 25,
                              child: Icon(Icons.settings)),
                          AppText(
                            "Configurações",
                            textColor: AppColors.black,
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    GestureDetector(
                      onTap: () async {
                        String phone = WhatsappConstants.numberWithCountryDDD;
                        var whatsappUrl =
                            "whatsapp://send?phone=$phone&text=${WhatsappConstants.contactMessage}";
                        if (await canLaunch(whatsappUrl)) {
                          await launch(whatsappUrl);
                        }
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(right: 10),
                            width: 25,
                            child: Image.asset(
                              "assets/images/ic_whatsapp.png",
                              fit: BoxFit.cover,
                            ),
                          ),
                          AppText(
                            "Fale conosco!",
                            textColor: AppColors.black,
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        GestureDetector(
                          onTap: () async {
                            if (await canLaunch(Endpoints.appWebsite)) {
                              await launch(Endpoints.appWebsite);
                            }
                          },
                          child: Row(
                            children: <Widget>[
                              Container(
                                  margin: EdgeInsets.only(right: 10),
                                  width: 25,
                                  child: Icon(Icons.language)),
                              AppText(
                                "Site",
                                textColor: AppColors.black,
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 15),
                          child: AppText(
                            "|",
                            textColor: AppColors.black,
                          ),
                        ),
                        GestureDetector(
                          onTap: () async {
                            if (await canLaunch(Endpoints.appYoutube)) {
                              await launch(Endpoints.appYoutube);
                            }
                          },
                          child: Image.asset(
                            "assets/images/ic_youtube.png",
                            height: 30,
                            color: AppColors.grey,
                          ),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        GestureDetector(
                          onTap: () async {
                            if (await canLaunch(Endpoints.appFacebook)) {
                              await launch(Endpoints.appFacebook);
                            }
                          },
                          child: Image.asset(
                            "assets/images/ic_facebook.png",
                            height: 25,
                            color: AppColors.grey,
                          ),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        GestureDetector(
                          onTap: () async {
                            if (await canLaunch(Endpoints.appInstagram)) {
                              await launch(Endpoints.appInstagram);
                            }
                          },
                          child: Image.asset(
                            "assets/images/ic_instagram.png",
                            height: 25,
                            color: AppColors.grey,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    Container(
                      height: 60,
                      width: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.only(top: 5, bottom: 5),
                      child: RaisedButton(
                        onPressed: () {
                          DIContainer()
                              .get<ConfigurationService>()
                              .deleteAccessToken();
                          Navigator.pushNamedAndRemoveUntil(
                              context, Routes.index, (object) => false);
                        },
                        shape: RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(5),
                        ),
                        child: AppText(
                          "Sair",
                          textColor: AppColors.red,
                          fontSize: 18,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          height: 80,
                          child: Image.asset(
                            "assets/images/logo.png",
                            color: AppColors.light_grey,
                          ),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              alignment: Alignment.centerRight,
                              child: Text(
                                "AppCargo LTDH\nCNPJ: 34.690.871/0001-04\nMogi das Cruzes/SP\nCEP: 08780-200",
                                textAlign: TextAlign.right,
                                style: TextStyle(
                                    color: AppColors.light_grey,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
