import 'package:flutter/material.dart';

import 'date_event_card.dart';
import 'date_info.dart';


class Calendar extends StatefulWidget{
  @override
  State createState() => new __Calendar();
}

class __Calendar extends State<Calendar>{
  //final List<Date> dateEvents;
 //__Calendar(this.dateEvents);

  @override
  Widget build(BuildContext context){
    return _buildList(context);
      // color: Colors.white,
      // home: Scaffold(
      //   body: new Container(
      //     //now insert items
      //      //_buildList(context);
          
      //   ),
      // ),
    //);
  }

  ListView _buildList(context) {
    return ListView.builder(
      
      itemCount: 5, 
      itemBuilder: (context, int) {
        // DateCard for each date.
        return DateCard(dateEvents[int]);
      },
    );
  }
  
}