import 'dart:async';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class AppWebView extends StatelessWidget {
  final String selectedUrl;

  final Completer<WebViewController> _controlller =
      Completer<WebViewController>();

  AppWebView({
    Key key,
    @required this.selectedUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WebView(
        initialUrl: selectedUrl,
        javascriptMode: JavascriptMode.unrestricted,
        onWebViewCreated: (WebViewController webViewController) {
          _controlller.complete(webViewController);
        },
      ),
    );
  }
}
