import 'package:flutter/material.dart';

Widget networkError(){
  return new Container(
    child: new Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          new Text("A network error has occurred: "),
          new Icon(Icons.network_locked),
        ],
      ),
    );
}
