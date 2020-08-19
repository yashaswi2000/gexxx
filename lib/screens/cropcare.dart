import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gexxx_flutter/screens/croppest.dart';

class CropCare extends StatefulWidget {
  @override
  _CropCareState createState() => _CropCareState();
}

class _CropCareState extends State<CropCare> {
  List<String> crops = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    IconButton(
                      icon: Icon(
                        Icons.arrow_back,
                        color: Colors.black,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    Text(
                      'Crop Care',
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.search,
                        color: Colors.black,
                      ),
                      onPressed: () {},
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20.0, top: 10, bottom: 10),
                child: Text(
                  'Select a Crop',
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: MediaQuery.of(context).size.height * 0.02),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20.0, right: 20),
                child: Text(
                  'Get all the information regarding Pests Or Diseases and their Recommended Product Solutions',
                  style: TextStyle(
                      color: Colors.grey[800],
                      fontWeight: FontWeight.w500,
                      fontSize: MediaQuery.of(context).size.height * 0.015),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              FutureBuilder(
                  future: DefaultAssetBundle.of(context)
                      .loadString("Crop_database/pest_crops.json"),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      dynamic pestcrops = json.decode(snapshot.data.toString());
                      int len = pestcrops['crops'].length;
                      for (int i = 0; i < len; i++) {
                        crops.add(pestcrops['crops'][i]);
                      }
                      print(crops);
                      return Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Wrap(
                          alignment: WrapAlignment.start,
                          runSpacing: 20,
                          spacing: 20,
                          children: crops.map((e) {
                            return InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => CropPest(
                                              crop: e,
                                            )));
                              },
                              child: Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.06,
                                width:
                                    MediaQuery.of(context).size.width / 2 - 20,
                                decoration: BoxDecoration(
                                    color: Colors.blue,
                                    borderRadius: BorderRadius.circular(5)),
                                child: Center(
                                  child: Text(
                                    e.toString(),
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      );
                    } else {
                      return CircularProgressIndicator();
                    }
                  })
            ],
          ),
        ),
      ),
    );
  }
}
