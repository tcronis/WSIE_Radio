import 'package:flutter/material.dart';

Widget headerBar(){
  final SIUERed = const Color(0xFFe41c24);
  return new AppBar(
    title: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Text(
        //   'WSIE Radio',
        //   style: TextStyle(
        //     color: Colors.white,
        //   ),
        // ),
        // Image.asset(
        //   'assets/WSIE_4CBlackBackground.jpg',
        //   fit: BoxFit.contain,
        // ),
      ],
    ),
    backgroundColor: Colors.white,
  );
}