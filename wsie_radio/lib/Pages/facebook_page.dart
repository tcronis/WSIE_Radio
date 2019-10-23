import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:webfeed/webfeed.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/gestures.dart';


class FacebookFeed extends StatefulWidget {
  
  @override
  State createState() => new __FacebookFeed();
}

void _launchURL(String IncomingUrl) async {
  String url = IncomingUrl;
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

Future<Map> fetchLatestNews() async {
  var client = http.Client();
  final response = await client.get("https://developer.apple.com/news/releases/rss/releases.rss");

  if(response.statusCode == 200){
    var RSSFEED = new RssFeed.parse(response.body);
    Map map = new Map();
    for (int i = 0; i < RSSFEED.items.length; i++) {
      map[i] = RSSFEED.items[i].title.toString() + "########" + RSSFEED.items[i].link.toString();
    }

    return map;
  }else {
    throw Exception("Failed to load post.");
  }
}

class __FacebookFeed extends State<FacebookFeed> {

  @override
  Widget build(BuildContext context){
    return MaterialApp(
      color: Colors.white,
      home: Scaffold(
        resizeToAvoidBottomPadding: false,
        body: new Container(
          child: new ListView.builder(
            itemCount: 1,
            itemBuilder: (BuildContext context, int index){
              return Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
                    child: Text(
                      'Donation Information:',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 22.0),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.fromLTRB(22.0, 20.0, 22.0, 0.0),
                    child: Text(
                      'WSIE 88.7 The Sound is completely funded by donations from our community; If you like what you are hearing, please consider donating! ',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 18.0),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.fromLTRB(15.0, 30.0, 15.0, 0.0),
                    child: SizedBox(
                      width: 330.0,
                      height: 50.0,
                      child: RaisedButton(
                        color: Colors.red,
                        onPressed: ()=> _launchURL('https://relay-ccon.foundation.siue.edu/ccon/new_gift.do?action=newGift&giving_page_id=0&site=SIUE_Foundation/'),
                        child: Text('Donate',style: TextStyle(fontSize: 24, color: Colors.black),),
                      ),
                    )
                  ),

                  Padding(
                    padding: const EdgeInsets.fromLTRB(20.0, 30.0, 20.0, 0.0),
                    child: Text(
                      'Underwriter Information:',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 22.0),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 0.0),
                    child:SizedBox(
                      height: 325,
                      width: double.infinity,
                      child: __songContainer(),
                    )
                  )
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget __songContainer(){

      return new Container(
        child: FutureBuilder(
          future: fetchLatestNews(),
          builder: (BuildContext context, AsyncSnapshot snapshot){
            if(snapshot.hasData){
              if(snapshot.data.length > 0){
                return new ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext context, int index){
                    List titleAndLinks = snapshot.data[index].toString().split('########');
                    return Card(
                        child:Padding(
                          padding:const EdgeInsets.all(10.0),
                          child: RichText(
                              text: TextSpan(children: [
                                TextSpan(
                                    text: "Title: ${titleAndLinks[0]}\nLink:",
                                    style: TextStyle(fontSize: 15, color: Colors.black)),
                                TextSpan(
                                    text: "${titleAndLinks[1]}",
                                    style: TextStyle(
                                        fontSize: 15,
                                        color: Colors.blue,
                                        decoration: TextDecoration.underline),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        _launchURL(titleAndLinks[1]);
                                      })
                              ])),
//                          child:
//                          Text("Title: ${titleAndLinks[0]}\nLink:${titleAndLinks[1]}"),
                        )
                    );
                  },
                );
              }
            } else{
              return Center(
                child: new CircularProgressIndicator(),
              );
            }
          },
        ),
      );
    }
}





