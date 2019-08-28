import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import './network_exception_widget.dart';
import 'package:http/http.dart' as http;

import 'dart:async';
import 'dart:convert';



const SIUERed = const Color(0xFFe41c24);
const platform = const MethodChannel('wsie.get.radio/stream');

class StreamPage extends StatefulWidget{

  @override
  State createState() => new __StreamPage();
}

class __StreamPage extends State<StreamPage> with AutomaticKeepAliveClientMixin<StreamPage>{

  DateTime selectedDate = DateTime.now();
  bool playStream = false;
  Timer _timer; 
  int timeInterval = 5;
  static bool initalCreation = false;

  Future <void> _toggleRadio() async{
    if(playStream == true){
      try{
        await platform.invokeMethod("playStream");
      } on PlatformException catch(e){
        print("Stream error: $e");
      }
    }else{
      try{
        await platform.invokeMethod("stopStream");
      }on PlatformException catch(e){
        print("Stream error: $e");
      }
    }
    setState(() {});
  }


  //Date selection, will open a calendar and will need to be edited to match the fit of the rest of the application
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
    // setState((){});
  }

  refresh(){
    setState((){});
  }
  
  //Refresh Time for the refreshing album data and so forth
  void refreshTimer(){
    if(playStream == true){
      _timer = Timer.periodic(Duration(seconds: 5), (Timer _timer) => setState(() {}));
    }
  }

  String playStopText = "Play";

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
                        child: new Text(playStopText),
                        color: SIUERed,
                        elevation: 4.0,
                        splashColor: Colors.white10,
                        onPressed: (){
                          //Two different blocks for playing and stopping the radio
                            //this will build the play data and grab the album artwork if at all possible
                          if(playStopText == "Play"){
                              __buildImage(context);
                              refreshTimer();
                              _toggleRadio();
                              playStopText = "Stop";
                          }
                            //this will stop the state radio and prepare it for the next time that it is pressed play
                          else{
                            playStream = false;
                            playStopText = "Play";
                            _toggleRadio();
                            refresh();
                          }
                        }
                    ),
                    // new RaisedButton(
                    //     child: const Text('Stop'),
                    //     color: SIUERed,
                    //     elevation: 4.0,
                    //     splashColor: Colors.white10,
                    //     onPressed: (){
                    //       playStream = false;
                    //       _toggleRadio();
                    //       refresh();
                    //       // setState((){});
                    //     }
                    // ),
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

 @override
  bool get wantKeepAlive => true;
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
            if(snapshot.data.length > 0){
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
                    return Image.asset(
                      '././assets/WSIE_4CBlackBackground.jpg',
                      fit: BoxFit.contain,
                      width: 200,
                      height: 200,
                    );
                  }
                },
              );
            }
            else{
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
      ),
    );
  }
}




  // API call to grab the album data, currently uses the iTune web API for building the album data
  Future<String> __getAlbumURL(Post data) async{
    String url = "http://itunes.apple.com/search?term=" + data.title +" " + data.artist;  //Base API url with the addition of the Current artist and title of the song playing
    final response = await http.get(Uri.encodeFull(url), headers: {"Accept" : "application/json"}); //encoing of the response
    if(response.statusCode == 200){
      final jsonResponse = json.decode(response.body);  //decoding the JSON to an array object
      if(jsonResponse['resultCount'] > 0){
        int numResults = int.parse(jsonResponse['resultCount'].toString()); //grabving the number of object in the array
        int best = -1;
        int location = -1;
        //if the number of results is greater then one, then it will iterate through the results to try and find the best fitting album artwork
          //based on how closely the artist's name and song name matches the info pulled from the IceCast stream server ran by SIUE
        if(numResults > 0){
          for(int i=0; i < numResults; i++){
            int count = -1;  
            if(data.artist.toUpperCase() == jsonResponse['results'][i]['artistName'].toString().toUpperCase())
              count++;
            if(data.album.toLowerCase() == jsonResponse['results'][i]['trackName'].toString().toUpperCase())
              count++;
            //if the track name and artist name both match and it is higher or equal to the best count (which keeps track of the best option) then it will become the best option
            if(count >= best){
              best = count; //setting as the new best
              location = i; //setting the location of the new best in the array
            }
          }
          //if sometype of matching artist name or track name was found then it will store it will display it's url
          if(location != -1){
            //These line will alter the size of the image from the iTune API, it will alter the meta tags to give a correctly fitting picture size
            String resultURL = jsonResponse['results'][location]['artworkUrl100'].toString();
            int pos = resultURL.indexOf('source') + 7;
            String finalUrl = resultURL.substring(0, pos) + "200x200.jpg";
            return finalUrl;
          }
          //if there wasn't a mathcing URL found, then it will just re-display the WSIE logo in the background instead of showing the wrong album artwork
          else
            return null;

        }
        else
          return null;
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
          if(snapshot.data.length > 0){
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
          }else{
            return networkError();
          }

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

  try{
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
  }catch(e){
    print("exception: $e");
    List<Post> temp = new List<Post>();
    return temp;
  }
  // print(temp);
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
