import 'package:app_cargo/constants/analytics_events_constants.dart';
import 'package:app_cargo/di/container.dart';
import 'package:app_cargo/domain/chat/chat_member.dart';
import 'package:app_cargo/domain/driver_contact_data/driver_contact_data.dart';
import 'package:app_cargo/domain/driver_contact_update/driver_contact_update.dart';
import 'package:app_cargo/domain/driver_personal_data/driver_personal_data.dart';
import 'package:app_cargo/domain/freight_company_summary/freight_company_summary.dart';
import 'package:app_cargo/screens/chat/chat_screen.dart';
import 'package:app_cargo/services/config/config_service.dart';
import 'package:app_cargo/services/me/me_service.dart';
import 'package:app_cargo/widgets/app_scaffold.dart';
import 'package:facebook_app_events/facebook_app_events.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DriverAndFreightChat extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _DriverAndFreightChatState();
}

class _DriverAndFreightChatState extends State<DriverAndFreightChat> {
  MeService meService = DIContainer().get<MeService>();
  ConfigurationService configurationService =
      DIContainer().get<ConfigurationService>();
  Map<String, dynamic> args;
  ChatMember otherChatMember;
  DriverPersonalData driverPersonalData;
  DriverContactData driverContactData;
  Future _loaded;
  List<String> _hashs = List();
  bool isPremium;
  FacebookAppEvents _facebookAppEvents = DIContainer().get<FacebookAppEvents>();

  void initState() {
    super.initState();
    _facebookAppEvents.logEvent(
        name: AnalyticsEventsConstants.chatView,
        parameters: {
          AnalyticsEventsConstants.action: AnalyticsEventsConstants.viewEntrance
        });
    _loaded = configurationService.driverHash.then((hash) {
      return meService.getPersonalData().then((personalData) {
        return meService.getAllDriverData().then((profileSummary) {
          isPremium = profileSummary.personal.premium;
          return meService.getContactUpdateData().then((driverContactUpdate) {
            if (driverContactUpdate is DriverContactUpdate) {
              driverPersonalData = personalData;
              driverContactData = driverContactUpdate.contact;
            }
            _hashs.add(hash);
            _hashs.add(otherChatMember.hash);
            return;
          });
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    args = ModalRoute.of(context).settings.arguments;
    if (null != args && args.isNotEmpty) {
      otherChatMember = args["otherChatMember"] as ChatMember;
    }
    return FutureBuilder(
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.done:
            List<Map> _entities = List();
            _entities.add({
              "imageUrl": driverPersonalData.personalPhotoUrl,
              "name": driverPersonalData.alias,
              "phone": driverContactData.cellNumber,
            });
            _entities.add({
              "imageUrl": otherChatMember.imageUrl,
              "name": otherChatMember.name,
              "phone": otherChatMember.phone
            });
            ChatScreen chatScreen = ChatScreen(_hashs, _entities, isPremium);
            AppScaffold.chatScreen = chatScreen;
            return chatScreen;
            break;
          default:
            return CircularProgressIndicator();
        }
      },
      future: _loaded,
    );
  }
}
