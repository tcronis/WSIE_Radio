import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
const card_padding = 15.0;
const card_text_size = 15.0;
const heading_text_size = 20.0;
const body_text_size = 18.0;
const SIUERed = const Color(0xFFe41c24);

class EmailAndFacebookPage extends StatefulWidget{
  @override
  State createState() => new __EmailAndFacebookPage();
}
class __EmailAndFacebookPage extends State<EmailAndFacebookPage> with AutomaticKeepAliveClientMixin<EmailAndFacebookPage>{
  //want to keep the page of the application alive, not matter if the user goes to another page
  @override
  bool get wantKeepAlive => true;

  
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

   _facebookLaunch() async {
    
      const url = 'https://m.facebook.com/WSIE887theSound/';
            
            if (await canLaunch(url)) {
              await launch(url);
            } else {
              throw '$url could not be reached';
            }
            
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
        child: new GestureDetector(
          onTap: (){
            FocusScope.of(context).requestFocus(new FocusNode());
          },
          child: ListView(
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            children: <Widget>[
                Padding(
                  padding: const EdgeInsets.fromLTRB(5.0, 20.0, 5.0, 5.0),
                  child: Text(
                    'Song Requests and More Information:',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: heading_text_size),
                  ),
                ),
                new Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
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

                new Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                      child: SizedBox(
                        height: 75.0,
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
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                      child: SizedBox(
                        height: 125.0,
                        width: (MediaQuery.of(context).size.width)*0.71,
                        child: TextFormField(
                          controller: messageController,
                          //autofocus: true,
                          onEditingComplete: deactivate,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: "Message",
                          ),
                          maxLines: 10,
                        )
                      ),
                    ),
                  ],
                ),

                new Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(5),
                      child: Container(
                        child: new Checkbox(
                          value: checkVal,
                          onChanged: (bool value){
                            setState(() {
                              checkVal = value;
                            });
                          }
                        ),
                        // alignment: FractionalOffset(.06,.05),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.all(5),
                      child: Container(
                        child: new Text("Register for WSIE Emailing List",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: body_text_size,
                              fontWeight: FontWeight.bold,
                          ),
                        ),
                        // alignment: FractionalOffset(.06,.05),
                      ),
                    ),
                  ],
                ),

                new Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(5),
                      child: RaisedButton(
                        elevation: 4.0,
                        color: SIUERed,
                        onPressed: ()=> _showDialog(),
                        child: Text(
                          'Send',
                          style: TextStyle(
                              color: Colors.white,
                          ),
                        ),
                      ),
                    )
                  ],
                ),

                new Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: RaisedButton(
                        elevation: 4.0,
                        color: SIUERed,
                        onPressed: ()=> _facebookLaunch(),
                        child: Text(
                          'Go to Facebook Page',
                          style: TextStyle(
                              color: Colors.white
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                new Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                      Padding(
                      padding: const EdgeInsets.all(5.0),
                      child:Text(
                        "This application was designed and developed\n by SIUE's department of computer science",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: body_text_size),
                      ),
                    ),
                  ],
                )
              ],
            )    
          ),
        ),
      ),
    );
  }
}