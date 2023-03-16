import 'package:app_cargo/constants/app_colors.dart';
import 'package:app_cargo/constants/whatsapp_constants.dart';
import 'package:app_cargo/di/container.dart';
import 'package:app_cargo/domain/custom_notification/custom_notificaion.dart';
import 'package:app_cargo/domain/profile_summary/profile_summary.dart';
import 'package:app_cargo/http/app_cargo_client.dart';
import 'package:app_cargo/screens/social_medias/social_medias.dart';
import 'package:app_cargo/services/notification/app_notification_service.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../routes.dart';

class FirebaseMessagingService {
  final AppNotificationService _notificationService;
  FirebaseMessaging _firebaseMessaging;
  final String sosTata = 'https://sostata.brotherstechnohouse.com.br';
  final String custoCalc = 'https://play.google.com/store/apps/details?id=br.com.custocalc.io';
  final String appcargostore = 'https://appcargostore.com.br/';

  AppCargoClient _appCargoClient = DIContainer().get<AppCargoClient>();

  FirebaseMessagingService(this._notificationService) {
    _firebaseMessaging = FirebaseMessaging();
  }

  Future<void> initilize(
    BuildContext context,
    GlobalKey<ScaffoldState> key,
    ProfileSummary summary,
  ) async {
    _firebaseMessaging.getToken().then((token) {
      sendFcmTokenDevice(token);
      _subscribeToTopic();
      debugPrint('=================================');
      debugPrint('- FCM TOKEN DEVICE SENDED TO STORAGE:\n$token');
      debugPrint('- SUBSCRIBE TO TOPIC: all');
      debugPrint('=================================');
    });
    _onMessage(context, key, summary);
  }

  _launchURLApp(String url) async {
    if (await canLaunch(url)) {
      await launch(url, forceSafariVC: true);
    } else {
      throw 'Could not launch $url';
    }
  }

  void _appSnackbar({@required String text, @required GlobalKey<ScaffoldState> key}) {
    var snackbar = SnackBar(
      backgroundColor: AppColors.red,
      content: Text(
        text,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 16.0,
        ),
      ),
    );
    key.currentState.showSnackBar(snackbar);
  }

  void _redirectToTata({@required GlobalKey<ScaffoldState> key}) async {
    String phone = WhatsappConstants.numberWithCountryDDD;
    var whatsappUrl = "whatsapp://send?phone=$phone&text=${WhatsappConstants.menuTataTextMessage}";
    if (await canLaunch(whatsappUrl)) {
      await launch(whatsappUrl);
    } else {
      _appSnackbar(text: 'Instale o WHATSAPP para falar com a Tatá!', key: key);
    }
  }

  void _redirectToScreen({
    GlobalKey<ScaffoldState> key,
    @required BuildContext context,
    @required String link,
    @required ProfileSummary summary,
  }) {
    print(link);
    switch (link) {
      case 'https://appcargodlink.page.link/numeroSorte':
        Navigator.pushNamed(context, Routes.luckyNumber, arguments: {"isFromHome": true});
        break;
      case 'https://appcargodlink.page.link/menu':
        Navigator.pushNamed(context, Routes.appUserSettings, arguments: {'user_data': summary});
        break;
      case 'https://appcargodlink.page.link/fretes':
        Navigator.pushNamed(context, Routes.freightChat);
        break;
      case 'https://appcargodlink.page.link/descontos':
        Navigator.pushNamed(context, Routes.clubMenu);
        break;
      case 'https://appcargodlink.page.link/tata':
        _redirectToTata(key: key);
        break;
      case 'https://appcargodlink.page.link/omni':
        Navigator.pushNamed(context, Routes.omniMenuOptions);
        break;
      case 'https://appcargodlink.page.link/passatempo':
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => SocialMedias()));
        break;
      case 'https://appcargodlink.page.link/sosTata':
        _launchURLApp(sosTata);
        break;
      case 'https://appcargodlink.page.link/custoCalc':
        _launchURLApp(custoCalc);
        break;
      case 'https://appcargodlink.page.link/appCargoStore':
        _launchURLApp(appcargostore);
        break;
      case 'https://appcargodlink.page.link/pecaSeuFrete':
        Navigator.pushNamed(context, Routes.requestFreight, arguments: false);
        break;
      default:
        Navigator.pushNamed(context, Routes.index);
    }
  }

  _onMessage(
    BuildContext context,
    GlobalKey<ScaffoldState> key,
    ProfileSummary profileSummary,
  ) {
    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print("onMessage: $message");
        await _notificationService.showNotification(
          CustomNotification(
            id: 1,
            title: '${message['notification']['title']}',
            body: '${message['notification']['body']}',
          ),
        );
      },
      onLaunch: (Map<String, dynamic> message) async {
        print("onLaunch: $message");
        final data = message['data'];
        _redirectToScreen(
          context: context,
          link: data['dynamic_link'],
          key: key,
          summary: profileSummary,
        );
      },
      onResume: (Map<String, dynamic> message) async {
        print("onResume: $message");
        final data = message['data'];
        _redirectToScreen(
          context: context,
          link: data['dynamic_link'],
          key: key,
          summary: profileSummary,
        );
      },
    );
  }

  Future<void> _subscribeToTopic() async {
    await _firebaseMessaging.subscribeToTopic('all');
  }

  Future<dynamic> sendFcmTokenDevice(String token) async {
    return _appCargoClient.post(
      "/v1/setFirebaseToken",
      null,
      data: {
        "fcmToken": token,
      },
    ).catchError(
      (err) {
        throw err;
      },
    );
  }
}
