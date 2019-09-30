import 'package:flutter/material.dart';

class EmailAndDonations extends StatefulWidget{
  @override
  State createState() => new __EmailAndDonations();
}
class __EmailAndDonations extends State<EmailAndDonations>{

  final emailController = TextEditingController();
  final messageController = TextEditingController();
  final nameController = TextEditingController();
  bool checkVal = false;

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    emailController.dispose();
    messageController.dispose();
    nameController.dispose();
    super.dispose();
  }

  void _sendEmailMessage() async {
    String email = emailController.text;
    String message = messageController.text;
    String name = nameController.text;
    String checkboxVal = checkVal.toString();

    print('Name: $name with Email: $email with Message: $message List?: $checkboxVal');
    //emailController.dispose();
    //messageController.dispose();
  }

    @override
  Widget build(BuildContext context){
    return MaterialApp(
      color: Colors.white,
      home: Scaffold(
        resizeToAvoidBottomPadding: false,
        body: new Container(
          child: new ListView.builder(
            itemCount: 1,
            itemBuilder: (BuildContext context, int index){
              return Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20.0, 0, 20.0, 15.0),
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
                        padding: const EdgeInsets.fromLTRB(20, 5, 10, 20),
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
                        padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                        child: SizedBox(
                          height: 75.0,
                          width: (MediaQuery.of(context).size.width)*0.71,
                          child: TextFormField(
                            controller: nameController,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: "Name",
                            ),
                            maxLines: 1,
                          ),
                        ),
                      ),
                    ],
                  ),

              Padding(
                padding: const EdgeInsets.fromLTRB(20, 5, 15, 10),
                child: SizedBox(
                  height: 80.0,
                  width: (MediaQuery.of(context).size.width)*0.87,
                  child: TextFormField(
                    controller: messageController,
                    //autofocus: true,
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
                        padding: const EdgeInsets.fromLTRB(20, 6, 10, 0),
                        child: Container(
                          child: new Text("Email: ",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 20.0
                            ),
                          ),
                          alignment: FractionalOffset(.06,.05),
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 9, 0, 0),
                        child: SizedBox(
                          height: 60.0,
                          width: (MediaQuery.of(context).size.width)*0.71,
                          child: TextFormField(
                            controller: emailController,
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

                  new Row(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.fromLTRB(5, 18, 0, 0),
                        child: Container(
                          child: new Checkbox(
                            value: checkVal,
                            onChanged: (bool value){
                              setState(() {
                                checkVal = value;
                              });
                            }
                          ),
                          alignment: FractionalOffset(.06,.05),
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
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
                        padding: const EdgeInsets.fromLTRB(12, 20, 0, 0),
                        child: RaisedButton(
                          onPressed: _sendEmailMessage,
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
                      height: 25,
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
                      height: 25,
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
                      height: 25,
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
              );
            },            
          ),
        ),
      ),
    );
  }
}