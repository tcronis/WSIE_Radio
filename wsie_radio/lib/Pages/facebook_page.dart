import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

import 'package:webview_flutter/webview_flutter.dart';
//import 'package:html.dart';



class FacebookFeed extends StatefulWidget {
  
  @override
  State createState() => new __FacebookFeed();
}



class __FacebookFeed extends State<FacebookFeed> {
  Completer<WebViewController> _controller = Completer<WebViewController>();
  final String initialUrl3 = "NavigationRequest(url: https://m.facebook.com/pg/WSIE887theSound/posts/, isForMainFrame: true)";
  final String initialUrl2 = "https://www.facebook.com/pg/WSIE887theSound/posts/";

  //final myWebView = (WebView) findViewById(R.id.webview);
  
  
  
  
  @override
  Widget build(BuildContext context) {
      
    
    // int width = MediaQuery.of(context).size.width.roundToDouble().toInt();
    // int height = MediaQuery.of(context).size.height.roundToDouble().toInt();
    return new Container(
      child: WebView(
          initialUrl: "https://m.facebook.com/WSIE887theSound/",
          //initialUrl: "https://www.youtube.com",
          javascriptMode: JavascriptMode.unrestricted,
          debuggingEnabled: true,   
          onWebViewCreated: (WebViewController webViewController) {
            _controller.complete(webViewController);
            
          },
          navigationDelegate: (NavigationRequest request){
            print(request.url);
            if (!request.url.startsWith("https://m.facebook.com/WSIE887theSound/")) {
              print('navigation to $request is blocked');
              return NavigationDecision.prevent;
            }
            if(request.url.contains("%") || request.url.contains("profile") ){
              print('navigation to $request is blocked');
              return NavigationDecision.prevent;
            }
            if(request.url.contains("login")){
              print('navigation to $request is blocked');
              return NavigationDecision.prevent;
            }
            if(request.url.contains("photos")){
              print('navigation to $request is blocked');
              return NavigationDecision.prevent;
            }
            // if (request.url != "https://www.facebook.com/WSIE887theSound/" ){
            //   print(request.url);
            //   print('navigation to $request is blocked');
            //   return NavigationDecision.prevent;
            // }
            
            if (request.url.startsWith("https://m.facebook.com/login.php?next=https%3A%2F%2Fm.facebook.com%2FWSIE887theSound%2F&ref=104&rs=1&lrs=1&rid=134507189896890&lrid=134507189896890&refsrc=https%3A%2F%2Fm.facebook.com%2FWSIE887theSound%2F")) {
              print('navigation to $request is blocked');
              return NavigationDecision.prevent;
            }
            if (request.url.startsWith("https://m.facebook.com/r.php?next=https%3A%2F%2Fm.facebook.com%2FWSIE887theSound%2F&cid=104&rs=1&rid=134507189896890")) {
              print('navigation to $request is blocked');
              return NavigationDecision.prevent;
            }
            // if (request.url.startsWith("https://m.facebook.com")) {
            //   print('navigation to $request is blocked');
            //   return NavigationDecision.prevent;
            // }
            print(request.url.toString());
            return NavigationDecision.navigate;
          },
        
      ),
    );
  }

  String sub(){

  }
}
