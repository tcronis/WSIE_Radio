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
                padding: const EdgeInsets.fromLTRB(20.0, 30.0, 20.0, 20.0),
                child: Text(
                  'Song Requests and More Information:',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 22.0),
                ),
              ),
              new Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 5, 15, 20),
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
                    padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                    child: SizedBox(
                      height: 75.0,
                      width: 300.0,
                      child: TextFormField(
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: "Email",
                        ),
                        maxLines: 1,
                      ),
                    ),
                  ),



                ],
              ),
          Padding(
            padding: const EdgeInsets.all(0),
            child: SizedBox(
              height: 80.0,
              width: 375.0,
              child: TextFormField(
                autofocus: true,
                onEditingComplete: deactivate,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Message",
                ),
                maxLines: 10,
              ),
            ),
          ),
              new Row(
                children: <Widget>[

                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 50, 0, 0),
                    child: Container(
                      child: new Checkbox(
                        value: true,
                      ),
                      alignment: FractionalOffset(.06,.05),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 50, 20, 0),
                    child: Container(
                      child: new Text("Register for WSIE Emailing List",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 15.5
                        ),
                      ),
                      alignment: FractionalOffset(.06,.05),
                    ),
                  ),


                  Padding(
                    padding: const EdgeInsets.fromLTRB(4, 50, 0, 0),
                    child: RaisedButton(
                      child: Text(
                        'Send',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 18.0
                        ),
                      ),
                    ),
                  ),

                ],
              ),

              Padding(
                padding: const EdgeInsets.fromLTRB(20.0, 12, 20.0, 0),
                child: Text(
                  'Underwriters:',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 22.0),
                ),
              ),

              Divider(),

              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                child: new SizedBox(
                  height: 20,
                  width:  375,
                  child: Text(
                    'Logo - Underwriter 1: Link to Website/Info',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 18.0),
                  ),
                ),
              ),
              Divider(),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                child: new SizedBox(
                  height: 20,
                  width:  375,
                  child: Text(
                    'Logo - Underwriter 2: Link to Website/Info',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 18.0),
                  ),
                ),
              ),

              Divider(),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                child: new SizedBox(
                  height: 20,
                  width:  375,
                  child: Text(
                    'Logo - Underwriter 3: Link to Website/Info',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 18.0),
                  ),
                ),
              ),
              Divider(),


              Padding(
                padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                child: ButtonTheme(
                  buttonColor: Colors.grey,
                  minWidth: 200.0,
                  height: 40.0,
                  child: RaisedButton(
                    onPressed: () {},
                    child: Text(
                      'Donations',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 20.0
                      ),
                    ),
                  ),
                ),
              ),

            ],
          )
        ),
      ),
    );
  }
}