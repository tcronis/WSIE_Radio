import 'package:flutter/material.dart';

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
          padding: new EdgeInsets.all(2.5),
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
        'assets/temp_cover.jpg',
        fit: BoxFit.contain,
      ),
      buttons,
      list,
//      scrollView,
    ],
  );
}

final scrollView = new SingleChildScrollView(
  scrollDirection: Axis.vertical,
  child: new Column(
    children: <Widget>[
      new Container(
        margin: const EdgeInsets.all(15.0),
        padding: const EdgeInsets.all(3.0),
        decoration: new BoxDecoration(
            border: new Border.all(color: Colors.black)
        ),
        child: new Text("View 1"),
      ),
      new Container(
        margin: const EdgeInsets.all(15.0),
        padding: const EdgeInsets.all(3.0),
        decoration: new BoxDecoration(
            border: new Border.all(color: Colors.black)
        ),
        child: new Text("View 2"),
      ),
      new Container(
        margin: const EdgeInsets.all(15.0),
        padding: const EdgeInsets.all(3.0),
        decoration: new BoxDecoration(
            border: new Border.all(color: Colors.black)
        ),
        child: new Text("View 3"),
      ),
      new Container(
        margin: const EdgeInsets.all(15.0),
        padding: const EdgeInsets.all(3.0),
        decoration: new BoxDecoration(
            border: new Border.all(color: Colors.black)
        ),
        child: new Text("View 4"),
      ),
      new Container(
        margin: const EdgeInsets.all(15.0),
        padding: const EdgeInsets.all(3.0),
        decoration: new BoxDecoration(
            border: new Border.all(color: Colors.black)
        ),
        child: new Text("View 5"),
      ),
      new Container(
        margin: const EdgeInsets.all(15.0),
        padding: const EdgeInsets.all(3.0),
        decoration: new BoxDecoration(
            border: new Border.all(color: Colors.black)
        ),
        child: new Text("View 6"),
      ),
    ],
  ),
);

final list = new Text(
  'material button',
  style: TextStyle(
    fontSize: 20.0, // insert your font size here
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