import 'dart:convert';
import 'dart:ui';

import 'package:app_cargo/constants/analytics_events_constants.dart';
import 'package:app_cargo/constants/endpoints.dart';
import 'package:app_cargo/constants/keys_app_custom_tool_tip.dart';
import 'package:app_cargo/constants/whatsapp_constants.dart';

import 'package:app_cargo/di/container.dart';
import 'package:app_cargo/domain/app_button/app_button.dart';
import 'package:app_cargo/domain/chat/chat_member.dart';
import 'package:app_cargo/domain/chat/chat_with_id.dart';
import 'package:app_cargo/domain/club_banner/club_partner.dart';
import 'package:app_cargo/domain/daily_quote/daily_quote.dart';
import 'package:app_cargo/domain/driver_contact_data/driver_contact_data.dart';
import 'package:app_cargo/domain/header_security/header_security.dart';
import 'package:app_cargo/domain/new_freight/driver_threads.dart';
import 'package:app_cargo/domain/profile_summary/profile_summary.dart';
import 'package:app_cargo/screens/financing/widgets/app_omni_refinancing_intro.dart';
import 'package:app_cargo/screens/message_quantity_state.dart';
import 'package:app_cargo/screens/social_medias/social_medias.dart';
import 'package:app_cargo/services/chat/chat_service.dart';
import 'package:app_cargo/services/club_banner/club_banner_service.dart';
import 'package:app_cargo/services/config/config_service.dart';
import 'package:app_cargo/services/daily_quote/daily_quote_service.dart';
import 'package:app_cargo/services/freight_chat/freight_chat_service.dart';
import 'package:app_cargo/services/location/location_service.dart';
import 'package:app_cargo/services/me/me_service.dart';
import 'package:app_cargo/services/notification/app_notification_service.dart';
import 'package:app_cargo/services/notification/firebase_messaging_service.dart';
import 'package:app_cargo/services/util/util_new_version_app.dart';
import 'package:app_cargo/widgets/app_bluetooth_on.dart';
import 'package:app_cargo/widgets/app_button_menu.dart';
import 'package:app_cargo/widgets/app_custom_tool_tip.dart';
import 'package:app_cargo/widgets/app_dialog_background_location_information.dart';
import 'package:app_cargo/widgets/app_dialog_premium_user_plan.dart';
import 'package:app_cargo/widgets/app_home_banner.dart';
import 'package:app_cargo/widgets/app_loading_widget.dart';
import 'package:app_cargo/widgets/show_message_dialog.dart';
import 'package:facebook_app_events/facebook_app_events.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:app_cargo/constants/dimen.dart';
import 'package:app_cargo/constants/app_colors.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_skywalker_core/flutter_skywalker_core.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:show_more_text_popup/show_more_text_popup.dart';

import 'dart:async';

import '../routes.dart';
import 'app_web_view/app_web_view.dart';

import 'package:firebase_performance/firebase_performance.dart';

class Menu extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MenuState();
}

class _MenuState extends State<Menu> with WidgetsBindingObserver {
  MeService _meService = DIContainer().get<MeService>();
  ConfigurationService _configurationService = DIContainer().get<ConfigurationService>();
  ChatService _chatMessageService = DIContainer().get<ChatService>();
  final LocationService locationService = DIContainer().get<LocationService>();

  DailyQuoteService _dailyQuoteService = DIContainer().get<DailyQuoteService>();

  ClubBannerService _clubBannerService = DIContainer().get<ClubBannerService>();

  FacebookAppEvents _facebookAppEvents = DIContainer().get<FacebookAppEvents>();
  FirebaseAnalytics _firebaseAnalytics = DIContainer().get<FirebaseAnalytics>();

  List<ClubPartner> _homeClubPartner = <ClubPartner>[];

  AppBluetoothOn appBluetoothOn = AppBluetoothOn();

  int _proposalsQuantity = 0;
  int _luckyNumber = 0;
  int _truckStateTest = 0;
  String _dailyQuote = "";

  int _currentPositionBanner = 0;

  String latitude;
  String longitude;

  Future _loaded;

  String _driverHash;

  ProfileSummary profileSummary;
  DriverContactData driverContactData;
  Map _tataContactEntity;

  bool premium;
  final key = GlobalKey<ScaffoldState>();
  final globalKeyRequestFreightButton = GlobalKey();
  final globalKeyLuckNumberButton = GlobalKey();
  final globalKeyTataButton = GlobalKey();
  final globalKeyEmergencyButton = GlobalKey();
  final globalKeyCostCalcButton = GlobalKey();
  final globalKeyStoreButton = GlobalKey();

  ScrollController scrollControllerMenuButton = ScrollController();
  double scrollMenuButtonPosition = 0.0;

  bool firstAccess = true;
  bool _flag = true;

  Map<String, AppCustomToolTip> _appCustomToolTip() {
    var list = <String, AppCustomToolTip>{
      KeysAppCustomToolTip.luckNumberButton: AppCustomToolTip(
        text: "Aqui você tem seu número da sorte! Com ele você concorre a prêmios todos os meses, lembre-se de deixar ativado.",
        backgroundColor: AppColors.white,
        widgetKey: globalKeyLuckNumberButton,
        height: 95,
        textColor: AppColors.dark_green,
      ),
      KeysAppCustomToolTip.tataButton: AppCustomToolTip(
        text: "Atendimento personalizado todos os dias? Conheça já o Tatá Premium! Com rapidez e exclusividade.",
        backgroundColor: AppColors.white,
        widgetKey: globalKeyTataButton,
        height: 80,
        textColor: AppColors.dark_green,
      ),
      KeysAppCustomToolTip.emergencyButton: AppCustomToolTip(
        text: 'Precisando de ajuda na estrada? Conheça o SOS Tatá.',
        backgroundColor: AppColors.white,
        widgetKey: globalKeyEmergencyButton,
        height: 60,
        textColor: AppColors.green,
      ),
      KeysAppCustomToolTip.costCalcButton: AppCustomToolTip(
        text: 'Precisando calcular se o frete compensa? Nós te ajudamos! Conheça já o Custo Calc.',
        backgroundColor: AppColors.white,
        widgetKey: globalKeyCostCalcButton,
        height: 80,
        textColor: AppColors.green,
      ),
      KeysAppCustomToolTip.storeButton: AppCustomToolTip(
        text: 'Precisando vender ou comprar o seu caminhão? Nós te ajudamos. Conheça já o AppCargo Store!',
        backgroundColor: AppColors.white,
        widgetKey: globalKeyStoreButton,
        height: 80,
        textColor: AppColors.green,
      ),
      KeysAppCustomToolTip.requestFreightButton: AppCustomToolTip(
        text: "Nesse botão você solicitará seu frete! Assim que encontrarmos, enviaremos uma notificação e ele chegará no botão escrito 'FRETES'.",
        backgroundColor: AppColors.white,
        widgetKey: globalKeyRequestFreightButton,
        height: 95,
        textColor: AppColors.dark_green,
      ),
    };
    return list;
  }

  void checkPremium({
    @required bool premium,
    String direct,
    String url,
    Object arguments,
    String messageTata,
  }) {
    if (premium) {
      if (url.isNotEmpty && url != null) {
        _launchURLApp(url);
      } else {
        Navigator.pushNamed(
          context,
          direct,
          arguments: arguments,
        );
      }
    } else {
      var dialog = AppDialogPremiumUserPlan(
        key: key,
        initialMessageText: messageTata,
      );
      dialog.showPremiumDialog(
        context,
      );
    }
  }

  _launchURLApp(String url) async {
    if (await canLaunch(url)) {
      await launch(url, forceSafariVC: true);
    } else {
      throw 'Could not launch $url';
    }
  }

  List<AppButton> _list = <AppButton>[];

  Future<List<AppButton>> fetchApps() async {
    var url = Uri.parse(
      "https://api.brotherstechnohouse.com.br/v1/json/8a314ed2-4b39-4460-845b-6a2c32ad33f7",
    );
    var response = await http.get(
      url,
    );

    var buttons = <AppButton>[];

    if (response.statusCode == 200) {
      var buttonsJson = jsonDecode(utf8.decode(response.bodyBytes));
      for (var buttonJson in buttonsJson) {
        buttons.add(AppButton.fromJson(buttonJson));
      }
    }
    return buttons;
  }

  HeaderSecurity _headerSecurity;

  initilizeFirebaseMessaging(ProfileSummary summary) async {
    await Provider.of<FirebaseMessagingService>(context, listen: false).initilize(context, key, summary);
  }

  checkNotifications() async {
    await Provider.of<AppNotificationService>(context, listen: false).checkForNotifications();
  }

  FreightChatService _freightChatService = DIContainer().get<FreightChatService>();
  List<DriverThreads> _threads = [];
  List<String> _hashThreads = [];
  bool _haveFreight = false;

  Future<void> _setListHashThreads() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _threads = await _freightChatService.getDriverThreads();
    _hashThreads = _threads.map((element) => element.hash).toList();
    prefs.setStringList('listHashThreads', _hashThreads);
  }

  void _haveFreightTest() {
    bool isRunning = false;
    Timer.periodic(Duration(seconds: 60), (Timer timer) async {
      if (!isRunning) {
        isRunning = true;
        try {
          List<DriverThreads> driverThreads = await _freightChatService.getDriverThreads();
          int lengthDriverThreads = driverThreads.length;

          SharedPreferences prefs = await SharedPreferences.getInstance();
          int lengthListFreightHash = prefs.getStringList('listHashThreads').length;

          if (lengthDriverThreads != lengthListFreightHash) {
            debugPrint('################################### THREADS: true');
            _haveFreight = true;
            showNotificationBalloon(
              text: 'Tem alguma coisa aqui para você!!!',
            );
          }
        } catch (e) {
          print("Error when getting new driver threads: " + e);
        }
        isRunning = false;
      }
    });
  }

  void showNotificationBalloon({String text}) {
    ShowMoreTextPopup popup = ShowMoreTextPopup(
      context,
      text: text,
      textStyle: TextStyle(
        color: AppColors.black,
      ),
      width: 250,
      height: 30,
      backgroundColor: AppColors.white,
      padding: EdgeInsets.all(4.0),
    );
    popup.show(
      widgetKey: globalKeyRequestFreightButton,
    );
    Future.delayed(Duration(seconds: 3)).then((_) => popup.dismiss());
  }

  void appSnackbar({@required String text}) {
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

  Future<bool> checkAccesToken() async {
    String _hasToken = await _configurationService.accessToken;
    if (_hasToken != null && _hasToken.isNotEmpty) {
      return false;
    }
    return true;
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    FirebasePerformance performance = FirebasePerformance.instance;
    performance.isPerformanceCollectionEnabled().then((value) => print('Monitoramento de performance ativado: $value'));

    scrollControllerMenuButton.addListener(() {
      scrollMenuButtonPosition = scrollControllerMenuButton.offset;
    });
    checkAccesToken().then((value) {
      firstAccess = value;
      if (firstAccess) {
        _loaded = _configurationService.cleanDbBeforeLogin().then((_) {
          _clubBannerService.getPartners().then((listPartner) {
            _homeClubPartner.addAll(listPartner);
          });
        });
      } else {
        _loaded = _configurationService.cleanDbBeforeLogin().then((value) {
          return _meService.getAllDriverData().then((profileSummary) {
            return _meService.getDriverSecurityHeader().then((securityHeader) {
              _headerSecurity = securityHeader;
              _configurationService.setHeaderSecurity(securityHeader).then((_) {
                return _meService.getContactUpdateData().then((driverContactUpdate) {
                  this.driverContactData = driverContactUpdate.contact;

                  this.profileSummary = profileSummary;
                  initilizeFirebaseMessaging(profileSummary);

                  SchedulerBinding.instance.addPostFrameCallback((_) {
                    MessageQuantityState messageQuantityState = Provider.of<MessageQuantityState>(context);
                    messageQuantityState.quantity = 0;
                    messageQuantityState.changeQuantity(0);
                    _configurationService.driverHash.then((hash) {
                      _driverHash = hash;

                      _tataContactEntity = {
                        "imageUrl": profileSummary.personal.personalPhotoUrl,
                        "name": profileSummary.personal.alias,
                        "phone": driverContactData == null || driverContactData.cellNumber == null ? "" : driverContactData.cellNumber,
                      };

                      _dailyQuoteService.getDailyQuote().then((DailyQuote dailyQuote) {
                        if (dailyQuote != null && dailyQuote.quote != null) {
                          _dailyQuote = dailyQuote.quote;
                        }
                      });

                      _clubBannerService.getPartners().then((listPartner) {
                        _homeClubPartner.addAll(listPartner);
                      });

                      isOpenAppFirstTime().then((isFirst) {
                        isFirst ? notifyUserAboutBackgroundLocation(context) : locationService.initBackgroundMonitoring();
                      });

                      appBluetoothOn.checkBluetoothOn().then(
                        (bluetoothIsOn) {
                          if (bluetoothIsOn == false) {
                            appBluetoothOn.notifyUserBluetoothOn(context);
                          }
                        },
                      );

                      _chatMessageService.getAllChatsByMemberHash(hash).then((chats) {
                        for (ChatWithId chatWithId in chats) {
                          _chatMessageService.getChatReceivedMessagesQuantity(chatWithId.documentId, hash).then((quantity) {
                            messageQuantityState.changeQuantity(messageQuantityState.quantity + quantity);
                          });
                        }
                      });
                    });
                  });
                });
              });
            });
          }).catchError((error) {
            print('%%%%%%%%%%%!!! $error');
            showMessageDialog(
              context,
              message: "Por favor, faça login a partir do menu principal.",
            ).then((object) {
              print('!!!!!!!!!%% $object');
              DIContainer().get<ConfigurationService>().deleteAccessToken();
              Navigator.pushNamedAndRemoveUntil(context, Routes.index, (object) => false);
            });
          });
        }).catchError((error) {
          return _meService.getAllDriverData().then((profileSummary) {}).catchError((error) {
            print(error);
            showMessageDialog(context, message: "Por favor, faça login a partir do menu principal.").then((object) {
              DIContainer().get<ConfigurationService>().deleteAccessToken();
              Navigator.pushNamedAndRemoveUntil(context, Routes.index, (object) => false);
            });
          });
        });
      }
    });

    _setListHashThreads();
    checkNotifications();

    /// Define no Shared Preferences se o motorista é ou não Premium.
    _meService.getAllDriverData().then(
          (value) => _configurationService.setIsPremium(value.personal.premium),
        );

    fetchApps().then((value) => {
          setState(() {
            _list.addAll(value);
          })
        });

    _facebookAppEvents.logEvent(name: AnalyticsEventsConstants.menu, parameters: {AnalyticsEventsConstants.action: AnalyticsEventsConstants.viewEntrance});

    _firebaseAnalytics.setCurrentScreen(screenName: Routes.menu);

    NewVersionApp(context: context);

    /// Retorna se o motorista é ou não Premium.
    _configurationService.isPremium.then(
      (value) => premium = value,
    );

    _haveFreightTest();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.paused:
        appBluetoothOn.checkBluetoothOn().then(
          (bluetoothIsOn) {
            if (bluetoothIsOn == false) {
              appBluetoothOn.notifyUserBluetoothOn(context);
            }
          },
        );
        print('===> App em pausa');
        break;
      default:
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _loaded,
      builder: (context, snapShot) {
        switch (snapShot.connectionState) {
          case ConnectionState.done:
            _meService.getProposalsQuantity().then((int proposals) {
              setState(() {
                _proposalsQuantity = proposals;
              });
            });
            _configurationService.luckyNumber.then((int luckyNumber) {
              setState(() {
                _luckyNumber = luckyNumber;
              });
            });
            if (snapShot.hasError) {
              print(snapShot.error);
            }
            if (firstAccess) {
              return GestureDetector(
                behavior: HitTestBehavior.opaque,
                child: _flag
                    ? IgnorePointer(
                        ignoring: firstAccess,
                        child: _buildBody(context),
                      )
                    : Stack(
                        children: <Widget>[
                          _buildBody(context),
                          Positioned.fill(
                            child: BackdropFilter(
                              filter: ImageFilter.blur(
                                sigmaX: 7,
                                sigmaY: 7,
                              ),
                              child: Container(
                                color: Colors.black.withOpacity(0),
                                child: blurredHomeScreen(),
                              ),
                            ),
                          ),
                        ],
                      ),
                onTap: () {
                  setState(() {
                    _flag = false;
                  });
                },
              );
            } else {
              return _buildBody(context);
            }
            break;
          default:
            return Column(
              children: <Widget>[
                Container(
                  color: AppColors.white,
                  height: 10,
                  width: 10,
                  child: Center(child: AppLoadingWidget()),
                ),
              ],
            );
            break;
        }
      },
    );
  }

  Widget blurredHomeScreen() {
    final size = MediaQuery.of(context).size;
    return Container(
      color: Colors.transparent,
      child: Column(
        children: <Widget>[
          SizedBox(
            height: size.height / 7,
          ),
          FractionalTranslation(
            translation: Offset(
              0.0,
              0.5,
            ),
            child: Container(
              alignment: Alignment.center,
              height: 100,
              decoration: BoxDecoration(
                color: AppColors.white,
                shape: BoxShape.circle,
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(
                      0,
                      3,
                    ),
                  ),
                ],
              ),
              child: FittedBox(
                alignment: Alignment.center,
                fit: BoxFit.cover,
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minWidth: 1,
                    minHeight: 1,
                  ),
                  child: Image.asset(
                    "assets/images/logo.png",
                    height: 50,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: size.height / 7,
          ),
          Column(
            children: <Widget>[
              Container(
                height: 110,
                width: 250,
                padding: EdgeInsets.symmetric(
                  vertical: Dimen.horizontal_padding,
                ),
                child: SkyButton(
                  text: "TENHO\nCADASTRO",
                  onPressed: () {
                    _facebookAppEvents.logEvent(
                      name: AnalyticsEventsConstants.signin,
                      parameters: {AnalyticsEventsConstants.action: AnalyticsEventsConstants.viewEntrance},
                    );
                    _firebaseAnalytics.logEvent(
                      name: AnalyticsEventsConstants.signin,
                      parameters: {AnalyticsEventsConstants.action: AnalyticsEventsConstants.viewEntrance},
                    );
                    Navigator.pushNamed(
                      context,
                      Routes.signIn,
                    );
                  },
                  fontSize: 27,
                  borderRadius: 15,
                  textColor: AppColors.white,
                  buttonColor: AppColors.green,
                  fontWeight: FontWeight.normal,
                  maxLines: 2,
                ),
              ),
              Container(
                height: 110,
                width: 250,
                padding: EdgeInsets.symmetric(
                  vertical: Dimen.horizontal_padding,
                ),
                child: SkyButton(
                  text: "QUERO ME\nCADASTRAR",
                  onPressed: () {
                    Navigator.pushNamed(
                      context,
                      Routes.signUp,
                    );
                  },
                  fontSize: 27,
                  borderRadius: 15,
                  textColor: AppColors.white,
                  buttonColor: AppColors.blue,
                  fontWeight: FontWeight.normal,
                  maxLines: 2,
                ),
              ),
            ],
          ),
          SizedBox(
            height: size.height / 10,
          ),
          Container(
            child: Container(
              height: 30,
              width: 250,
              child: SkyButton(
                text: "SOU DA TRANSPORTADORA",
                onPressed: () async {
                  launch(
                    Endpoints.appWebsite,
                  );
                },
                fontSize: 15,
                fontWeight: FontWeight.bold,
                buttonColor: AppColors.yellow,
                borderRadius: 50,
                textColor: AppColors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    List<Widget> _menuActionButtons = [
      AppButtonMenu(
        color: _haveFreight ? AppColors.yellow : AppColors.white,
        asset: "assets/icons/ativo_8.png",
        backgroundAssetImage: AppColors.green,
        textButton: 'FRETES',
        onPressed: () {
          _facebookAppEvents.logEvent(
            name: AnalyticsEventsConstants.freight,
            parameters: {
              AnalyticsEventsConstants.action: AnalyticsEventsConstants.viewEntrance,
            },
          );
          _firebaseAnalytics.logEvent(
            name: AnalyticsEventsConstants.freight,
            parameters: {
              AnalyticsEventsConstants.action: AnalyticsEventsConstants.viewEntrance,
            },
          );
          Navigator.pushNamed(
            context,
            Routes.freightChat,
            arguments: {
              "security_header": _headerSecurity,
            },
          );
          _setListHashThreads();
          _haveFreight = false;
        },
      ),
      AppButtonMenu(
        color: AppColors.white,
        asset: "assets/icons/ativo_9.png",
        assetPadding: 10.0,
        backgroundAssetImage: AppColors.green,
        textButton: "OMNI",
        onPressed: () async {
          if (await isOpenOmniRefinancingFirstTime()) {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => AppOmniRefinancingIntro(),
              ),
            );
          } else {
            Navigator.pushNamed(
              context,
              Routes.omniMenuOptions,
            );
          }
        },
      ),
      AppButtonMenu(
        color: AppColors.white,
        asset: "assets/icons/ativo_10.png",
        assetPadding: 10.0,
        backgroundAssetImage: AppColors.green,
        textButton: 'DESCONTOS',
        onPressed: () {
          _facebookAppEvents.logEvent(
            name: AnalyticsEventsConstants.discountPartner,
            parameters: {
              AnalyticsEventsConstants.action: AnalyticsEventsConstants.viewEntrance,
            },
          );
          _firebaseAnalytics.logEvent(
            name: AnalyticsEventsConstants.discountPartner,
            parameters: {
              AnalyticsEventsConstants.action: AnalyticsEventsConstants.viewEntrance,
            },
          );
          Navigator.pushNamed(context, Routes.clubMenu);
        },
      ),
      Stack(
        overflow: Overflow.visible,
        children: <Widget>[
          AppButtonMenu(
            key: globalKeyTataButton,
            color: AppColors.white,
            asset: "assets/icons/ativo_6.png",
            assetPadding: 0.0,
            textButton: 'TATÁ',
            onPressed: () async {
              var dialog = AppDialogPremiumUserPlan(
                key: key,
                initialMessageText: WhatsappConstants.premiumTataTextMessage,
              );

              var tip = _appCustomToolTip();

              List<String> list = await _configurationService.checkToolTip;
              bool flag = false;

              if (list.isEmpty) {
                tip[KeysAppCustomToolTip.tataButton].customToolTip(context: context);
                list.add(KeysAppCustomToolTip.tataButton);
                _configurationService.setCheckToolTip(list);
              } else {
                for (var i = 0; i < list.length; i++) {
                  if (list[i] == KeysAppCustomToolTip.tataButton) {
                    if (this.profileSummary.personal.premium) {
                      String phone = WhatsappConstants.numberWithCountryDDD;
                      var whatsappUrl = "whatsapp://send?phone=$phone&text=${WhatsappConstants.menuTataTextMessage}";
                      if (await canLaunch(whatsappUrl)) {
                        await launch(whatsappUrl);
                      } else {
                        appSnackbar(
                          text: 'Instale o WHATSAPP para falar com a Tatá!',
                        );
                      }
                    } else {
                      dialog.showPremiumDialog(
                        context,
                      );
                    }
                    break;
                  } else {
                    flag = true;
                  }
                }
              }
              if (flag && !list.contains(KeysAppCustomToolTip.tataButton)) {
                tip[KeysAppCustomToolTip.tataButton].customToolTip(context: context);
                list.add(KeysAppCustomToolTip.tataButton);
                _configurationService.setCheckToolTip(list);
              }
            },
          ),
          Positioned(
            left: 100,
            top: 5,
            child: Image.asset(
              "assets/icons/ativo_13.png",
              width: 50,
              height: 50,
            ),
          ),
        ],
      ),
      AppButtonMenu(
        color: AppColors.white,
        asset: "assets/icons/ativo_7.png",
        assetPadding: 10.0,
        backgroundAssetImage: AppColors.green,
        textButton: 'PASSA-TEMPO',
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => SocialMedias(),
            ),
          );
        },
      ),
    ];

    return Scaffold(
      key: key,
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: <Widget>[
              Stack(
                overflow: Overflow.visible,
                children: <Widget>[
                  Container(
                    child: Container(
                      height: 300,
                      width: MediaQuery.of(context).size.width,
                      child: Image(
                        image: AssetImage('assets/images/ic_header02.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Container(
                    child: Container(
                      height: 180,
                      width: MediaQuery.of(context).size.width,
                      child: Image(
                        image: AssetImage('assets/images/ic_header.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AppWebView(
                            selectedUrl: 'https://www.appcargo.com.br/',
                          ),
                        ),
                      );
                    },
                    child: Container(
                      margin: EdgeInsets.symmetric(vertical: 5),
                      child: FractionalTranslation(
                        translation: Offset(0.0, 0.5),
                        child: new Container(
                          alignment: Alignment.center,
                          height: 90,
                          decoration: new BoxDecoration(
                            color: AppColors.white,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 5,
                                blurRadius: 7,
                                offset: Offset(
                                  0,
                                  3,
                                ),
                              ),
                            ],
                          ),
                          child: FittedBox(
                            alignment: Alignment.center,
                            fit: BoxFit.cover,
                            child: ConstrainedBox(
                              constraints: BoxConstraints(minWidth: 1, minHeight: 1),
                              child: Image.asset(
                                "assets/images/logo.png",
                                height: 50,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 165),
                    height: 160,
                    child: CarouselSlider(
                      options: CarouselOptions(
                        autoPlay: true,
                        height: 290.0,
                        viewportFraction: 0.7,
                        enlargeCenterPage: false,
                        onPageChanged: (index, reason) {
                          setState(() {
                            _currentPositionBanner = index;
                          });
                        },
                      ),
                      items: _homeClubPartner.map(
                        (index) {
                          return AppHomeBanner(
                            homeBanner: index,
                          );
                        },
                      ).toList(),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        GestureDetector(
                          key: globalKeyLuckNumberButton,
                          onTap: () async {
                            var tip = _appCustomToolTip();

                            List<String> list = await _configurationService.checkToolTip;
                            bool flag = false;

                            if (list.isEmpty) {
                              tip[KeysAppCustomToolTip.luckNumberButton].customToolTip(context: context);
                              list.add(KeysAppCustomToolTip.luckNumberButton);
                              _configurationService.setCheckToolTip(list);
                            } else {
                              for (var i = 0; i < list.length; i++) {
                                if (list[i] == KeysAppCustomToolTip.luckNumberButton) {
                                  Navigator.pushNamed(
                                    context,
                                    Routes.luckyNumber,
                                    arguments: {
                                      "isFromHome": true,
                                    },
                                  );
                                  break;
                                } else {
                                  flag = true;
                                }
                              }
                            }
                            if (flag && !list.contains(KeysAppCustomToolTip.luckNumberButton)) {
                              tip[KeysAppCustomToolTip.luckNumberButton].customToolTip(context: context);
                              list.add(KeysAppCustomToolTip.luckNumberButton);
                              _configurationService.setCheckToolTip(list);
                            }
                          },
                          child: Container(
                            alignment: Alignment.center,
                            padding: EdgeInsets.only(
                              top: Dimen.horizontal_padding,
                              bottom: Dimen.horizontal_padding,
                            ),
                            margin: EdgeInsets.only(top: 30, left: 15),
                            child: Column(
                              children: <Widget>[
                                Container(
                                  child: Image.asset(
                                    "assets/images/ic_clover.png",
                                    width: 25,
                                    fit: BoxFit.contain,
                                    color: AppColors.white,
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  "N° da sorte",
                                  style: TextStyle(fontSize: 10, color: AppColors.white, fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              Routes.appUserSettings,
                              arguments: {
                                'user_data': this.profileSummary,
                              },
                            );
                          },
                          child: Container(
                            alignment: Alignment.center,
                            margin: EdgeInsets.only(
                              top: 30,
                              right: 15,
                              bottom: 5,
                            ),
                            child: FittedBox(
                              fit: BoxFit.fill,
                              child: Icon(
                                FlutterIcons.list_unordered_oct,
                                color: AppColors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: _homeClubPartner.map((element) {
                  int index = _homeClubPartner.indexOf(element);
                  return Container(
                    height: 8,
                    width: 8,
                    margin: EdgeInsets.symmetric(
                      vertical: 10.0,
                      horizontal: 2.0,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: AppColors.green,
                      ),
                      shape: BoxShape.circle,
                      color: _currentPositionBanner == index ? AppColors.green : AppColors.white,
                    ),
                  );
                }).toList(),
              ),
              SizedBox(
                height: 5,
              ),
              // Start menu buttons
              SingleChildScrollView(
                controller: scrollControllerMenuButton,
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: _menuActionButtons,
                ),
              ),
              // End menu buttons
              SizedBox(
                height: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: _menuActionButtons.map((element) {
                  int change;
                  int index = _menuActionButtons.indexOf(element);
                  if (scrollMenuButtonPosition >= 0 && scrollMenuButtonPosition <= 80) {
                    change = 0;
                  } else if (scrollMenuButtonPosition > 81 && scrollMenuButtonPosition <= 160) {
                    change = 1;
                  } else if (scrollMenuButtonPosition > 161 && scrollMenuButtonPosition <= 240) {
                    change = 2;
                  } else if (scrollMenuButtonPosition > 241 && scrollMenuButtonPosition <= 320) {
                    change = 3;
                  } else if (scrollMenuButtonPosition > 321 && scrollMenuButtonPosition <= 400) {
                    change = 4;
                  }
                  return Container(
                    height: 8,
                    width: 8,
                    margin: EdgeInsets.symmetric(
                      vertical: 10.0,
                      horizontal: 2.0,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: AppColors.green,
                      ),
                      shape: BoxShape.circle,
                      color: index == change ? AppColors.green : AppColors.white,
                    ),
                  );
                }).toList(),
              ),
              SizedBox(
                height: 5,
              ),
              ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                itemBuilder: (context, index) {
                  var tip = _appCustomToolTip();
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Expanded(
                        child: Container(
                          height: 80.0,
                          margin: const EdgeInsets.symmetric(
                            vertical: 5.0,
                            horizontal: 24.0,
                          ),
                          child: Stack(
                            children: <Widget>[
                              GestureDetector(
                                key: _list[index].link.contains('https://sostata.brotherstechnohouse.com.br')
                                    ? tip[KeysAppCustomToolTip.emergencyButton].widgetKey
                                    : _list[index].link.contains('https://play.google.com/store/apps/details?id=br.com.custocalc.io')
                                        ? tip[KeysAppCustomToolTip.costCalcButton].widgetKey
                                        : _list[index].link.contains('https://appcargostore.com.br/') ? tip[KeysAppCustomToolTip.storeButton].widgetKey : GlobalKey(),
                                child: Container(
                                  constraints: new BoxConstraints.expand(),
                                  height: 80.0,
                                  margin: new EdgeInsets.only(
                                    left: 46.0,
                                  ),
                                  decoration: new BoxDecoration(
                                    color: Colors.white,
                                    shape: BoxShape.rectangle,
                                    borderRadius: new BorderRadius.circular(
                                      8.0,
                                    ),
                                    boxShadow: <BoxShadow>[
                                      new BoxShadow(
                                        color: Colors.black12,
                                        blurRadius: 3.0,
                                        offset: new Offset(
                                          0.0,
                                          2.0,
                                        ),
                                      ),
                                    ],
                                  ),
                                  child: _list[index].link.contains(
                                            'https://appcargostore.com.br/',
                                          )
                                      ? Container(
                                          margin: new EdgeInsets.fromLTRB(
                                            30.0,
                                            25.0,
                                            16.0,
                                            16.0,
                                          ),
                                          child: new Text(
                                            _list[index].name,
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 18.0,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        )
                                      : Stack(
                                          overflow: Overflow.visible,
                                          children: <Widget>[
                                            Container(
                                              margin: new EdgeInsets.fromLTRB(
                                                30.0,
                                                25.0,
                                                16.0,
                                                16.0,
                                              ),
                                              child: new Text(
                                                _list[index].name,
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 18.0,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ),
                                            Positioned(
                                              left: 260,
                                              top: -5,
                                              child: Image.asset(
                                                "assets/icons/ativo_13.png",
                                                width: 50,
                                                height: 50,
                                              ),
                                            ),
                                          ],
                                        ),
                                ),
                                onTap: () async {
                                  var tip = _appCustomToolTip();
                                  List<String> list = await _configurationService.checkToolTip;
                                  bool flag = false;

                                  if (_list[index].link.contains('https://sostata.brotherstechnohouse.com.br')) {
                                    if (list.isEmpty) {
                                      tip[KeysAppCustomToolTip.emergencyButton].customToolTip(context: context);
                                      list.add(KeysAppCustomToolTip.emergencyButton);
                                      _configurationService.setCheckToolTip(list);
                                    } else {
                                      for (var i = 0; i < list.length; i++) {
                                        if (list[i] == KeysAppCustomToolTip.emergencyButton) {
                                          checkPremium(
                                            premium: this.profileSummary.personal.premium,
                                            url: _list[index].link,
                                            messageTata: "Tatá , o meu \"${_list[index].name}\" está bloqueado, pode me ajudar?",
                                          );
                                          break;
                                        } else {
                                          flag = true;
                                        }
                                      }
                                    }
                                    if (flag && !list.contains(KeysAppCustomToolTip.emergencyButton)) {
                                      tip[KeysAppCustomToolTip.emergencyButton].customToolTip(context: context);
                                      list.add(KeysAppCustomToolTip.emergencyButton);
                                      _configurationService.setCheckToolTip(list);
                                    }
                                  } else if (_list[index].link.contains('https://play.google.com/store/apps/details?id=br.com.custocalc.io')) {
                                    if (list.isEmpty) {
                                      tip[KeysAppCustomToolTip.costCalcButton].customToolTip(context: context);
                                      list.add(KeysAppCustomToolTip.costCalcButton);
                                      _configurationService.setCheckToolTip(list);
                                    } else {
                                      for (var i = 0; i < list.length; i++) {
                                        if (list[i] == KeysAppCustomToolTip.costCalcButton) {
                                          checkPremium(
                                            premium: this.profileSummary.personal.premium,
                                            url: _list[index].link,
                                            messageTata: "Tatá , o meu \"${_list[index].name}\" está bloqueado, pode me ajudar?",
                                          );
                                          break;
                                        } else {
                                          flag = true;
                                        }
                                      }
                                    }
                                    if (flag && !list.contains(KeysAppCustomToolTip.costCalcButton)) {
                                      tip[KeysAppCustomToolTip.costCalcButton].customToolTip(context: context);
                                      list.add(KeysAppCustomToolTip.costCalcButton);
                                      _configurationService.setCheckToolTip(list);
                                    }
                                  } else if (_list[index].link.contains('https://appcargostore.com.br/')) {
                                    if (list.isEmpty) {
                                      tip[KeysAppCustomToolTip.storeButton].customToolTip(context: context);
                                      list.add(KeysAppCustomToolTip.storeButton);
                                      _configurationService.setCheckToolTip(list);
                                    } else {
                                      for (var i = 0; i < list.length; i++) {
                                        if (list[i] == KeysAppCustomToolTip.storeButton) {
                                          _launchURLApp(_list[index].link);
                                          break;
                                        } else {
                                          flag = true;
                                        }
                                      }
                                    }
                                    if (flag && !list.contains(KeysAppCustomToolTip.storeButton)) {
                                      tip[KeysAppCustomToolTip.storeButton].customToolTip(context: context);
                                      list.add(KeysAppCustomToolTip.storeButton);
                                      _configurationService.setCheckToolTip(list);
                                    }
                                  }
                                },
                              ),
                              Container(
                                alignment: FractionalOffset.centerLeft,
                                child: CircleAvatar(
                                  backgroundColor: Colors.white,
                                  backgroundImage: NetworkImage(
                                    _list[index].icon,
                                  ),
                                  radius: 35.0,
                                ),
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  );
                },
                itemCount: _list.length,
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                width: MediaQuery.of(context).size.width / 1.35,
                margin: EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 25,
                ),
                child: RaisedButton.icon(
                  key: globalKeyRequestFreightButton,
                  icon: Icon(
                    Icons.location_on,
                    color: AppColors.white,
                  ),
                  onPressed: () async {
                    var tip = _appCustomToolTip();

                    List<String> list = await _configurationService.checkToolTip;

                    bool flag = false;
                    if (list.isEmpty) {
                      tip[KeysAppCustomToolTip.requestFreightButton].customToolTip(context: context);
                      list.add(KeysAppCustomToolTip.requestFreightButton);
                      _configurationService.setCheckToolTip(list);
                    } else {
                      for (var i = 0; i < list.length; i++) {
                        if (list[i] == KeysAppCustomToolTip.requestFreightButton) {
                          Navigator.pushNamed(
                            context,
                            Routes.requestFreight,
                            arguments: false,
                          );
                          break;
                        } else {
                          flag = true;
                        }
                      }
                    }
                    if (flag && !list.contains(KeysAppCustomToolTip.requestFreightButton)) {
                      tip[KeysAppCustomToolTip.requestFreightButton].customToolTip(context: context);
                      list.add(KeysAppCustomToolTip.requestFreightButton);
                      _configurationService.setCheckToolTip(list);
                    }
                  },
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      10,
                    ),
                  ),
                  color: AppColors.green,
                  label: Container(
                    height: 60,
                    child: Center(
                      child: Text(
                        "Peça seu frete com\norigem e destino".toUpperCase(),
                        style: TextStyle(
                          fontSize: 18,
                          color: AppColors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                decoration: new BoxDecoration(
                  color: Color(0xFF0E3311).withOpacity(0),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<ChatMember> openTataContactChat() async {
    _facebookAppEvents.logEvent(
      name: AnalyticsEventsConstants.chatView,
      parameters: {
        AnalyticsEventsConstants.action: AnalyticsEventsConstants.viewEntrance,
      },
    );
    _firebaseAnalytics.logEvent(
      name: AnalyticsEventsConstants.chatView,
      parameters: {
        AnalyticsEventsConstants.action: AnalyticsEventsConstants.viewEntrance,
      },
    );

    await _chatMessageService.saveEntity(Map<String, dynamic>.from(_tataContactEntity), _driverHash);

    ChatMember chatMember = await _chatMessageService.getMemberByHash("35fzNAlINoJZRkCKS2Gps9");

    return chatMember;
  }

  Future<bool> isOpenAppFirstTime() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var isFirstTime = prefs.getBool('first_time');
    if (isFirstTime != null && !isFirstTime) {
      prefs.setBool('first_time', false);
      return false;
    } else {
      prefs.setBool('first_time', false);
      return true;
    }
  }

  Future<bool> isOpenOmniRefinancingFirstTime() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var isFirstTime = prefs.getBool('omni_refinancing_first_time');
    if (isFirstTime != null && !isFirstTime) {
      prefs.setBool('omni_refinancing_first_time', false);
      return false;
    } else {
      prefs.setBool('omni_refinancing_first_time', false);
      return true;
    }
  }

  void notifyUserAboutBackgroundLocation(BuildContext context) async {
    AppDialogBackgroundLocationInformation.notifyUserThatAppUsesBackgroundLocation(context).then((_) {
      locationService.initBackgroundMonitoring();
    });
  }
}
