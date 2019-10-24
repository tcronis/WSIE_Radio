import 'package:flutter/material.dart';

// import './Pages/homepage.dart';
import './Pages/page_container.dart';
import 'package:splashscreen/splashscreen.dart';
import 'dart:async';

void main(){
  runApp(new MaterialApp(
    home: new MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => new _MyAppState();
}


class _MyAppState extends State<MyApp> {
  @override
  void initState(){
    super.initState();
    Timer(
      Duration(seconds: 5),
      () => Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (BuildContext context) => HomeScreen()))
    );
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
          child: Container(
            child: new Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                new Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Image.asset(
                      './assets/siue_logo.jpg',
                      fit: BoxFit.contain,
                      width: 200,
                      height: 200,
                    ),
                  ],
                ),
                new Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Image.asset(
                      './assets/WSIE_4COriginal.jpg',
                      fit: BoxFit.contain,
                      width: 200,
                      height: 200,
                    ),
                  ],
                ),
                new Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    CircularProgressIndicator(
                      valueColor: new AlwaysStoppedAnimation<Color>(SIUERed),
                    ),
                  ],
                ),
              ],
            )
          ),
      ),
    );
  }
}

class HomeScreen extends StatelessWidget{
    @override
    Widget build(BuildContext context) {
      return new MaterialApp(
        color: Colors.white,
        home: new SafeArea(
          top: true,
          bottom: true,
          child: new PageHolder(),
        )
        // new PageHolder(),
      );
    }
}


