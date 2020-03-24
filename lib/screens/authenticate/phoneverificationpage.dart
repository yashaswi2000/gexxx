import 'package:flutter/material.dart';

class Phoneverificationpage extends StatefulWidget {
  @override
  _PhoneverificationpageScreenState createState() =>
      _PhoneverificationpageScreenState();
}

class _PhoneverificationpageScreenState extends State<Phoneverificationpage> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: ConstrainedBox(
          constraints:
              BoxConstraints(maxHeight: MediaQuery.of(context).size.height),
          child: Column(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(left:10),
                child:Row(
                  children: <Widget>[
                    
                    IconButton(icon: Icon(Icons.arrow_back,size: 25,color: Colors.white),onPressed: (){
                      Navigator.pop(context);
                    },),
                    SizedBox(width: 10),
                    Align(
                      alignment: Alignment.centerLeft,
                                  child: Text(
                      'Login with',
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold,fontSize: 25),
              ),
                    ),
                  ],
                )),
            ],
          ),
        ),
      ),
    );
  }
}
