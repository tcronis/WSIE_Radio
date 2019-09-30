// import 'package:flutter/material.dart';

// import 'date_info.dart';




// class DateCard extends StatefulWidget {
//   final DateEvent date;

//   DateCard(this.date);

//   @override
//   _DateCardState createState() => _DateCardState(date);
// }

// class _DateCardState extends State<DateCard> {
//    DateEvent date;


//     // user defined function
//   void _showDialog() {
//     // flutter defined function
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         // return object of type Dialog
//         return AlertDialog(
//           title: new Text("Event Name"),
//           content: new Text("More Info on this event coming soon"),
//           actions: <Widget>[
//             // usually buttons at the bottom of the dialog
//             new FlatButton(
//               child: new Text("Visit Site"),
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//             ),
//             new FlatButton(
//               child: new Text("Close"),
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//             ),
//           ],
//         );
//       },
//     );
//   }
//    _DateCardState(this.date);

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//     padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
//     child: Container(
//       height: 115.0,
//       decoration: new BoxDecoration(boxShadow: [
//           BoxShadow(
//             color: Colors.black26,
//             blurRadius: 20.0, // has the effect of softening the shadow
//             //spreadRadius: 1.0, // has the effect of extending the shadow
            
//           )
//         ],),
//       child: Stack(
//         children: <Widget>[
//           Positioned(
//             left: 50.0,
//             child: dateCard,
//           ),
          
//         ],
//       ),
//     ),
//   );
//   }
//   Widget get dateCard {
  
//   return Container(
//     width: 290.0,
//     height: 115.0,
//     child: Card(
//       child: new InkWell(
//         onTap: () {
//       //print("tapped");
//       _showDialog();
//       // return Container(
//       //   width: 290.0,
//       //   height: 115.0,
//       //   child: Card(

//       //   ),
//       // );
//       },
//       child: Padding(
        
//         padding: const EdgeInsets.only(
//           top: 8.0,
//           bottom: 8.0,
//           left: 64.0,
//         ),
        
//         child: Column(
          
//           crossAxisAlignment: CrossAxisAlignment.start,
//           mainAxisAlignment: MainAxisAlignment.spaceAround,
//           children: <Widget>[
//             Text(widget.date.day,
//                 style: Theme.of(context).textTheme.headline),
//             Text(widget.date.event,
//                 style: Theme.of(context).textTheme.subhead),
//             Row(
//               children: <Widget>[
//                 Icon(
//                   Icons.star,
//                 ),
//               ],
//             )
//           ],
//         ),
//       ),
//       )
      
//     ),
//   );
// }
// }
