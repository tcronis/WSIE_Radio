import 'package:flutter/material.dart';

class EmailAndDonations extends StatefulWidget{
  @override
  State createState() => new __EmailAndDonations();
}
class __EmailAndDonations extends State<EmailAndDonations>{
  
   @override
  Widget build(BuildContext context){
    return MaterialApp(
      color: Colors.white,
      home: Scaffold(
        body: new Container(
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  'Song Requests and More Information:',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 22.0),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(0),
                child: Container(
                  child: new Text("From: ",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20.0
                    ),
                  ),
                  alignment: FractionalOffset(.06,.05),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(90, 0, 30, 30),
                child: Container(
                  child: TextField(
                    decoration: const InputDecoration(
                      filled: true,
                      labelText: "Email"
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(0),
                child: SizedBox(
                  height: 80.0,
                  width: 350.0,
                  child: TextFormField(
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Message",
                    ),
                    maxLines: 10,
                  ),
                ),
              )
            ],
          )
        ),
      ),
    );
  }
}