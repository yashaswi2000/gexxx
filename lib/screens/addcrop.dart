import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gexxx_flutter/database/database.dart';
import 'package:gexxx_flutter/models/Areaunit.dart';
import 'package:gexxx_flutter/models/Period.dart';
import 'package:gexxx_flutter/models/Season.dart';
import 'package:gexxx_flutter/models/land.dart';
import 'package:gexxx_flutter/models/user.dart';
import 'package:gexxx_flutter/services/auth.dart';
import 'package:gexxx_flutter/utilities/Loading.dart';
import 'dart:convert';

import 'package:provider/provider.dart';

class addcrop extends StatefulWidget {
  @override
  _addcropScreenState createState() => _addcropScreenState();
}

class _addcropScreenState extends State<addcrop> {

  List<Period> period;
  List<Season> season;
  List<Areaunit> areaunit;
  List<Landtype> landtype;
  List<Landtopography> landtopography;
  List<Soil> soil;
    @override
  void initState() {
    super.initState();
      period = Period.getperiod();
      season = Season.getSeason();
      areaunit = Areaunit.getAreaunit();
      landtype = Landtype.getLandtype();
      landtopography=Landtopography.getLandtopography();
      soil = Soil.getsoil();
  }


  final AuthService _auth = AuthService();

  final _formkey = GlobalKey<FormState>();

  
  
  


  String selectedseason = 'Season';
  String selectedareaunit = 'Area unit';
  String area = '';
  String productivity = '';
  String selectedcrop = 'Crop';
  String selectedProductivityunit = 'Productivity unit';
  DateTime transplantingdate = DateTime.now();
  String toastmessage;
  String selectedlandtype = 'Land Type';
  String selectedlandtopography = 'Land Topography';
  String selectedsoil = 'Soil';
  String landsize = '';
  String selectedlandsizeunit = 'Land size unit';

  
  bool seasonvisible = false;
  bool cropvisible = false;
  bool areavisible = false;
  bool areaunitvisible = false;
  bool landsizeunitvisible = false;
  bool datevisible = false;
  bool productivityunitvisible = false;
  bool isloading=false;

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: transplantingdate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != transplantingdate)
      setState(() {
        transplantingdate = picked;
      });
  }

  
  Widget _season() {
    return GestureDetector(
      onTap: () {
        setState(() {
          seasonvisible = false;
        });
        showDialog(
            context: context,
            builder: (context) {
              return Dialog(
                backgroundColor: Colors.grey[800],
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.24,
                  width: MediaQuery.of(context).size.width,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Scrollbar(
                      child: ListView.builder(
                          itemCount: season.length,
                          itemBuilder: (BuildContext context, int index) {
                            return InkWell(
                              splashColor: Colors.blue,
                              onTap: () {
                                setState(() {
                                  selectedseason = season[index].season;
                                  Navigator.pop(context);
                                });
                              },
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                height:
                                    MediaQuery.of(context).size.height * 0.07,
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 10.0),
                                  child: Row(
                                    children: <Widget>[
                                      Text(
                                        season[index].season,
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontFamily: 'OpenSans',
                                            fontWeight: FontWeight.bold),
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
            color: seasonvisible ? Colors.red : Colors.grey[800],
            borderRadius: BorderRadius.circular(5)),
        child: Padding(
          padding: const EdgeInsets.only(left: 15.0, right: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                selectedseason,
                style: TextStyle(
                    color: Colors.white, fontFamily: 'OpenSans', fontSize: 15),
              ),
              Icon(
                Icons.arrow_drop_down_circle,
                color: Colors.white,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _crop() {
    return GestureDetector(
      onTap: () {
        setState(() {
          cropvisible = false;
        });
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
                      child: FutureBuilder(
                        future: DefaultAssetBundle.of(context)
                            .loadString("Crop_database/crop_database.json"),
                        builder: (context, snapshot) {
                          dynamic crop_list =
                              json.decode(snapshot.data.toString());
                          return ListView.builder(
                              itemCount: crop_list?.length ?? 0,
                              itemBuilder: (BuildContext context, int index) {
                                return InkWell(
                                  splashColor: Colors.blue,
                                  onTap: () {
                                    setState(() {
                                      selectedcrop = crop_list[index]["name"];
                                      Navigator.pop(context);
                                    });
                                  },
                                  child: Container(
                                    width: MediaQuery.of(context).size.width,
                                    height: MediaQuery.of(context).size.height *
                                        0.07,
                                    child: Padding(
                                      padding:
                                          const EdgeInsets.only(left: 10.0),
                                      child: Row(
                                        children: <Widget>[
                                          Text(
                                            crop_list[index]["name"],
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontFamily: 'OpenSans',
                                                fontWeight: FontWeight.bold),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              });
                        },
                      ),
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
            color: cropvisible ? Colors.red : Colors.grey[800],
            borderRadius: BorderRadius.circular(5)),
        child: Padding(
          padding: const EdgeInsets.only(left: 15.0, right: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                selectedcrop,
                style: TextStyle(
                    color: Colors.white, fontFamily: 'OpenSans', fontSize: 15),
              ),
              Icon(
                Icons.arrow_drop_down_circle,
                color: Colors.white,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _area() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.06,
      decoration: BoxDecoration(
          color: areavisible ? Colors.red : Colors.grey[800],
          borderRadius: BorderRadius.circular(5)),
      child: TextFormField(
        onChanged: (val) {
          setState(() {
            area = val;
            areavisible = false;
          });
        },
        validator: (val) => val.isEmpty ? 'Enter the Area' : null,
        keyboardType: TextInputType.phone,
        textAlign: TextAlign.left,
        style: TextStyle(
            color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
        decoration: InputDecoration(
          fillColor: Colors.white,
          focusColor: Colors.yellow,
          prefixIcon: Icon(Icons.landscape, color: Colors.white),
          border: InputBorder.none,
          hintText: 'Area',
          hintStyle: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.normal,
              fontSize: 15,
              fontFamily: 'OpenSans'),
        ),
      ),
    );
  }
  Widget _landsize() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.06,
      decoration: BoxDecoration(
          color: areavisible ? Colors.red : Colors.grey[800],
          borderRadius: BorderRadius.circular(5)),
      child: TextFormField(
        onChanged: (val) {
          setState(() {
            landsize = val;
          });
        },
        
        keyboardType: TextInputType.phone,
        textAlign: TextAlign.left,
        style: TextStyle(
            color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
        decoration: InputDecoration(
          fillColor: Colors.white,
          focusColor: Colors.yellow,
          prefixIcon: Icon(Icons.landscape, color: Colors.white),
          border: InputBorder.none,
          hintText: 'Land size',
          hintStyle: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.normal,
              fontSize: 15,
              fontFamily: 'OpenSans'),
        ),
      ),
    );
  }

  Widget _productivity() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.06,
      decoration: BoxDecoration(
          color: Colors.grey[800], borderRadius: BorderRadius.circular(5)),
      child: TextFormField(
        onChanged: (val) {
          setState(() {
            productivity = val;
          });
        },
        validator: (val) => val.isEmpty ? 'Enter the Area' : null,
        keyboardType: TextInputType.phone,
        textAlign: TextAlign.left,
        style: TextStyle(
            color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
        decoration: InputDecoration(
          fillColor: Colors.white,
          focusColor: Colors.yellow,
          prefixIcon: Icon(Icons.landscape, color: Colors.white),
          border: InputBorder.none,
          hintText: 'Productivity',
          hintStyle: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.normal,
              fontSize: 15,
              fontFamily: 'OpenSans'),
        ),
      ),
    );
  }

  Widget _areaunit() {
    return GestureDetector(
      onTap: () {
        setState(() {
          areaunitvisible = false;
        });
        showDialog(
            context: context,
            builder: (context) {
              return Dialog(
                backgroundColor: Colors.grey[800],
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.24,
                  width: MediaQuery.of(context).size.width,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Scrollbar(
                      child: ListView.builder(
                          itemCount: areaunit.length,
                          itemBuilder: (BuildContext context, int index) {
                            return InkWell(
                              splashColor: Colors.blue,
                              onTap: () {
                                setState(() {
                                  selectedareaunit = areaunit[index].areaunit;
                                  Navigator.pop(context);
                                });
                              },
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                height:
                                    MediaQuery.of(context).size.height * 0.07,
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 10.0),
                                  child: Row(
                                    children: <Widget>[
                                      Text(
                                        areaunit[index].areaunit,
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontFamily: 'OpenSans',
                                            fontWeight: FontWeight.bold),
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
            color: areaunitvisible ? Colors.red : Colors.grey[800],
            borderRadius: BorderRadius.circular(5)),
        child: Padding(
          padding: const EdgeInsets.only(left: 15.0, right: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                selectedareaunit,
                style: TextStyle(
                    color: Colors.white, fontFamily: 'OpenSans', fontSize: 15),
              ),
              Icon(
                Icons.arrow_drop_down_circle,
                color: Colors.white,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _landtype() {
    return GestureDetector(
      onTap: () {
        
        showDialog(
            context: context,
            builder: (context) {
              return Dialog(
                backgroundColor: Colors.grey[800],
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.24,
                  width: MediaQuery.of(context).size.width,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Scrollbar(
                      child: ListView.builder(
                          itemCount: landtype.length,
                          itemBuilder: (BuildContext context, int index) {
                            return InkWell(
                              splashColor: Colors.blue,
                              onTap: () {
                                setState(() {
                                  selectedlandtype = landtype[index].landtype;
                                  Navigator.pop(context);
                                });
                              },
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                height:
                                    MediaQuery.of(context).size.height * 0.07,
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 10.0),
                                  child: Row(
                                    children: <Widget>[
                                      Text(
                                        landtype[index].landtype,
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontFamily: 'OpenSans',
                                            fontWeight: FontWeight.bold),
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
            borderRadius: BorderRadius.circular(5)),
        child: Padding(
          padding: const EdgeInsets.only(left: 15.0, right: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                selectedlandtype,
                style: TextStyle(
                    color: Colors.white, fontFamily: 'OpenSans', fontSize: 15),
              ),
              Icon(
                Icons.arrow_drop_down_circle,
                color: Colors.white,
              ),
            ],
          ),
        ),
      ),
    );
  }

   Widget _landtopography() {
    return GestureDetector(
      onTap: () {
        
        showDialog(
            context: context,
            builder: (context) {
              return Dialog(
                backgroundColor: Colors.grey[800],
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.18,
                  width: MediaQuery.of(context).size.width,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Scrollbar(
                      child: ListView.builder(
                          itemCount: landtopography.length,
                          itemBuilder: (BuildContext context, int index) {
                            return InkWell(
                              splashColor: Colors.blue,
                              onTap: () {
                                setState(() {
                                  selectedlandtopography = landtopography[index].landtopography;
                                  Navigator.pop(context);
                                });
                              },
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                height:
                                    MediaQuery.of(context).size.height * 0.07,
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 10.0),
                                  child: Row(
                                    children: <Widget>[
                                      Text(
                                        landtopography[index].landtopography,
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontFamily: 'OpenSans',
                                            fontWeight: FontWeight.bold),
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
            borderRadius: BorderRadius.circular(5)),
        child: Padding(
          padding: const EdgeInsets.only(left: 15.0, right: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                selectedlandtopography,
                style: TextStyle(
                    color: Colors.white, fontFamily: 'OpenSans', fontSize: 15),
              ),
              Icon(
                Icons.arrow_drop_down_circle,
                color: Colors.white,
              ),
            ],
          ),
        ),
      ),
    );
  }

  

  Widget _productivityunit() {
    return GestureDetector(
      onTap: () {
        setState(() {
          productivityunitvisible = false;
        });
        showDialog(
            context: context,
            builder: (context) {
              return Dialog(
                backgroundColor: Colors.grey[800],
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.24,
                  width: MediaQuery.of(context).size.width,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Scrollbar(
                      child: ListView.builder(
                          itemCount: areaunit.length,
                          itemBuilder: (BuildContext context, int index) {
                            return InkWell(
                              splashColor: Colors.blue,
                              onTap: () {
                                setState(() {
                                  selectedProductivityunit = areaunit[index].areaunit;
                                  Navigator.pop(context);
                                });
                              },
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                height:
                                    MediaQuery.of(context).size.height * 0.07,
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 10.0),
                                  child: Row(
                                    children: <Widget>[
                                      Text(
                                        areaunit[index].areaunit,
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontFamily: 'OpenSans',
                                            fontWeight: FontWeight.bold),
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
            color:  productivityunitvisible? Colors.red:Colors.grey[800], borderRadius: BorderRadius.circular(5)),
        child: Padding(
          padding: const EdgeInsets.only(left: 15.0, right: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                selectedProductivityunit,
                style: TextStyle(
                    color: Colors.white, fontFamily: 'OpenSans', fontSize: 15),
              ),
              Icon(
                Icons.arrow_drop_down_circle,
                color: Colors.white,
              ),
            ],
          ),
        ),
      ),
    );
  }




 Widget _soil() {
    return GestureDetector(
      onTap: () {
        
        showDialog(
            context: context,
            builder: (context) {
              return Dialog(
                backgroundColor: Colors.grey[800],
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.4,
                  width: MediaQuery.of(context).size.width,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Scrollbar(
                      child: ListView.builder(
                          itemCount: soil.length,
                          itemBuilder: (BuildContext context, int index) {
                            return InkWell(
                              splashColor: Colors.blue,
                              onTap: () {
                                setState(() {
                                  selectedsoil = soil[index].soil;
                                  Navigator.pop(context);
                                });
                              },
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                height:
                                    MediaQuery.of(context).size.height * 0.07,
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 10.0),
                                  child: Row(
                                    children: <Widget>[
                                      Text(
                                       soil[index].soil,
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontFamily: 'OpenSans',
                                            fontWeight: FontWeight.bold),
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
            color:  productivityunitvisible? Colors.red:Colors.grey[800], borderRadius: BorderRadius.circular(5)),
        child: Padding(
          padding: const EdgeInsets.only(left: 15.0, right: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                selectedsoil,
                style: TextStyle(
                    color: Colors.white, fontFamily: 'OpenSans', fontSize: 15),
              ),
              Icon(
                Icons.arrow_drop_down_circle,
                color: Colors.white,
              ),
            ],
          ),
        ),
      ),
    );
  }

   Widget _landsizeunit() {
    return GestureDetector(
      onTap: () {
        setState(() {
          landsizeunitvisible = false;
        });
       
        showDialog(
            context: context,
            builder: (context) {
              return Dialog(
                backgroundColor: Colors.grey[800],
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.24,
                  width: MediaQuery.of(context).size.width,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Scrollbar(
                      child: ListView.builder(
                          itemCount: areaunit.length,
                          itemBuilder: (BuildContext context, int index) {
                            return InkWell(
                              splashColor: Colors.blue,
                              onTap: () {
                                setState(() {
                                  selectedlandsizeunit = areaunit[index].areaunit;
                                  Navigator.pop(context);
                                });
                              },
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                height:
                                    MediaQuery.of(context).size.height * 0.07,
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 10.0),
                                  child: Row(
                                    children: <Widget>[
                                      Text(
                                       areaunit[index].areaunit,
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontFamily: 'OpenSans',
                                            fontWeight: FontWeight.bold),
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
            color:  productivityunitvisible? Colors.red:Colors.grey[800], borderRadius: BorderRadius.circular(5)),
        child: Padding(
          padding: const EdgeInsets.only(left: 15.0, right: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                selectedlandsizeunit,
                style: TextStyle(
                    color: Colors.white, fontFamily: 'OpenSans', fontSize: 15),
              ),
              Icon(
                Icons.arrow_drop_down_circle,
                color: Colors.white,
              ),
            ],
          ),
        ),
      ),
    );
  }
  Widget _transplantingdate() {
    return GestureDetector(
      onTap: () => _selectDate(context),
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * 0.06,
        decoration: BoxDecoration(
            color: Colors.grey[800], borderRadius: BorderRadius.circular(5)),
        child: Padding(
          padding: const EdgeInsets.only(left: 15.0, right: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                "${transplantingdate.toLocal()}".split(' ')[0],
                style: TextStyle(
                    color: Colors.white, fontFamily: 'OpenSans', fontSize: 15),
              ),
              Icon(
                Icons.arrow_drop_down_circle,
                color: Colors.white,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<String> getimage(String name)async
  {
    String data = await DefaultAssetBundle.of(context).loadString("Crop_database/crop_database.json");
    final result = json.decode(data);
    for (var i=0 ;i<result?.length??0;i++){
      if(result[i]["name"]==name)
      {
        
           return result[i]["images"][0];
          
        
      }
    }

  }
  void showLongToast() {
    Fluttertoast.showToast(
      msg:toastmessage,
      toastLength: Toast.LENGTH_LONG,
    );
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    return isloading?Loading():Scaffold(
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
                
                Row(
                  children: <Widget>[
                    Text(
                      'Select the Season',
                      style: TextStyle(
                        color: seasonvisible ? Colors.red : Colors.white,
                        fontFamily: 'openSans',
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 5),
                _season(),
                SizedBox(height: 10),
                Row(
                  children: <Widget>[
                    Text(
                      'Select the Crop',
                      style: TextStyle(
                          color: cropvisible ? Colors.red : Colors.white,
                          fontFamily: 'openSans',
                          fontWeight: FontWeight.bold,
                          fontSize: 15),
                    ),
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                _crop(),
                SizedBox(height: 10),
                Row(
                  children: <Widget>[
                    Text(
                      'Select the Area',
                      style: TextStyle(
                          color: areavisible ? Colors.red : Colors.white,
                          fontFamily: 'openSans',
                          fontWeight: FontWeight.bold,
                          fontSize: 15),
                    ),
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                _area(),
                SizedBox(height: 10),
                Row(
                  children: <Widget>[
                    Text(
                      'Select the Area Unit',
                      style: TextStyle(
                          color: areaunitvisible ? Colors.red : Colors.white,
                          fontFamily: 'openSans',
                          fontWeight: FontWeight.bold,
                          fontSize: 15),
                    ),
                  ],
                ),
                SizedBox(height: 5),
                _areaunit(),
                SizedBox(height: 10,),
                Text(
                      'Land Details',
                      style: TextStyle(
                          color: areaunitvisible ? Colors.red : Colors.white,
                          fontFamily: 'openSans',
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    ),
                SizedBox(height: 10),
                Container(
                height: 340,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(color: Colors.teal,
                borderRadius: BorderRadius.circular(10),
                
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: <Widget>[
                      _landtype(),
                      SizedBox(height: 10),
                      _landtopography(),
                      SizedBox(height: 10),
                      _landsize(),
                      SizedBox(height: 10),
                      _landsizeunit(),
                      SizedBox(height: 10),
                      _soil(),
                      
                    ],
                  ),
                ),
                ),
                SizedBox(height: 10),
                Row(
                  children: <Widget>[
                    Text(
                      'Select the Productivity',
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'openSans',
                          fontWeight: FontWeight.bold,
                          fontSize: 15),
                    ),
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                _productivity(),
                SizedBox(height: 10),
                Row(
                  children: <Widget>[
                    Text(
                      'Select the Productivity Unit',
                      style: TextStyle(
                          color: productivityunitvisible? Colors.red:Colors.white,
                          fontFamily: 'openSans',
                          fontWeight: FontWeight.bold,
                          fontSize: 15),
                    ),
                  ],
                ),
                SizedBox(height: 5),
                _productivityunit(),
                SizedBox(height: 10),
                Row(
                  children: <Widget>[
                    Text(
                      'Transplanting/Sowing date',
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'openSans',
                          fontWeight: FontWeight.bold,
                          fontSize: 15),
                    ),
                  ],
                ),
                SizedBox(height: 5),
                _transplantingdate(),
                SizedBox(height: 20),
                FloatingActionButton.extended(
                  backgroundColor: Colors.blue,
                  isExtended: true,
                  label: Text('Done'),
                  elevation: 10,
                  tooltip: 'pressing this button will a add a crop',
                  onPressed: () async {
                    
                    if (selectedseason == 'Season') {
                      setState(() {
                        isloading=false;
                        seasonvisible = true;
                      });
                    }
                    
                    if (selectedcrop == 'Crop') {
                      setState(() {
                        isloading=false;
                        cropvisible = true;
                      });
                    }
                    if (area == '') {
                      setState(() {
                        selectedareaunit = '';
                      });
                    }
                    if(area!='' && selectedareaunit == 'Area unit')
                    {
                      setState(() {
                        isloading = false;
                        areaunitvisible = true;
                      });
                    }

                    if(selectedlandtype=='Land Type')
                    {
                      setState(() {
                        selectedlandtype = '';
                      });
                    }
                    
                    if(selectedlandtopography=='Land Topography')
                    {
                      setState(() {
                        selectedlandtopography= '';
                      });
                    }
                    if(selectedsoil == 'Soil')
                    {
                      setState(() {
                        selectedsoil = '';
                      });
                    }

                     if (landsize == '') {
                      setState(() {
                        selectedlandsizeunit = '';
                      });
                    }
                    if(area!='' && selectedareaunit == 'Area unit')
                    {
                      setState(() {
                        isloading = false;
                        landsizeunitvisible = true;
                      });
                    }

                  
      
      
                    if(productivity !='' && selectedProductivityunit == 'Productivity unit')
                    {
                      setState(() {
                        isloading=false;
                        productivityunitvisible = true;
                      });
                    }
                   if(productivity=='')
                   {
                     setState(() {
                       isloading=false;
                       selectedProductivityunit='';
                       productivityunitvisible=false;
                     });
                   }
                  

                    if (
                        seasonvisible == false &&
                        cropvisible == false &&
                        areaunitvisible == false &&
                        landsizeunitvisible == false && productivityunitvisible==false) {
                           setState(() {
                      isloading = true;
                    });
                      
                      String image=await  getimage(selectedcrop);
                      dynamic result = await DatabaseService(uid: user.uid).UpdateCropsCollection(user.uid, selectedseason, selectedcrop, area, selectedareaunit, productivity, selectedProductivityunit, transplantingdate, image,selectedlandtype,selectedlandtopography,landsize,selectedlandsizeunit,selectedsoil);
                      if(result = true)
                      {
                        setState(() {
                          isloading = false;
                          toastmessage = 'crop is added';
                        });

                      }
                      else{
                        setState(() {
                          isloading = false;
                          toastmessage = 'Something went wrong,try again after some time'; 
                        });
                      }
                      showLongToast();
                      Navigator.pop(context);
                     
                    }
                  },
                  icon: Icon(Icons.done),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}