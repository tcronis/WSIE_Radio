import 'package:flutter/material.dart';
import 'package:http/http.dart';

import 'package:webview_flutter/webview_flutter.dart';

class FacebookFeed extends StatefulWidget {
  @override
  State createState() => new __FacebookFeed();
}



class __FacebookFeed extends State<FacebookFeed> {
  @override
  Widget build(BuildContext context) {
    
    // int width = MediaQuery.of(context).size.width.roundToDouble().toInt();
    // int height = MediaQuery.of(context).size.height.roundToDouble().toInt();
    return new Container(
      child: WebView(
          // initialUrl: "https://www.facebook.com/pg/WSIE887theSound/posts/?ref=page_internal",
          initialUrl: "https://www.youtube.com",
          javascriptMode: JavascriptMode.unrestricted,
          debuggingEnabled: true,   
          navigationDelegate: (NavigationRequest request){
            print(request.url.toString());
            return NavigationDecision.navigate;
          },
        
      ),
    );
  }
}
