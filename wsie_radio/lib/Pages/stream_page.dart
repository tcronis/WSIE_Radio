import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:http/http.dart' as http;

import 'dart:async' show Future;
import 'dart:convert';



const SIUERed = const Color(0xFFe41c24);
class StreamPage extends StatefulWidget{
  @override
  State createState() => new __StreamPage();
}

class __StreamPage extends State<StreamPage>{

  DateTime selectedDate = DateTime.now();
  bool playStream = false;


  Future<Null> _selectDate(BuildContext context) async {
    
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate)
      setState(() {
        // print(picked);
        refresh();
        selectedDate = picked;
      });
  }

  Future<Null> __buildImage(BuildContext conext) async{
    playStream = true;
    refresh();
  }

  refresh(){
    setState((){});
  }
  

  @override
  Widget build(BuildContext context){
    return MaterialApp(
      color: Colors.white,
      home: Scaffold(
        body: new Container(
          // padding: new EdgeInsets.all(2.5),
          // child: __center(),
          child: new Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              __imageHold(playStream),
              new Container(
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
                          //make the call for the alumb art to update
                            __buildImage(context);
                          //run code to start stream
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
                    new RaisedButton(
                        child: const Text('Select Date'),
                        color: SIUERed,
                        elevation: 4.0,
                        splashColor: Colors.white10,
                        onPressed: (){
                          _selectDate(context);
                        }
                    ),
                  ],
                ),
              ),

            //song container 
            __songContainer(selectedDate.toString()),

            ],
          ),
        ),
      ),
    );
  }

}

//write it to refresh after a certian time to que for new album art
Widget __imageHold(bool play){
  if(play == false){
    return Image.asset(
      '././assets/WSIE_4CBlackBackground.jpg',
      fit: BoxFit.contain,
      width: 200,
      height: 200,
    );
  }else{
    // get the most current song played according to the WSIE radio data
    // Future <Post> data =__getCurrentSong();
    return Container(
      height: 200.0,
      width: 200.0,
      child: FutureBuilder(
        future: (getPost(DateTime.now().toString())),
        builder: (BuildContext context, AsyncSnapshot snapshot){
          if(snapshot.hasData){
            return FutureBuilder(
              future:__getAlbumURL(snapshot.data[0]),
              builder: (BuildContext context2, AsyncSnapshot snapshot2){
                if(snapshot2.hasData){
                  if(snapshot2.data !=null){
                    return Image.network(
                      '${snapshot2.data}',
                      height: 200,
                      width: 200,
                    );
                  }else{
                    return Image.asset(
                      '././assets/WSIE_4CBlackBackground.jpg',
                      fit: BoxFit.contain,
                      width: 200,
                      height: 200,
                    );
                  }
                  
                }else{
                  return Center(
                    child: new CircularProgressIndicator(),
                  );
                }
              },
            );
          }else{
            return Center(
            child: new CircularProgressIndicator(),
          );
          }
        },
      ),
    );
  }
}

  Future<String> __getAlbumURL(Post data) async{

    String url = "http://itunes.apple.com/search?term=" + data.title +" " + data.artist;
    // String url = "http://itunes.apple.com/search?term=Love On Top Doc Powell";
    final response = await http.get(Uri.encodeFull(url), headers: {"Accept" : "application/json"});
    if(response.statusCode == 200){
      final jsonResponse = json.decode(response.body);
      if(jsonResponse['resultCount'] > 0){
        print(jsonResponse['results'][0]['artworkUrl100']);
        return jsonResponse['results'][0]['artworkUrl100'].toString();
      }
    }
    else {
      print("response code of bad http call: $response.statusCode");
    }
  }


Widget __songContainer(String date){
  return new Expanded(
    child: FutureBuilder(
      future: getPost(date),
      builder: (BuildContext context, AsyncSnapshot snapshot){
        if(snapshot.hasData){
          return new ListView.builder(
            itemCount: snapshot.data.length,
            itemBuilder: (BuildContext context, int index){
              return Card(
                child:Padding(
                  padding:const EdgeInsets.all(15.0),
                  child: 
                    Text("Title: ${snapshot.data[index].title}\n Artist: ${snapshot.data[index].artist}\n Time Played: ${snapshot.data[index].playtime}"),
                )
              );
            },
          );
        } else{
          return Center(
            child: new CircularProgressIndicator(),
          );
        }
      },
    ),

  );
}


Future <List<Post>> getPost(String date) async{
  // print(date);
  String temp = date.substring(0,4);
  temp += date.substring(5, 7);
  temp += date.substring(8,10);

  
  // print(temp);
  String url = "http://streaming.siue.edu:8001/whats_playing?view=json&request=play_data&t=" + temp;
  final response = await http.get(Uri.encodeFull(url), headers: {"Accept" : "application/json"});
  if(response.statusCode == 200){
    final jsonResponse = json.decode(response.body);
    List<Post> data = new List<Post>();
    for(int i=0; i < jsonResponse.length; i++){
      data.add(new Post.fromJson(jsonResponse[i]));
    }
    return data;
  }
  else {
    print("response code of bad http call: $response.statusCode");
  }

}

class Post{
  final String album;
  final String artist;
  final String timestap;
  final String title;
  final String playtime;
  // final String appleLink;


  //constructor
  Post({this.album, this.artist, this.timestap, this.title, this.playtime});

  factory Post.fromJson(Map<String, dynamic> json){
    return Post(
      album: json['album'],
      artist: json['artist'],
      timestap: json['timestamp'],
      title: json['title'],
      playtime: json['playtime'],
      // appleLink: json['links:0:value'],
    );
  }
  
}

// final buttons = new Container(
//   child: new Row(
//     mainAxisSize: MainAxisSize.max,
//     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//     children: <Widget>[
//       new RaisedButton(
//           child: const Text('Play'),
//           color: SIUERed,
//           elevation: 4.0,
//           splashColor: Colors.white10,
//           onPressed: (){
//             getPost();
//           }
//       ),
//       new RaisedButton(
//           child: const Text('Pause'),
//           color: SIUERed,
//           elevation: 4.0,
//           splashColor: Colors.white10,
//           onPressed: (){
//           }
//       ),
//        new RaisedButton(
//           child: const Text('Select Date'),
//           color: SIUERed,
//           elevation: 4.0,
//           splashColor: Colors.white10,
//           onPressed: (){
//             // _selectDate(context);

//           }
//       ),
//     ],
//   ),
// );


// Future<Null> _selectDate(BuildContext context) async{
//   DateTime _date = new DateTime.now();

//   final DateTime picked = await showDatePicker(
//     context: context,
//     initialDate: (_date),
//     firstDate:  new DateTime(2016),
//     lastDate: new DateTime(2019),
//   );

//   if(picked != null ){
//     print("Date Selected: ${picked}");
//   }
// }