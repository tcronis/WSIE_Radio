import 'package:flutter/material.dart';

// import './Pages/homepage.dart';
import './Pages/page_container.dart';
import 'package:splashscreen/splashscreen.dart';

// void main() => runApp(new MyApp());

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return new MaterialApp(
//       color: Colors.white,
//       home: new PageHolder(),
//     );
//   }
// }

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
  Widget build(BuildContext context) {
    return new SplashScreen(
      seconds: 15,
      navigateAfterSeconds: new AfterSplash(),
      image: Image.asset(
          'assets/siue_logo.jpg',
          fit: BoxFit.contain,
      ),
      backgroundColor: Colors.white,
      styleTextUnderTheLoader: new TextStyle(),
      photoSize: 100.0,
      onClick: ()=>print("Flutter Egypt"),
      loaderColor: Colors.red
    );
  }
}

class AfterSplash extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      color: Colors.white,
      home: new PageHolder(),
    );
  }
}


