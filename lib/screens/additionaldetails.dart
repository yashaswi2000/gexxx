import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gexxx_flutter/services/auth.dart';

class additionaldetails extends StatefulWidget {
  @override
  _additionaldetailsScreenState createState() =>
      _additionaldetailsScreenState();
}

class _additionaldetailsScreenState extends State<additionaldetails> {
  final AuthService _auth = AuthService();
  final _formkey = GlobalKey<FormState>();
  List<String> _soillist = <String>[
    'Alluvial Soil',
    'Black Soil',
    'Red Soil',
    'Desert Soil',
    'Laterite Soil',
    'Mountain Soil'
  ];

  List<String> _languageslist = <String>['English', 'Hindi', 'Telugu'];

  String _selectedsoil;
  String _selectedlanguage;
  var waterlevel = 0.0;

  Widget _soiltype() {
    return Container(
      height: MediaQuery.of(context).size.height * 0.055,
      decoration: BoxDecoration(
          color: Colors.grey[900], borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.only(left: 10.0, right: 10),
        child: Row(
          children: <Widget>[
            Icon(Icons.perm_identity, color: Colors.white),
            SizedBox(
              width: 20,
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.72,
              child: DropdownButton(
                  iconEnabledColor: Colors.black,
                  items: _soillist
                      .map((value) => DropdownMenuItem(
                            child: Text(
                              value,
                              style: TextStyle(color: Colors.blue),
                            ),
                            value: value,
                          ))
                      .toList(),
                  onChanged: (selected) {
                    setState(() {
                      _selectedsoil = selected;
                    });
                  },
                  value: _selectedsoil,
                  underline: Container(
                      height: 1.0,
                      decoration: const BoxDecoration(
                          border: Border(
                              bottom: BorderSide(
                                  color: Colors.transparent, width: 0.0)))),
                  isExpanded: true,
                  hint: Text(
                    'Choose any Soil Type',
                    style: TextStyle(color: Colors.white),
                  )),
            )
          ],
        ),
      ),
    );
  }

  Widget _language() {
    return Container(
      height: MediaQuery.of(context).size.height * 0.055,
      width: MediaQuery.of(context).size.width * 0.35,
      decoration: BoxDecoration(
          color: Colors.grey[900], borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.only(left: 10.0, right: 10),
        child: Row(
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width * 0.25,
              child: DropdownButton(
                  iconEnabledColor: Colors.black,
                  items: _languageslist
                      .map((value) => DropdownMenuItem(
                            child: Text(
                              value,
                              style: TextStyle(color: Colors.blue),
                            ),
                            value: value,
                          ))
                      .toList(),
                  onChanged: (selected) {
                    setState(() {
                      _selectedlanguage = selected;
                    });
                  },
                  value: _selectedlanguage,
                  underline: Container(
                      height: 1.0,
                      decoration: const BoxDecoration(
                          border: Border(
                              bottom: BorderSide(
                                  color: Colors.transparent, width: 0.0)))),
                  isExpanded: true,
                  hint: Text(
                    'Language',
                    style: TextStyle(color: Colors.white),
                  )),
            )
          ],
        ),
      ),
    );
  }

  void _locationMenu() {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            decoration: BoxDecoration(color: Colors.white),
            height: MediaQuery.of(context).size.height,
            child: Padding(
              padding: const EdgeInsets.only(top: 30, left: 20, right: 20),
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Text(
                        'Search Location',
                        style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'OpenSans',
                          fontSize: 15.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  TextField(
                    keyboardType: TextInputType.phone,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontFamily: 'OpenSans'),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
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
                  SizedBox(height: 10),
                  Row(
                    children: <Widget>[
                      Icon(
                        Icons.location_searching,
                        size: 20,
                        color: Colors.red,
                      ),
                      SizedBox(width: 10),
                      Text(
                        'use current Location',
                        style: TextStyle(
                          color: Colors.red,
                          fontFamily: 'OpenSans',
                          fontSize: 15.0,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        });
  }

  Widget _landsize() {
    return Container(
      alignment: Alignment.center,
      height: MediaQuery.of(context).size.height * 0.055,
      decoration: BoxDecoration(
          color: Colors.grey[900], borderRadius: BorderRadius.circular(10)),
      child: TextFormField(
        validator: (val) => val.isEmpty ? 'Land size' : null,
        keyboardType: TextInputType.phone,
        textAlign: TextAlign.left,
        style: TextStyle(
            color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
        decoration: InputDecoration(
          fillColor: Colors.white,
          focusColor: Colors.yellow,
          prefixIcon: Icon(Icons.landscape, color: Colors.white),
          border: InputBorder.none,
          hintText: 'Land Size in Acres',
          hintStyle: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.normal,
              fontSize: 15,
              fontFamily: 'OpenSans'),
        ),
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
          child: Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(height: 60),
                Row(
                  children: <Widget>[
                    Text(
                      'Additional Details',
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
                Row(
                  children: <Widget>[
                    Text(
                      'Location',
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'OpenSans',
                        fontSize: 15.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 15.0),
                GestureDetector(
                  onTap: () {
                    _locationMenu();
                  },
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.055,
                    decoration: BoxDecoration(
                        color: Colors.grey[900],
                        borderRadius: BorderRadius.circular(10)),
                    child: Row(
                      children: <Widget>[
                        SizedBox(width: 10),
                        Icon(
                          Icons.location_on,
                          color: Colors.white,
                        ),
                        SizedBox(width: 10),
                        Text(
                          'Tap here For the Location',
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'OpenSans',
                            fontSize: 15.0,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20.0),
                Row(
                  children: <Widget>[
                    Text(
                      'Soil Type',
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'OpenSans',
                        fontSize: 15.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 15),
                _soiltype(),
                SizedBox(
                  height: 15.0,
                ),
                Row(
                  children: <Widget>[
                    Text(
                      'Land Size',
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'OpenSans',
                        fontSize: 15.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 15),
                _landsize(),
                SizedBox(height: 15),
                Row(
                  children: <Widget>[
                    Text(
                      'Choose Water level',
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'OpenSans',
                        fontSize: 15.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 15),
                SliderTheme(
                  data: SliderTheme.of(context).copyWith(
                    activeTrackColor: Colors.grey[700],
                    inactiveTrackColor: Colors.grey[100],
                    trackShape: RoundedRectSliderTrackShape(),
                    trackHeight: 4.0,
                    thumbShape: RoundSliderThumbShape(enabledThumbRadius: 12.0),
                    thumbColor: Colors.white,
                    overlayColor: Colors.grey[800],
                    overlayShape: RoundSliderOverlayShape(overlayRadius: 28.0),
                    tickMarkShape: RoundSliderTickMarkShape(),
                    activeTickMarkColor: Colors.grey[700],
                    inactiveTickMarkColor: Colors.grey[100],
                    valueIndicatorShape: PaddleSliderValueIndicatorShape(),
                    valueIndicatorColor: Colors.blue,
                    valueIndicatorTextStyle: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  child: Slider(
                    value: waterlevel,
                    min: 0,
                    max: 100,
                    divisions: 10,
                    label: '$waterlevel',
                    onChanged: (value) {
                      setState(
                        () {
                          waterlevel = value;
                        },
                      );
                    },
                  ),
                ),
                Center(
                  child: Text(
                    'Water level is $waterlevel',
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'OpenSans',
                      fontSize: 15.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 50),
                Center(child: _language()),
                SizedBox(
                  height: 30,
                ),
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
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
