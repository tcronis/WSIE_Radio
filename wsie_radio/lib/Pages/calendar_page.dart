import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
//import 'package:intl/intl.dart';
import 'package:webfeed/webfeed.dart';
//import 'package:webview_flutter/webview_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/gestures.dart';

import 'date_event_card.dart';
import 'date_info.dart';


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
      var str1 = NEWSFEED.items[i].pubDate.toString();
      
      map[i] = NEWSFEED.items[i].title.toString() + "########" + str1.substring(0,16) + "########" +
       NEWSFEED.items[i].description.toString().substring(0, 100) +  "########" + NEWSFEED.items[i].link.toString();
    }

    return map;
  }else {
    throw Exception("Post could not be loaded.");
  }
}


Future<Map> getNewsFeedDescription() async {

  var client2 = http.Client();

  final response2 = await client2.get("http://www.siue.edu/news/current.xml");

  if(response2.statusCode == 200){

    var NEWSFEED2 = new RssFeed.parse(response2.body);

    Map map2 = new Map();

    for (int i = 0; i < NEWSFEED2.items.length; i++) {
      //var str1 = NEWSFEED.items[i].description.toString();
      
      map2[i] = NEWSFEED2.items[i].description.toString() + "########";
    }

    return map2;
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
      appBar: AppBar(
        title: Text('News and Events'),
        backgroundColor: Colors.red[900],
      ),
      body: ListView.builder(
          itemCount: 1,//feed.items.length,
           itemBuilder: (BuildContext ctxt, int index) {
             return Column(
               children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 0.0),
                    child:SizedBox(
                      height: 500,
                      width: double.infinity,
                      child: _eventData(),
                      
                    ),
                  )
               ]
             );
          
          }),
    ));
    
    
  }

  

    Widget _eventData(){

      return new Container(
        child: FutureBuilder(

          future: getNewsFeed(),
          builder: (BuildContext context, AsyncSnapshot snapshot){
            if(snapshot.hasData){
              if(snapshot.data.length > 0){
                return new ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext context, int index){

                    List eventData = snapshot.data[index].toString().split('########');
                
                    return Card(
                      child: new InkWell(
                        onTap: () {
                          //print("tapped");
                           //_popUpCard();
                           //_showDialog();
                           //_getNewsFeedDescription();

                           SizedBox(
                            height: 200,
                            width: double.infinity,
                            child: _popUpCard(),
                      
                            );
                        },
                        child: Container(
                          child:Padding(
                          padding:const EdgeInsets.all(10.0),
                          child: RichText(
                              text: TextSpan(children: [
                                TextSpan(
                                    text: "Title: ${eventData[0]}\n",
                                    style: TextStyle(fontSize: 15, color: Colors.black)),
                                TextSpan(
                                    text: "Date Published: ${eventData[1]}\nLink:",
                                    style: TextStyle(fontSize: 15, color: Colors.black)),
                                // TextSpan(
                                //     text: "Description: ${eventData[2]} ...\n ",
                                //     style: TextStyle(fontSize: 15, color: Colors.black)),
                                TextSpan(
                                    text: "${eventData[3]}",
                                    style: TextStyle(
                                        fontSize: 15,
                                        color: Colors.blue,
                                        decoration: TextDecoration.underline),
                                    recognizer: TapGestureRecognizer()
                                     ..onTap = () {
                                       goToUrl(eventData[2]);
                                      }
                                      )
                              ])),

                        ),
                        
                        ),
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



    Widget _popUpCard(){
       showDialog(
        context: context,
        builder: (context){

      //return new Container(
        return new FutureBuilder(

          future: getNewsFeedDescription(),
          builder: (BuildContext context, AsyncSnapshot snapshot){
            if(snapshot.hasData){
              if(snapshot.data != null){
                
                 //return new ListView.builder(
                   //itemCount: snapshot.data.length,
                   //itemBuilder: (BuildContext context, int index){

                  //var map2 = getNewsFeedDescription();
                    //for (int i = 0; i < snapshot.data.length; i++) 
      
                      //String eventData = snapshot.data.toString();
                      
                      //List eventData = snapshot.data[index].toString().split('########');
                      List eventData = snapshot.data.toString().split('########');
                    
                
                    return new Card(
                        child: SingleChildScrollView(
                          //child: ListView.builder(
                          //itemCount: snapshot.data.length,
                          //itemBuilder: (BuildContext context, int index){
                            
                        child: InkWell(
                        onTap: () {
                          //print("tapped");
                           //_showDialog();
                           Navigator.pop(context);
                        },
                        child: Container(
                          //height: 200,
                          child:Padding(
                          padding:const EdgeInsets.all(10.0),
                          child: RichText(
                              text: TextSpan(children: [
                                TextSpan(
                                    text: "${eventData[0]} ...\n",
                                    style: TextStyle(fontSize: 15, color: Colors.black)),
                                
                              ])),

                        ),
                        
                        ),
                      )
                    //}
                    )
                    );
                 //},
                 //);
              }
            } else{
             return Center(
               child: new CircularProgressIndicator(),
             );
            }
          },
        );
     //);

        }
        
         

      );
       

    }
  

  @override
  bool get wantKeepAlive => true;
}