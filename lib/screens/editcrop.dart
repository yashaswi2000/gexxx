import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gexxx_flutter/database/database.dart';
import 'package:gexxx_flutter/models/Areaunit.dart';
import 'package:gexxx_flutter/models/Period.dart';
import 'package:gexxx_flutter/models/Season.dart';
import 'package:gexxx_flutter/models/user.dart';
import 'package:gexxx_flutter/services/auth.dart';
import 'package:gexxx_flutter/utilities/Loading.dart';
import 'dart:convert';

import 'package:provider/provider.dart';

class editcrop extends StatefulWidget {
  final String cropname;
  final String period;
  final String season;
  final String area;
  final String areaunit;
  final String productivity;
  final String productivityunit;
  final DateTime date;
  final String image;

  const editcrop({Key key, this.period, this.season, this.area, this.areaunit, this.productivity, this.productivityunit, this.date, this.cropname, this.image}) : super(key: key);

 

  @override
  _editcropScreenState createState() => _editcropScreenState();
}

class _editcropScreenState extends State<editcrop> {

  List<Period> period;
  List<Season> season;
  List<Areaunit> areaunit;
   

  final AuthService _auth = AuthService();

  final _formkey = GlobalKey<FormState>();

  
  
  

  String selectedperiod = 'Period';
  String selectedseason = 'Season';
  String selectedareaunit = 'Area unit';
  String area = '';
  String productivity = '';
  String selectedcrop = 'Crop';
  String selectedProductivityunit = 'Productivity unit';
  DateTime transplantingdate = DateTime.now();
  

  bool periodvisible = false;
  bool seasonvisible = false;
  bool cropvisible = false;
  bool areavisible = false;
  bool areaunitvisible = false;
  bool datevisible = false;
  bool productivityunitvisible = false;
  bool isloading=false;

   @override
  void initState() {
    super.initState();
      period = Period.getperiod();
      season = Season.getSeason();
      areaunit = Areaunit.getAreaunit();

      setState(() {
        selectedperiod = widget.period;
        selectedseason= widget.season;
        selectedcrop = widget.cropname;
        area= widget.area;
        selectedareaunit =  widget.areaunit;
        productivity= widget.productivity;
        selectedProductivityunit = widget.productivityunit;
        transplantingdate = widget.date;
      });



      
  }


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

  Widget _period() {
    return GestureDetector(
      onTap: () {
        setState(() {
          periodvisible = false;
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
                      child: ListView.builder(
                          itemCount: period.length,
                          itemBuilder: (BuildContext context, int index) {
                            return InkWell(
                              splashColor: Colors.blue,
                              onTap: () {
                                setState(() {
                                  selectedperiod = period[index].period;
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
                                        period[index].period,
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
            color: periodvisible ? Colors.red : Colors.grey[800],
            borderRadius: BorderRadius.circular(5)),
        child: Padding(
          padding: const EdgeInsets.only(left: 15.0, right: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                selectedperiod,
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
        initialValue: area,
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

  Widget _productivity() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.06,
      decoration: BoxDecoration(
          color: Colors.grey[800], borderRadius: BorderRadius.circular(5)),
      child: TextFormField(
        initialValue: productivity,
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
      msg: "Crop is edited",
      toastLength: Toast.LENGTH_LONG,
    );
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    return isloading? Loading():Scaffold(
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
                      'Select the Period',
                      style: TextStyle(
                          color: periodvisible ? Colors.red : Colors.white,
                          fontFamily: 'openSans',
                          fontWeight: FontWeight.bold,
                          fontSize: 15),
                    ),
                  ],
                ),
                SizedBox(height: 5),
                _period(),
                SizedBox(height: 10),
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
                /*SizedBox(height: 10),
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
                _crop(),*/
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
                  label: Text('Edit'),
                  elevation: 10,
                  tooltip: 'pressing this button will a add a crop',
                  onPressed: () async {
                    
                    if (selectedperiod == 'Period') {
                      setState(() {
                        periodvisible = true;
                        isloading=false;
                      });
                    }
                    if (selectedseason == 'Season') {
                      setState(() {
                        seasonvisible = true;
                        isloading=false;
                      });
                    }
                   /* if (selectedcrop == 'Crop') {
                      setState(() {
                        cropvisible = true;
                      });
                    }*/
                    if (area == '') {
                      setState(() {
                        areavisible = true;
                        isloading=false;
                      });
                    }
                    if (selectedareaunit == 'Area unit') {
                      setState(() {
                        areaunitvisible = true;
                        isloading=false;
                      });
                    }
                    if(productivity !='' && selectedProductivityunit == 'Productivity unit')
                    {
                      setState(() {
                        productivityunitvisible = true;
                        isloading=false;
                      });
                    }
                   if(productivity=='')
                   {
                     setState(() {
                       selectedProductivityunit='';
                       productivityunitvisible=false;
                       isloading=false;
                     });
                   }
                   

                    if (periodvisible == false &&
                        seasonvisible == false &&
                        cropvisible == false &&
                        areavisible == false &&
                        areaunitvisible == false&& productivityunitvisible==false) {

                          setState(() {
                      isloading=true;
                    });
                      
                      //String image=await  getimage(selectedcrop);
                      dynamic result = await DatabaseService(uid: user.uid)
                          .UpdateCropsCollection(
                              user.uid,
                              selectedperiod,
                              selectedseason,
                              selectedcrop,
                              area,
                              selectedareaunit,
                              productivity,
                              selectedProductivityunit,
                              transplantingdate,widget.image);
                      if (result == true) {
                        setState(() {
                          isloading=false;
                        });
                        //Scaffold.of(context).showSnackBar(new SnackBar(content: new Text("crop is added"),));
                        showLongToast();
                        Navigator.pop(context);
                      }
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
