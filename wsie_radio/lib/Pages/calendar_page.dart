import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:webfeed/webfeed.dart';
import 'package:webview_flutter/webview_flutter.dart';

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

class __Calendar extends State<Calendar> with AutomaticKeepAliveClientMixin<Calendar>{
  //final List<Date> dateEvents;
  //final AtomFeed feed;
  
  
  //__Calendar(this.feed);

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text('News and Events'),
        backgroundColor: Colors.red[900],
      ),
      body: ListView.builder(
          itemCount: 5,//feed.items.length,
           itemBuilder: (BuildContext ctxt, int index) {
          //   final item = feed.items[index];
          //   return ListTile(
          //     title: Text(item.title),
          //     subtitle: Text('Published: ' +
          //         DateFormat.yMd().format(DateTime.parse(item.published))),
          //     contentPadding: EdgeInsets.all(16.0),
          //     onTap: () async {
          //   //  Navigator.push(
          //   //         context,
          //   //         MaterialPageRoute(
          //   //             builder: (context) => main(
          //   //                 item.id.replaceFirst('http', 'https')
          //   //                 )));
          //     },
          //   );
          }),
    );
    //return _buildList(context);
      // color: Colors.white,
      // home: Scaffold(
      //   body: new Container(
      //     //now insert items
      //      //_buildList(context);
          
      //   ),
      // ),
    //);
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
  

  @override
  bool get wantKeepAlive => true;
}