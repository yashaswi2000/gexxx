import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gexxx_flutter/screens/Home.dart';
import 'package:gexxx_flutter/screens/authenticate/Password.dart';
import 'package:gexxx_flutter/screens/authenticate/otp.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:gexxx_flutter/utilities/constants.dart';
class phonecodedata{
  String name;
  String dial_code;
  String imageval;
  
  phonecodedata(this.name,this.dial_code,this.imageval);
}

class Phone_code extends StatefulWidget {
  @override
  _Phone_codeScreenState createState() => _Phone_codeScreenState();
}

class _Phone_codeScreenState extends State<Phone_code> {

  List returnlist=[];
  String name;
  String dial_code;
  String imageval;
 
  GestureDetector Phone_container(String name, String dial_code,String imageval)  {
   
    return GestureDetector(
      child: Container(
        margin: EdgeInsets.all(4),
        width: MediaQuery.of(context).size.width,
        height: 40,
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.horizontal(),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 30),
              child: AutoSizeText(
                name,
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'OpenSans',
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
                minFontSize: 10,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            SizedBox(width: 10),
            AutoSizeText(
              '(',
              style: TextStyle(
                color: Colors.white,
                fontFamily: 'OpenSans',
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
              minFontSize: 10,
              overflow: TextOverflow.ellipsis,
            ),
            AutoSizeText(
              dial_code,
              style: TextStyle(
                color: Colors.white,
                fontFamily: 'OpenSans',
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
              minFontSize: 10,
              overflow: TextOverflow.ellipsis,
            ),
            AutoSizeText(
              ')',
              style: TextStyle(
                color: Colors.white,
                fontFamily: 'OpenSans',
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
              minFontSize: 10,
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(width: 5),
            Center(
              child: SvgPicture.network(imageval,placeholderBuilder: (context) => Icon(Icons.error,color: Colors.white,),
 height: 20,width: 20,),
            )
          ],
        ),
      ),
      onTap: (){
        phonecodedata obj = new phonecodedata(name,dial_code,imageval);
        
        Navigator.pop(context,obj);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 50),
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 14),
                    child: IconButton(
                      icon: Icon(
                        Icons.clear,
                        color: Colors.white,
                        size: 30,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left: 15),
                    child: Text(
                      'Select Country Code',
                      style: TextStyle(
                        color: Colors.white,
                        letterSpacing: 1.5,
                        fontSize: 25.0,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'OpenSans',
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left: 15),
                    child: Container(
                      alignment: Alignment.centerRight,
                      height: 60,
                      width: MediaQuery.of(context).size.width * 0.90,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 6.0,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: TextField(
                        keyboardType: TextInputType.phone,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            fontFamily: 'OpenSans'),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.only(
                              left: 14.0, right: 5.0, top: 14.0),
                          prefixIcon: Icon(
                            Icons.search,
                            color: Colors.black,
                          ),
                          hintText: 'Search Country',
                          hintStyle: TextStyle(
                            color: Colors.black,
                            fontFamily: 'OpenSans',
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                margin: EdgeInsets.only(top: 10),
                height: MediaQuery.of(context).size.height * 0.7,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(10.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 6.0,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: FutureBuilder(
                  future: DefaultAssetBundle.of(context)
                      .loadString("Phone_code/Phone_code.json"),
                  builder: (context, snapshot) {
                    dynamic phone_code_data =
                        json.decode(snapshot.data.toString());
                    //debugPrint(phone_code_data.length);
                    //debugPrint('asads');
                    return ListView.builder(
                        itemCount: phone_code_data == null
                            ? 0
                            : phone_code_data.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Phone_container(
                              "${phone_code_data[index]["name"]}",
                              "${phone_code_data[index]["callingCodes"][0]}",
                              "${phone_code_data[index]["flag"]}");
                        });
                    //return Text('saa');
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Print(length) {}
