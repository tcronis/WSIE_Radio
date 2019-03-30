import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'dart:convert';
import 'dart:async';

Future<String> refreshData() async{
  //class varaibles
  String date;
  
  //constructor to get the new date
  // refreshData(String this.date);
  String url = "http://streaming.siue.edu:8001/whats_playing?view=json&request=play_data&t=20190327";

  var response = await http.get(Uri.encodeFull(url), headers: {"Accept" : "application/json"});
  debugPrint(response.body.toString());

}


Future<Post> fetchPost() async {
  final response =
      await http.get('http://streaming.siue.edu:8001/whats_playing?view=json');

  if (response.statusCode == 200) {
    // If the call to the server was successful, parse the JSON
    return Post.fromJson(json.decode(response.body));
  } else {
    // If that call was not successful, throw an error.
    throw Exception('Failed to load post');
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