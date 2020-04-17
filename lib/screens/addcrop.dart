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
        ],
      ),
    );
  }

  Widget _seed() {
    return TextFormField(
      validator: (val) => val.isEmpty ? 'Enter Seed type' : null,
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

  List<String> _period = <String>[
    '2019-2020',
    '2020-2021',
    '2021-2022',
    '2022-2023',
    '2023-2024',
    '2024-2025',
    '2025-2026',
  ];

  String selectedperiod='';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.grey[800],
        title: Text('Add Crop'),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formkey,
          child: Padding(
            padding: const EdgeInsets.only(left: 15.0, right: 15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(height: 30.0),
                GestureDetector(
                  
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return Dialog(
                            backgroundColor: Colors.grey[800],
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            child: Container(
                              height: MediaQuery.of(context).size.height * 0.5,
                              width: MediaQuery.of(context).size.width,
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Scrollbar(
                                  
                                  child: ListView.builder(
                                      itemCount: _period.length,
                                      itemBuilder:
                                          (BuildContext context,
                                              int index) {
                                        return InkWell(
                                          splashColor: Colors.blue,
                                          onTap: () {
                                            setState(() {
                                              selectedperiod = _period[index];
                                              Navigator.pop(context);
                                            });
                                          },
                                          child: Container(
                                            width:
                                                MediaQuery.of(context)
                                                    .size
                                                    .width,
                                            height:
                                                MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.07,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.only(
                                                      left: 10.0),
                                              child: Row(
                                                children: <Widget>[
                                                  Text(
                                                    _period[index],
                                                    style: TextStyle(
                                                        color: Colors
                                                            .white,fontFamily: 'OpenSans',fontWeight: FontWeight.bold),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        );
                                      }),
                                ),
                              ),
                            ),
                          );
                        });
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.06,
                    decoration: BoxDecoration(
                        color: Colors.grey[800],
                        borderRadius: BorderRadius.circular(10)),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 15.0, right: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            selectedperiod,
                            style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'OpenSans',
                                fontSize: 15),
                          ),
                          Icon(
                            Icons.arrow_drop_down_circle,
                            color: Colors.white,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

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
                              border: Border.all(width: 1, color: Colors.blue)),
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
                  width: MediaQuery.of(context).size.width * 0.5,
                  height: MediaQuery.of(context).size.height * 0.05,
                  child: RaisedButton(
                    onPressed: () {
                      Navigator.pop(context, true);
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
      ),
    );
  }
}
