import 'package:flutter/material.dart';

// import './Pages/homepage.dart';
import './Pages/page_container.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      color: Colors.white,
      home: new PageHolder(),
    );
  }
}