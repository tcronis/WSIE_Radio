import 'package:flutter/material.dart';

import 'package:webview_flutter/webview_flutter.dart';

class FacebookFeed extends StatefulWidget {
  @override
  State createState() => new __FacebookFeed();
}

class __FacebookFeed extends State<FacebookFeed> {
  @override
  Widget build(BuildContext context) {
   return WebView(
      initialUrl: 'https://www.facebook.com/WSIE887theSound/',
      javascriptMode: JavascriptMode.disabled,
    );
  }
}
