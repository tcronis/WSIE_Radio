import 'package:flutter/material.dart';

class FacebookFeed extends StatefulWidget {
  @override
  State createState() => new __FacebookFeed();
}

class __FacebookFeed extends State<FacebookFeed> {
  @override
  Widget build(BuildContext context) {
    return ListView(children: <Widget>[
      Card(
          color: Colors.white,
          elevation: 10.0,
          child: Container(
              height: 100.0,
              child: Row(children: <Widget>[
                Expanded(
                  child: Text('Sample post 1'),
                )
              ]))),
      Card(
          color: Colors.white,
          elevation: 10.0,
          child: Container(
              height: 100.0,
              child: Row(children: <Widget>[
                Expanded(
                  child: Text('Sample post 2'),
                )
              ]))),
      Card(
          color: Colors.white,
          elevation: 10.0,
          child: Container(
              height: 100.0,
              child: Row(children: <Widget>[
                Expanded(
                  child: Text('Sample post 3'),
                )
              ]))),
      Card(
          color: Colors.white,
          elevation: 10.0,
          child: Container(
              height: 100.0,
              child: Row(children: <Widget>[
                Expanded(
                  child: Text('Sample post 4'),
                )
              ]))),
      Card(
          color: Colors.white,
          elevation: 10.0,
          child: Container(
              height: 100.0,
              child: Row(children: <Widget>[
                Expanded(
                  child: Text('Sample post 5'),
                )
              ]))),
      Card(
          color: Colors.white,
          elevation: 10.0,
          child: Container(
              height: 100.0,
              child: Row(children: <Widget>[
                Expanded(
                  child: Text('Sample post 6'),
                )
              ]))),
      Card(
          color: Colors.white,
          elevation: 10.0,
          child: Container(
              height: 100.0,
              child: Row(children: <Widget>[
                Expanded(
                  child: Text('Sample post 7'),
                )
              ])))
    ]);
  }
}
