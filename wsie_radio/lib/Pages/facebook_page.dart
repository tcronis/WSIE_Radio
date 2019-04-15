import 'package:flutter/material.dart';

class FacebookFeed extends StatefulWidget {
  @override
  State createState() => new __FacebookFeed();
}

class __FacebookFeed extends State<FacebookFeed> {
  @override
  Widget build(BuildContext context) {
    return ListView(children: <Widget>[

      Padding(
        padding: const EdgeInsets.fromLTRB(20, 30, 20, 10),
        child: Text(
          'News Feed',
          textAlign: TextAlign.center,
          style: TextStyle(
              color: Colors.black,
              fontSize: 24.0),
        ),
      ),

      Padding(
        padding: const EdgeInsets.fromLTRB(0, 15, 0, 10),
        child: Text(
          'Today',
          textAlign: TextAlign.center,
          style: TextStyle(
              color: Colors.black,
              fontSize: 20.0),
        ),
      ),

      Card(
          color: Colors.white,
          elevation: 10.0,
          child: Container(
              height: 80.0,
              child: Row(children: <Widget>[

                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: Icon(
                    Icons.image,
                    size: 70.0,
                    color: Colors.grey,
                  ),
                ),

                Expanded(
                  child: Text('Sample post 1 - Lorem ipsum dolor sit amet, consectetur adipiscing elit...',
                      style: TextStyle(
                      color: Colors.black,
                      fontSize: 16.0
                  ),),
                )
              ]))),

      Padding(
        padding: const EdgeInsets.fromLTRB(0, 15, 0, 10),
        child: Text(
          'This Week',
          textAlign: TextAlign.center,
          style: TextStyle(
              color: Colors.black,
              fontSize: 20.0),
        ),
      ),

      Card(
          color: Colors.white,
          elevation: 10.0,
          child: Container(
              height: 80.0,
              child: Row(children: <Widget>[

                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: Icon(
                    Icons.image,
                    size: 70.0,
                    color: Colors.grey,
                  ),
                ),

                Expanded(
                  child: Text('Sample post 2 - Lorem ipsum dolor sit amet, consectetur adipiscing elit...',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 16.0
                    ),),
                )
              ]))),


      Card(
          color: Colors.white,
          elevation: 10.0,
          child: Container(
              height: 80.0,
              child: Row(children: <Widget>[

                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: Icon(
                    Icons.image,
                    size: 70.0,
                    color: Colors.grey,
                  ),
                ),

                Expanded(
                  child: Text('Sample post 3 - Lorem ipsum dolor sit amet, consectetur adipiscing elit...',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 16.0
                    ),),
                )
              ]))),

      Padding(
        padding: const EdgeInsets.fromLTRB(0, 15, 0, 10),
        child: Text(
          'This Month',
          textAlign: TextAlign.center,
          style: TextStyle(
              color: Colors.black,
              fontSize: 20.0),
        ),
      ),

      Card(
          color: Colors.white,
          elevation: 10.0,
          child: Container(
              height: 80.0,
              child: Row(children: <Widget>[

                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: Icon(
                    Icons.image,
                    size: 70.0,
                    color: Colors.grey,
                  ),
                ),

                Expanded(
                  child: Text('Sample post 4 - Lorem ipsum dolor sit amet, consectetur adipiscing elit...',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 16.0
                    ),),
                )
              ]))),
      Card(
          color: Colors.white,
          elevation: 10.0,
          child: Container(
              height: 80.0,
              child: Row(children: <Widget>[

                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: Icon(
                    Icons.image,
                    size: 70.0,
                    color: Colors.grey,
                  ),
                ),

                Expanded(
                  child: Text('Sample post 5 - Lorem ipsum dolor sit amet, consectetur adipiscing elit...',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 16.0
                    ),),
                )
              ]))),
      Card(
          color: Colors.white,
          elevation: 10.0,
          child: Container(
              height: 80.0,
              child: Row(children: <Widget>[

                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: Icon(
                    Icons.image,
                    size: 70.0,
                    color: Colors.grey,
                  ),
                ),

                Expanded(
                  child: Text('Sample post 6 - Lorem ipsum dolor sit amet, consectetur adipiscing elit...',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 16.0
                    ),),
                )
              ]))),
      Card(
          color: Colors.white,
          elevation: 10.0,
          child: Container(
              height: 80.0,
              child: Row(children: <Widget>[

                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: Icon(
                    Icons.image,
                    size: 70.0,
                    color: Colors.grey,
                  ),
                ),

                Expanded(
                  child: Text('Sample post 7 - Lorem ipsum dolor sit amet, consectetur adipiscing elit...',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 16.0
                    ),),
                )
              ]))),
    ]);
  }
}
