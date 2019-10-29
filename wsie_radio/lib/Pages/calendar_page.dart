import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:webfeed/webfeed.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/gestures.dart';
// import 'package:wsie_radio/Pages/email_donations_page.dart' as prefix0;

// import 'date_info.dart';

const card_padding = 15.0;
const card_text_size = 15.0;
const heading_text_size = 20.0;
const body_text_size = 18.0;


// void main() async {
//   final AtomFeed feed = await DateEvent().getFeed();

//   __Calendar(feed);
// }

class Calendar extends StatefulWidget{
  //AtomFeed feed = DateEvent().getFeed();
  
  //__Calendar(this.feed);
  @override
  State createState() => new __Calendar();
}

void goToUrl(String IncomingUrl) async {

  String url = IncomingUrl;

  if (await canLaunch(url)) {

    await launch(url);

  } else { 
    throw '$url could not be reached';
   }
}

Future<Map> getNewsFeed() async {

  var client = http.Client();

  final response = await client.get("http://www.siue.edu/news/current.xml");

  if(response.statusCode == 200){

    var NEWSFEED = new RssFeed.parse(response.body);


    



    Map map = new Map();

    for (int i = 0; i < NEWSFEED.items.length; i++) {

      String temp = utf8.decode(NEWSFEED.items[i].title.codeUnits);


      map[i] = temp + "########" + NEWSFEED.items[i].pubDate.toString().substring(0,16) + "########" + NEWSFEED.items[i].link.toString();
    }

    return map;
  }else {
    throw Exception("Post could not be loaded.");
  }
}

class __Calendar extends State<Calendar> with AutomaticKeepAliveClientMixin<Calendar>{
  //final List<Date> dateEvents;
  //final AtomFeed feed;
  
  
  //__Calendar(this.feed);

  @override
  Widget build(BuildContext context){
    return MaterialApp(
      home: Scaffold(
        body: new Container(
          child: new Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
               Padding(
                padding: const EdgeInsets.fromLTRB(5.0, 20.0, 5.0, 5.0),
                child: Text(
                  'WSIE Events Calendar:',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: heading_text_size),
                ),
              ),
              _eventData(),
              // ListView.builder(
              // itemCount: 1,//feed.items.length,
              // itemBuilder: (BuildContext ctxt, int index) {
              //   return Column(
              //     children: <Widget>[
              //         Padding(
              //           padding: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 0.0),
              //           child:SizedBox(
              //             height: 500,
              //             width: double.infinity,
              //             child: _eventData(),
              //           )
              //         )
              //     ]
                // );
              // })
            ],
          ),
        ),
    ));
    
    
  }

  // ListView _buildList(context) {
    
  //   // return ListView.builder(
      
  //   //   itemCount: 5, 
  //   //   itemBuilder: (context, int) {
  //   //     // DateCard for each date.
  //   //     return DateCard(dateEvents[int]);
  //   //   },
  //   // );
  // }

    Widget _eventData(){
      return new Expanded(
        child: FutureBuilder(
          future: getNewsFeed(),
          builder: (BuildContext context, AsyncSnapshot snapshot){
            if(snapshot.hasData){
              if(snapshot.data.length > 0){
                return new ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext context, int index){
                    List eventData = snapshot.data[index].toString().split('########');
                    return Card(
                        child:Padding(
                          padding:const EdgeInsets.all(card_padding),
                          child: RichText(
                              text: TextSpan(children: [
                                TextSpan(
                                    text: "Title: ${eventData[0]}\n",
                                    style: TextStyle(fontSize: card_text_size, color: Colors.black)),
                                TextSpan(
                                    text: "Date Published: ${eventData[1]}\n",
                                    style: TextStyle(fontSize: card_text_size, color: Colors.black)),
                                TextSpan(
                                    text: "Link",
                                    style: TextStyle(
                                        fontSize: card_text_size,
                                        color: Colors.blue,
                                        decoration: TextDecoration.underline),
                                    recognizer: TapGestureRecognizer()
                                     ..onTap = () {
                                       goToUrl(eventData[2]);
                                      }
                                      )
                              ])),

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
  

  @override
  bool get wantKeepAlive => true;
}