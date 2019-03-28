import 'package:flutter/material.dart';
import '../Custom_Methods/song_info.dart';

const SIUERed = const Color(0xFFe41c24);
class StreamPage extends StatefulWidget{
  @override
  State createState() => new __StreamPage();
}

class __StreamPage extends State<StreamPage>{

  @override
  Widget build(BuildContext context){
    return MaterialApp(
      color: Colors.white,
      home: Scaffold(
        body: new Container(
          // padding: new EdgeInsets.all(2.5),
          child: __center(),
        ),
      ),
    );
  }

}

Widget __center(){
  return new Column(
    mainAxisSize: MainAxisSize.max,
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: <Widget>[
      Image.asset(
        '././assets/temp_cover.jpg',
        fit: BoxFit.contain,
        width: 200,
        height: 200,
      ),
      buttons,
     scrollView,
    ],
  );
}

final scrollView = new Expanded(
  child: ListView.builder(
    itemBuilder: (context, position) {
      return Card(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text("This will be a value " + position.toString(), style: TextStyle(fontSize: 22.0),),
        ),
      );
    },
  ),
);


final buttons = new Container(
  child: new Row(
    mainAxisSize: MainAxisSize.max,
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: <Widget>[
      new RaisedButton(
          child: const Text('Play'),
          color: SIUERed,
          elevation: 4.0,
          splashColor: Colors.white10,
          onPressed: (){
            refreshData();
          }
      ),
      new RaisedButton(
          child: const Text('Pause'),
          color: SIUERed,
          elevation: 4.0,
          splashColor: Colors.white10,
          onPressed: (){
          }
      ),
    ],
  ),
);