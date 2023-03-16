import 'package:app_cargo/constants/app_colors.dart';
import 'package:app_cargo/di/container.dart';
import 'package:app_cargo/i18n/localization.dart';
import 'package:app_cargo/routes.dart';
import 'package:app_cargo/screens/freight_chat/state/chat_state.dart';
import 'package:app_cargo/screens/message_quantity_state.dart';
import 'package:app_cargo/services/navigation/navigation_service.dart';
import 'package:app_cargo/services/notification/app_notification_service.dart';
import 'package:app_cargo/services/notification/firebase_messaging_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:provider/provider.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Locale brazilianPortuguese = const Locale('pt', 'BR');
    Locale americanEnglish = const Locale('en', 'US');

    NavigationService navigationService =
        DIContainer().get<NavigationService>();

    return MultiProvider(
      providers: [
        ChangeNotifierProvider<MessageQuantityState>(
          create: (_) => MessageQuantityState(),
        ),
        ChangeNotifierProvider<ChatState>(
          create: (_) => ChatState(),
        ),
        Provider<AppNotificationService>(
          create: (context) => AppNotificationService(),
        ),
        Provider<FirebaseMessagingService>(
          create: (context) =>
              FirebaseMessagingService(AppNotificationService()),
        ),
      ],
      child: PlatformApp(
        debugShowCheckedModeBanner: false,
        locale: brazilianPortuguese,
        navigatorKey: navigationService.navigatorKey,
        localizationsDelegates: [
          const AppLocalizationDelegate(),
          GlobalCupertinoLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        supportedLocales: [
          brazilianPortuguese,
          americanEnglish,
        ],
        routes: Routes.routes,
        android: (context) => MaterialAppData(
          theme: ThemeData(
            fontFamily: 'Lato',
            primaryColor: AppColors.green,
            accentColor: AppColors.blue,
          ),
        ),
        ios: (context) => CupertinoAppData(
          theme: CupertinoThemeData(
            primaryColor: AppColors.green,
            textTheme: CupertinoTextThemeData(
              textStyle: TextStyle(
                fontFamily: 'Lato',
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class AppModel with ChangeNotifier {}
