import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gexxx_flutter/screens/Home.dart';
import 'package:gexxx_flutter/screens/authenticate/Password.dart';
import 'package:gexxx_flutter/services/auth.dart';
import 'package:gexxx_flutter/utilities/constants.dart';

class addcrop extends StatefulWidget {
  @override
  _addcropScreenState createState() => _addcropScreenState();
}

class _addcropScreenState extends State<addcrop> {
  final AuthService _auth = AuthService();
  final _formkey = GlobalKey<FormState>();

  DateTime selectedDate = DateTime.now();

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
  }

  String error = '';
  String crop_name = '';
  String date = '';
  String type_seed = '';
  String area = '';
  TextEditingController _cropcontroller = TextEditingController();
  //TextEditingController _datecontroller = TextEditingController();
  TextEditingController _type_seedcontroller = TextEditingController();
  TextEditingController _areacontroller = TextEditingController();

  Widget _crop() {
    return TextFormField(
      controller: _cropcontroller,
      validator: (val) => val.isEmpty ? 'Enter Your name' : null,
      autofocus: true,
      autocorrect: true,
      onChanged: (val) {
        setState(() {
          crop_name = val;
        });
      },
      textAlign: TextAlign.left,
      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      decoration: InputDecoration(
        labelText: "Crop",
        fillColor: Colors.white,
        prefixIcon: Icon(Icons.mail, color: Colors.white),
        border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red),
            borderRadius: BorderRadius.circular(16)),
        hintText: 'Enter Crop Name',
        hintStyle: TextStyle(color: Colors.grey),
      ),
    );
  }

  Widget _date() {
    return GestureDetector(
          onTap: () => _selectDate(context),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                "${selectedDate.toLocal()}".split(' ')[0],
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              textAlign: TextAlign.left,
              ),
              // SizedBox(height: 20.0,),
              // RaisedButton(
              //   onPressed: () => _selectDate(context),
              //   child: Text('Select date'),
              // ),
            ],
          ),
    );
  }

  Widget _seed() {
    return TextFormField(
      validator: (val) =>
          val.isEmpty ? 'Enter Seed type' : null,
      controller: _type_seedcontroller,
            obscureText: false,
      autofocus: true,
      autocorrect: true,
      onChanged: (val) {
        setState(() {
          type_seed = val;
        });
      },
      textAlign: TextAlign.left,
      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      decoration: InputDecoration(
        labelText: "seed type",
        prefixIcon: Icon(
          Icons.toc,
          color: Colors.white,
        ),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
        hintText: 'Enter seed type',
        hintStyle: TextStyle(color: Colors.grey),
      ),
    );
  }

  Widget _area() {
    return TextFormField(
      validator: (val) => val.isEmpty ? 'Enter area of cultivation' : null,
      controller: _areacontroller,
      keyboardType: TextInputType.phone,
      obscureText: false,
      autofocus: true,
      autocorrect: true,
      onChanged: (val) {
        setState(() {
          area = val;
        });
      },
      textAlign: TextAlign.left,
      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      decoration: InputDecoration(
        labelText: "Land Area",
        prefixIcon: Icon(
          Icons.crop_3_2,
          color: Colors.white,
        ),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
        hintText: 'Enter your cutivation area',
        hintStyle: TextStyle(color: Colors.grey),
      ),
    );
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Form(
                key: _formkey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(height: 60),
                    Row(
                      
                      children: <Widget>[
                        SizedBox(width: 20),
                        Text(
                          'AddCrop',
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'OpenSans',
                            fontSize: 25.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 30.0),
                    Container(
                      margin: EdgeInsets.all(20),
                      child: _crop()),
                    SizedBox(height: 20.0),

                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                        'Date of Cultivation',
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'OpenSans',
                          fontSize: 15.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                          Container(
                            width: 100,
                            height: 20,
                            decoration: BoxDecoration(
                              border: Border.all(width: 1,color: Colors.blue)
                              
                            ),
                            child: _date()),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 30.0,
                    ),
                    _seed(),
                    SizedBox(
                      height: 30.0,
                    ),
                    _area(),
                    SizedBox(height: 30),
                    Container(
                  width: MediaQuery.of(context).size.width*0.5,
                  height: MediaQuery.of(context).size.height*0.05,
                  child: RaisedButton(
                    onPressed: () {
                      
                      Navigator.pop(context,true);
                    },
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    color: Colors.blue,
                    child: Text(
                      'Done',
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'OpenSans',
                        fontSize: 15.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 15),
                
                    Center(
                      child: Text(
                        error,
                        style: TextStyle(
                          color: Colors.red,
                          letterSpacing: 1.5,
                          fontSize: 10.0,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'OpenSans',
                        ),
                      ),
                    ),
                    //_buildSignupBtn(),
                  ],
                ),
              ),
      ),
      );
  }
}
