import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


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

  void _showDialog() async{
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Submission Confirmation"),
          content: new Text("Are you sure you want to send this message?"),
          actions: <Widget>[
            new FlatButton(
              child: new Text("Cancel"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            new FlatButton(
              child: new Text("Send"),
              onPressed: () {
                _sendEmailMessage();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<http.Response> _sendEmailMessage() async {

    String email = emailController.text;
    String message = messageController.text;
    String name = nameController.text;
    String checkboxVal = checkVal.toString();

    //found at the end of form url, change to change form
    String FORMID = '90974693484979';

    //found by inspecting textboxes on form page, must be changed if changing forms
    String INPUT1 = 'q3_fullName';
    String INPUT2 = 'q4_email';
    String INPUT3 = 'q5_commentsquestions';

    //92640823556158 - Bens test
    //92466756779984 - WSIE CLONE
    //90974693484979 - WSIE REAL

    String url = 'https://submit.jotformpro.com/submit/$FORMID/';

    //adds notice to message if mailing list checkbox is checked
    if( checkboxVal == 'true'){
      String check = "\n\n[Add to Mailing List]";
      message = message + check;
    }

    Map<String, String> _body = {
      "formID" : "$FORMID",
      "$INPUT1" : "$name",
      "$INPUT2" : "$email",
      "$INPUT3" : "$message",
      "website" : "",
      "simple_spc" : "$FORMID-$FORMID",
      "event_id" : ""
    };

    //Headers used in application, must use the /x-www-form-erlencoded
    Map<String,String> _headers = {
      "Content-Type": "application/x-www-form-urlencoded",
      "Accept": "application/json",
    };

    //Make POST Request
    final response = await http.post(url, headers: _headers,  body: _body);

    //printing response and clearing the text fields
    print(response.statusCode);
    setState(() {});
    emailController.clear();
    messageController.clear();
    nameController.clear();
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
                          onPressed: ()=> _showDialog(),
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

                ],
              );
            },            
          ),
        ),
      ),
    );
  }
}