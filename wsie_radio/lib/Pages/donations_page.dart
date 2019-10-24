import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:webfeed/webfeed.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/gestures.dart';




const card_padding = 15.0;
const card_text_size = 15.0;
const heading_text_size = 20.0;
const body_text_size = 18.0;
const SIUERed = const Color(0xFFe41c24);

class DonationsPage extends StatefulWidget {
  
  @override
  State createState() => new __DonationsPage();
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

class __DonationsPage extends State<DonationsPage> with AutomaticKeepAliveClientMixin<DonationsPage> {
  //want to keep the page of the application alive, not matter if the user goes to another page
  @override
  bool get wantKeepAlive => true;


  @override
  Widget build(BuildContext context){
    return MaterialApp(
      color: Colors.white,
      home: Scaffold(
        resizeToAvoidBottomPadding: false,
        body: new Container(
          child: new Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  
                  Padding(
                    padding: const EdgeInsets.fromLTRB(5.0, 20.0, 5.0, 5.0),
                    child: Text(
                      'Donation Information:',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: heading_text_size,
                          fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child:Text(
                      'WSIE 88.7 The Sound is completely funded by donations from our community; If you like what you are hearing, please consider donating! ',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: body_text_size),
                    ),
                  ),
                  
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: SizedBox(
                      width: 330.0,
                      height: 50.0,
                      child: RaisedButton(
                        color: SIUERed,
                        elevation: 4.0,
                        onPressed: ()=> _launchURL('https://relay-ccon.foundation.siue.edu/ccon/new_gift.do?action=newGift&giving_page_id=0&site=SIUE_Foundation/'),
                        child: Text('Donate',style: TextStyle(fontSize: heading_text_size, color: Colors.white),),
                      ),
                    ),
                  ),
                   
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Text(
                      'Underwriter Information:',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize:heading_text_size),
                    ),
                  ),
                  

                  __songContainer(),
                ],
              )
        ),
      ),
    );
  }

  Widget __songContainer(){

      return new Expanded(
        child: FutureBuilder(
          future: fetchLatestNews(),
          builder: (BuildContext context, AsyncSnapshot snapshot){
            if(snapshot.hasData){
              if(snapshot.data.length > 0){
                return new ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext context, int index){
                    List titleAndLinks = snapshot.data[index].toString().split('########');
                    return Card(
                        child:Padding(
                          padding:const EdgeInsets.all(card_padding),
                          child: RichText(
                              text: TextSpan(children: [
                                TextSpan(
                                    text: "Title: ${titleAndLinks[0]}\n",
                                    style: TextStyle(fontSize: card_text_size, color: Colors.black)),
                                TextSpan(
                                    text: "Link to article",
                                    style: TextStyle(
                                        fontSize: card_text_size,
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





