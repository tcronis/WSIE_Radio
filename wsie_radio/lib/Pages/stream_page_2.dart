import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
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
  static Post cachedPost = null;                        //variable used to cach the most current song being played
  static Post cachedPost2 = null;                       //variable used in the _timer function that will check to see if the cachedPost has changed, if so then it will refresh the app
  static DateTime startTime = null;                     //keeps track of time duration between advertisement showing
  static DateTime runTime = null;                       //keeps track of the length that the current advertisement is showing for and will reset each time
  static bool showAdvert = false;                       //bool used to signifiy if the __imageHolder should show the advert. or not
  static bool counting = false;                         //bool used to make sure it doens't keep entering the loop to start the advert. 
  static String cachediTunesURL = "";                   //cachedString value of iTunes URLs
  
  /* 
    * Main Functionality - used to toggle the live stream of the radio via communication channels
      - Will call either the iOS or Android code
  */
  Future <void> _toggleRadio() async{
    //A check to see if the user is currently streaming, if not then it starts, other wise it stops
    if(playStream == true){
      try{
        await platform.invokeMethod("playStream");  //get the result of the radio running
      } on PlatformException catch(e){
        print("Stream error: $e");
      }
    }else{
      try{
        await platform.invokeMethod("stopStream");  //recieve a response from the channel
      }on PlatformException catch(e){
        print("Stream error: $e");
      }
    }
  }

  /*
    * Main Functionality - a calendar that will open to allow a user to select a different date to view previous songs
      - Will grab a new date that the user selects and update the _songContainer via a refresh of the app
  */
  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    //Checking to make sure that the user actually selected a date, otherwise nothing will change in runtime
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
  }

  /*
    * Main Functionality - a quick method to refresh the app (both backend and front end)
  */
  refresh(){
    setState((){});
  }
  


    /*
    * Main Functionality - this will assign functions to the _timer so that the __imageHolder and the __songContainer will be updated in due time
      - This will call to update __imageHolder when streaming the radio, it will call every 5 seconds
      - 
  */
  void refreshTimer(){
    _timer = Timer.periodic(Duration(seconds: 10), (Timer _timer){
      __imageHolder(playStream);  //call to update the __imageHolder and the cachedPost object         

      //check to see if the runtime timer has reached the 20 second show time period
      if(runTime != null && DateTime.now().difference(runTime).inSeconds >= 20){
        showAdvert = false;
        startTime = DateTime.now();
        runTime = null;
        counting = false;
        refresh();
      }

      //if a minute has passed then it will tell the __imageHolder widget to show the advertisement
      if(DateTime.now().difference(startTime).inMinutes >= 1 && counting == false){
        showAdvert = true;
        runTime = DateTime.now();
        counting = true;
        refresh();
      }

      //Caching a post after the first 10 seconds to be used later to see if the cachedPost has changed
      if(cachedPost != null && cachedPost2 == null){
        cachedPost2 = cachedPost;
      }

      //If the cachedPost has changed, then it will refresh the application
      if(cachedPost != null && cachedPost2 != null && cachedPost2 != cachedPost){
        __songContainer(selectedDate.toString()); //re-create the song container with the new song(s)
        cachedPost2 = cachedPost;                 //store the new cachedPost in cachedPost2
        refresh();                                //refresh the application
      }
    });
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
                child: new Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    __imageHolder(playStream),
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
                                    playStream = true;
                                    refreshTimer();                 //time between refresh-cycles when streaming (will query the ICECAST sever for a new song, if found then new data is displayed)
                                    _toggleRadio();
                                    startTime = DateTime.now();
                                    playStopText = "Stop Live Radio";
                                    refresh();
                                }
                                //this will stop the state radio and prepare it for the next time that it is pressed play
                                else{
                                  playStream = false;
                                  playStopText = "Play Live Radio";   //chaning the text that the button shows for play/stop
                                  _toggleRadio();                     //turning off the radio

                                  //Resetting all of play time objects that are use to refresh the app and redisplay items when streaming
                                  _timer.cancel();                    
                                  cachediTunesURL = "";
                                  cachedPost = null;
                                  cachedPost2 = null;
                                  showAdvert = false;
                                  counting = false;
                                  startTime = null;
                                  runTime = null;
                                  refresh();                            //refreshing the choices
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


  RefreshController _refreshController = RefreshController(initialRefresh: false);

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
                    style: TextStyle(fontWeight: FontWeight.bold),
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
                    style: TextStyle(fontWeight: FontWeight.bold),
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
                    return new SmartRefresher(
                      enablePullDown: true,
                      enablePullUp: true,
                      controller: _refreshController,
                      onRefresh: () async{
                        await Future.delayed(Duration(seconds: 1));
                        _refreshController.refreshCompleted();
                        refresh();
                      },
                      onLoading: () async{
                        await Future.delayed(Duration(seconds: 1));
                        _refreshController.loadComplete();
                      },
                      child: new ListView.builder(
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
                      ),
                    );
                  }else{
                    return new SmartRefresher(
                      enablePullDown: true,
                      enablePullUp: true,
                      controller: _refreshController,
                      onRefresh: () async{
                        await Future.delayed(Duration(seconds: 1));
                        _refreshController.refreshCompleted();
                        refresh();
                      },
                      onLoading: () async{
                        await Future.delayed(Duration(seconds: 1));
                        _refreshController.loadComplete();
                      },
                      child: ListView(
                        children: <Widget>[
                          Card(
                            child: networkError(),
                          )
                        ],
                      )
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


 @override
  bool get wantKeepAlive => true;


  Widget __imageHolder(bool play){
    // print("LINE - 311 : building the __imageHolder widget!" + DateTime.now().toString());
    // print("play - " + play.toString());
    if(!play){
      // if(_timer != null)
      //   // _timer.cancel();
      return Image.asset(
        '././assets/WSIE_Logo_Cutout.png',
        fit: BoxFit.contain,
        width: 200,
        height: 200,
      );
    }else if(play && !showAdvert){
      return Container(
        width: 200,
        height: 200,
        child: FutureBuilder(
          future: (__getAlbumURL()),
          builder: (BuildContext context, AsyncSnapshot snapshot){
            // print("snapshot data - " + snapshot.data.toString());
            //this will check to make sure that the returned data isn't a repeat of previous data (itunes URL) and actually contains data before showing anything
            if(snapshot.connectionState == ConnectionState.done && snapshot.data != null && snapshot.data.toString() !=  "no matching url"){
              // print("Re-creating the CachedNetowrkImage");
              // print(snapshot.data.toString());
              return CachedNetworkImage(
                  placeholder: (context, url) => Image.asset(
                    '././assets/WSIE_Logo_Cutout.png',
                    height: 200,
                    width: 200,
                    fit: BoxFit.contain,
                  ),
                  errorWidget: (context, url, error) => new Icon(Icons.error),
                  imageUrl: '${snapshot.data}',
                  height: 200,
                  width: 200,
                );
            }
            //if the connction isn't done, but the snapshot has an old URL (usually called when the user forces a refresh while streaming)
            else if(snapshot.connectionState != ConnectionState.done && snapshot.data != null && snapshot.data.toString() != "no matching url"){
              // print("Re-creating the cachedNetworkImage, but using an old URL instead");
              return CachedNetworkImage(
                placeholder: (context, url) => Image.asset(
                  '././assets/WSIE_Logo_Cutout.png',
                  height: 200,
                  width: 200,
                  fit: BoxFit.contain,
                ),
                errorWidget: (context, url, error) => new Icon(Icons.error),
                imageUrl: '${snapshot.data}',
                height: 200,
                width: 200,
              );
            }
            //the snapshot either doesn't have data from the itunes API call
            else{
              return Image.asset(
                  '././assets/WSIE_Logo_Cutout.png',
                  fit: BoxFit.contain,
                  width: 200,
                  height: 200,
                ); 
            }
          },
        ),
      );
    }else if(play && showAdvert){
      return Container(
        width: 200,
        height: 200,
        child: new Text(
          'advert show',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: SIUERed,
          ),
        ),
      );
    }


  }


  // API call to grab the album data, currently uses the iTune web API for building the album data
  Future<String> __getAlbumURL() async{
    final currentStreamData = await getPost(DateTime.now().toString());
    // print("cachedPost - " + cachedPost.album.toString());
    // print("currentStreamData - " + currentStreamData[0].album.toString());
    if(currentStreamData.length > 0 && (cachedPost == null || (cachedPost != null && cachedPost != currentStreamData[0]))){
      // print("new song being played!" + currentStreamData[0].artist);
      cachedPost = currentStreamData[0];
      Post data = currentStreamData[0];
      String url = "http://itunes.apple.com/search?term=" + data.title +" " + data.artist;  //Base API url with the addition of the Current artist and title of the song playing
      final response = await http.get(Uri.encodeFull(url), headers: {"Accept" : "application/json"}); //encoing of the response
      if(response.statusCode == 200 && response.body.toString().length > 0){
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
              // print("returning - " + finalUrl);
              cachediTunesURL = finalUrl;
              return finalUrl;
            }
            //if there wasn't a mathcing URL found, then it will just re-display the WSIE logo in the background instead of showing the wrong album artwork
            else{
              // print("returning null - 1");
              return "no matching url";
            }
              // return null;

          }
          else{
            // print("returning null - 2");
            return cachediTunesURL;
          }
            // return null;
        }
      }
      else {
        print("response code of bad http call: $response.statusCode");
      }

    } else {
      // print("returning null - 3");
      return cachediTunesURL;
    }
  }

  Future <List<Post>> getPost(String date) async{
    String temp = date.substring(0,4);
    temp += date.substring(5, 7);
    temp += date.substring(8,10);
    print("calling to get another post: " + DateTime.now().toString());

    try{
      String url = "http://streaming.siue.edu:8001/whats_playing?view=json&request=play_data&t=" + temp;
      final response = await http.get(Uri.encodeFull(url), headers: {"Accept" : "application/json"});
      if(response.statusCode == 200 && response.body.toString().length > 0){
        final jsonResponse = json.decode(response.body);
        List<Post> data = new List<Post>();
        for(int i=0; i < jsonResponse.length; i++){
          data.add(new Post.fromJson(jsonResponse[i]));
        }
        return data;
      }
      else {
        print("response code of bad http call: $response.statusCode");
        List<Post> nullReturn = new List<Post>();
        return nullReturn;
      }
    }catch(e){
      print("exception: $e");
      List<Post> temp = new List<Post>();
      return temp;
    }
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

  @override
 bool operator ==(Object other) =>
  identical(this, other) ||
  other is Post &&
  runtimeType == other.runtimeType &&
  album == other.album &&
  artist == other.artist &&
  timestap == other.timestap &&
  title == other.title &&
  playtime == other.playtime;
  
}