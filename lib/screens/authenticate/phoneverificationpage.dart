import 'package:flutter/material.dart';
import 'package:gexxx_flutter/screens/Dashboard.dart';
import 'package:gexxx_flutter/services/auth.dart';

import 'package:pin_code_text_field/pin_code_text_field.dart';

class Phoneverificationpage extends StatefulWidget {
  final String verificationId;
  final String phonenumber;

  const Phoneverificationpage({Key key, this.verificationId, this.phonenumber}) : super(key: key);

  
  @override
  _PhoneverificationpageScreenState createState() =>
      _PhoneverificationpageScreenState();
}

class _PhoneverificationpageScreenState extends State<Phoneverificationpage> {
 
  String code = "";
  String errormessage = "";
    final AuthService _auth = AuthService();
  bool error = false;
 
  
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: ConstrainedBox(
          constraints:
              BoxConstraints(maxHeight: MediaQuery.of(context).size.height),
          child: Padding(
            padding: const EdgeInsets.only(top: 60.0, left: 10, right: 10),
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'SMS Verification',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 25),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Container(
                  height: MediaQuery.of(context).size.height * 0.1,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      color: Colors.grey[800],
                      borderRadius: BorderRadius.circular(10)),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child:Row(
                        children: <Widget>[
                          Expanded(child: RichText(text: TextSpan(children: [
                            TextSpan(
                              text:"Please enter the ",
                              style:TextStyle(color:Colors.white)
                            ),
                            TextSpan(
                              text:"One Time Password ",
                              style:TextStyle(color:Colors.white)
                            ),
                            TextSpan(
                              text:"Sent to ${widget.phonenumber}",
                              style:TextStyle(color:Colors.white)
                            ),
                          ]),))
                        ],
                      )
                    ),
                  ),
                ),
                SizedBox(height: 50),
                PinCodeTextField(
                  pinTextStyle: TextStyle(color: Colors.white),
                  hasTextBorderColor: Colors.green,
                  highlight: true,
                  pinBoxColor: Colors.grey[800],
                  maxLength: 6,
                  pinBoxWidth:55,
                  pinBoxHeight: 55,
                  pinBoxDecoration:
                      ProvidedPinBoxDecoration.roundedPinBoxDecoration,
                  wrapAlignment: WrapAlignment.center,
                  pinTextAnimatedSwitcherTransition:
                      ProvidedPinBoxTextAnimation.scalingTransition,
                  pinTextAnimatedSwitcherDuration: Duration(milliseconds: 300),
                  highlightAnimationBeginColor: Colors.black,
                  highlightAnimationEndColor: Colors.white12,
                  keyboardType: TextInputType.number,
                  hasError: error,
                  autofocus: true,
                  onTextChanged: (temp){
                    print("wow $code");
                    setState(() {
                      error=false;
                      code=temp;

                    });
                  },
                  onDone: (temp){
                    print("Done $temp");
                   
                  },
                ),
                Visibility(
                child: Text(
                  "Wrong PIN!",
                  style: TextStyle(color: Colors.red),
                ),
                visible:error,
              ),
                SizedBox(height: 30),
                FlatButton(
                    
                    onPressed:()async{
                      if(code.isNotEmpty && code.length==6){
                            //AuthService().signInWithOTP(code, widget.verificationId,widget.phonenumber,'ass');
                           
                             Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>DashboardPage()), (Route<dynamic> route)=>false);
                           
                           
                        print("ass");
                        setState(() {
                          error=true;
                        });
                      }
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(left:10.0,right: 10),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height * 0.07,
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(30)
                        ),
                        child: Center(child: Text('Done',style: TextStyle(color: Colors.white,fontSize: 20),),),
                      ),
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
