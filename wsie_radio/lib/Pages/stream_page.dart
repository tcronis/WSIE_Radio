import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import './network_exception_widget.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
const SIUERed = const Color(0xFFe41c24);
const platform = const MethodChannel('wsie.get.radio/stream');
Post cachedPost = null;

class StreamPage extends StatefulWidget{
  @override
  State createState() => new __StreamPage();
}


class __StreamPage extends State<StreamPage> with AutomaticKeepAliveClientMixin<StreamPage>{
             
  var formatter = new DateFormat("EEEE, MMMM, d" );     //formatter for displaying the current day/date of the song data being pulled
  DateTime selectedDate = DateTime.now();               //var that stores the date selected by the user for displaying the song data being pulled from the ICECAST sever
  bool playStream = false;                              //var used to prevent user spam of the play/stop button, it stalls the button so that it wont spam
  Timer _timer;                                         //timer used in to time when to try and grab more album data when current streamin the radio              
  
  
  Future <void> _toggleRadio() async{
    //checking to see if the radio is streaming or if it needs to stop playing
    if(playStream == true){
      try{
        final bool result = await platform.invokeMethod("playStream");  //get the result of the radio running
      } on PlatformException catch(e){
        print("Stream error: $e");
      }
    }else{
      try{
        final bool result = await platform.invokeMethod("stopStream");  //recieve a response from the channel
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
    //checking to see if the user actually selected a new date, if not then nothing will refresh
    if (picked != null && picked != selectedDate)
      setState(() {
        refresh();
        selectedDate = picked;
      });
  }

  Future<Null> __buildImage(BuildContext conext) async{
    playStream = true;
    refresh();
    // setState((){});
  }

  //method that will refresht the widget/page on command
  refresh(){
    setState((){});
  }
  
  
  //Refresh Time for the refreshing album data and so forth
  void refreshTimer(){
    _timer = Timer.periodic(Duration(seconds: 10), (Timer _timer) => setState(() {}));
  }

  String playStopText = "Play Live Radio";
  @override
  Widget build(BuildContext context){
    return Theme(
      data: Theme.of(context).copyWith(
        primaryColor: SIUERed,
        accentColor: SIUERed,
        buttonTheme: ButtonThemeData(
          textTheme: ButtonTextTheme.accent
        ),
      ),
      child: Builder(
        builder: (context){
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
                              textColor: Colors.white,
                              elevation: 4.0,
                              splashColor: Colors.white10,
                              onPressed: (){
                                //Two different blocks for playing and stopping the radio
                                //this will build the play data and grFab the album artwork if at all possible
                                if(playStopText == "Play Live Radio"){
                                    __buildImage(context);
                                    refreshTimer();                 //time between refresh-cycles when streaming (will query the ICECAST sever for a new song, if found then new data is displayed)
                                    _toggleRadio();
                                    playStopText = "Stop Live Radio";
                                }
                                //this will stop the state radio and prepare it for the next time that it is pressed play
                                else{
                                  playStream = false;
                                  playStopText = "Play Live Radio";
                                  _toggleRadio();
                                  refresh();
                                }
                              }
                          ),
                          new RaisedButton(
                              child: const Text('Select Date'),
                              color: SIUERed,
                              textColor: Colors.white,
                              elevation: 4.0,
                              splashColor: Colors.white10,
                              onPressed: (){
                                _selectDate(context);
                              }
                          ),
                        ],
                      ),
                    ),
                    //widget that displays the current date selected to display the song data for
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                      child: new Text(
                        formatter.format(selectedDate).toString(),
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  __songContainer(selectedDate.toString()),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
    // return MaterialApp(
      
    // );
  }

 @override
  bool get wantKeepAlive => true;
}

//this will hold the WSIE logo or the album artwork if the user is current streaming
Widget __imageHold(bool play){
  //default show the wsie logo
  if(play == false){
    return Image.asset(
      '././assets/WSIE_Logo_Cutout.png',
      fit: BoxFit.contain,
      width: 200,
      height: 200,
    );
  }else{
    //checked the cached song to see if it is the same as the current song to prevent repeated calls for the same image
    return Container(
      height: 200.0,
      width: 200.0,
      child: FutureBuilder(
        //this will get the new post, and then attempt to grab the Image to display
        future: (getPost(DateTime.now().toString())),
        builder: (BuildContext context, AsyncSnapshot snapshot){
          if(snapshot.hasData){
            if(snapshot.data.length > 0){
              return FutureBuilder(
                future:__getAlbumURL(snapshot.data[0]),
                builder: (BuildContext context2, AsyncSnapshot snapshot2){
                  if(snapshot2.hasData){
                    if(snapshot2.data !=null){
                      return CachedNetworkImage(
                        placeholder: (context, url) => Image.asset(
                          '././assets/WSIE_Logo_Cutout.png'
                        ),
                        errorWidget: (context, url, error) => new Icon(Icons.error),
                        imageUrl: '${snapshot2.data}',
                        height: 200,
                        width: 200,
                      );
                    }else{
                      //this else had to be added because the response from iTune may actually be seen as containing data, but there actually just blank brackets
                      return Image.asset(
                        '././assets/WSIE_Logo_Cutout.png',
                        fit: BoxFit.contain,
                        width: 200,
                        height: 200,
                      );
                    }
                  }else{
                    //if the actual snapshot was emtpy then this will re-display the WSIE logo
                    return Image.asset(
                      '././assets/WSIE_Logo_Cutout.png',
                      fit: BoxFit.contain,
                      width: 200,
                      height: 200,
                    );
                  }
                },
              );
            }else{
              //if the snapshot data is length 0
              return Image.asset(
                '././assets/WSIE_Logo_Cutout.png',
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

//widget that will display all of the song data of the selected date
Widget __songContainer(String date){
  DateTime selectedDate = DateTime.parse(date);
  DateTime currentDate = DateTime.now();                    
  int different = currentDate.difference(selectedDate).inDays;  //difference between the selected date and the current date
  //checking to see if the selected date is after the current date, as in it hasn't occurred yet
  if(selectedDate.isAfter(currentDate)){
    return new Expanded(
      child: new ListView.builder(
        itemCount: 1,
        itemBuilder: (BuildContext context, int index){
          return Card(
            child:Padding(
              padding:const EdgeInsets.all(15.0),
              child: 
                Text(
                  "Error, you have selected a date greater than the current date",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                  textAlign: TextAlign.center,
                ),
            )
          );
        },
      )
    );
  } else if(different > 30){  //checking to see if the selected date is older than 30 days of the current date, if so we can't display that info
    return new Expanded(
      child: new ListView.builder(
        itemCount: 1,
        itemBuilder: (BuildContext context, int index){
          return Card(
            child:Padding(
              padding:const EdgeInsets.all(15.0),
              child: 
                Text(
                  "Error, you have selected a date older than 30 days",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                  textAlign: TextAlign.center,
                ),
            )
          );
        },
      )
    );
  } 
  else{
      return new Expanded(
          child: FutureBuilder(
            future: getPost(date),  //grabbing the date
            builder: (BuildContext context, AsyncSnapshot snapshot){
              //checking to make sure the response has data from the ICECAST sever, will double check to make sure the JSON is intrepreted as data even if blank with {}
              if(snapshot.hasData){
                if(snapshot.data.length > 0){
                  return new ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (BuildContext context, int index){
                      //each card is built with the song, artist name, and the time played
                      return Card(
                        child:Padding(
                          padding:const EdgeInsets.all(15.0),
                          child: 
                            Text("Title: ${snapshot.data[index].title}\nArtist: ${snapshot.data[index].artist}\nTime Played: ${snapshot.data[index].playtime}"),
                        )
                      );
                    },
                  );
                }else{
                  lostConnection = true;
                  return Center(
                    child: new CircularProgressIndicator(),
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


Future <List<Post>> getPost(String date) async{
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
}

//This is the class that will hold a post (or the data from the site) from the SIUE IceCast sever
class Post{
  final String album;
  final String artist;
  final String timestap;
  final String title;
  final String playtime;
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