import 'package:flutter/cupertino.dart';

class NavigationService {

  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  Future<dynamic> navigateTo(String routeName) {
    return navigatorKey.currentState.pushNamed(routeName);
  }

  Future<dynamic> navigateToWithParameters(String routeName, Map<String, dynamic> arguments) {
    return navigatorKey.currentState.pushNamed(routeName, arguments: arguments);
  }

  bool goBack() {
    // TODO: explain why the next line was commented.
    // return navigatorKey.currentState.pop();
  }

}