import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gexxx_flutter/screens/CropProfile.dart';
import 'package:gexxx_flutter/utilities/Loading.dart';

class Cropslist extends StatefulWidget {
  @override
  _CropslistScreenState createState() => _CropslistScreenState();
}

class _CropslistScreenState extends State<Cropslist> {
  Widget _cropbox(String imageval, String crop_name, String description) {
    print(imageval);
    return InkWell(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context)=>CropProfile(crop_name: crop_name)));
      },
      child: Container(
          margin: EdgeInsets.only(top: 20),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 0.12,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10), color: Colors.grey[800]),
          child: Row(
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width * 0.3,
                height: MediaQuery.of(context).size.height * 0.12,
                decoration: BoxDecoration(
                    color: Colors.blue[800],
                    image: DecorationImage(
                        image: AssetImage('$imageval'), fit: BoxFit.fill)),
              ),
              SizedBox(width: 10),
              Container(
                width: MediaQuery.of(context).size.width * 0.55,
                height: MediaQuery.of(context).size.height * 0.12,
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0, top: 10),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: Text(
                              crop_name,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'OpenSans',
                                fontSize: 25.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: Text(
                              description,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'OpenSans',
                                fontSize: 12.0,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text('Crops in India'),
        backgroundColor: Colors.grey[800],
      ),
      
      body: SingleChildScrollView(
          child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Scrollbar(
                child: Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: FutureBuilder(
                    future: DefaultAssetBundle.of(context)
                        .loadString("Crop_database/crop_database.json"),
                    builder: (context, snapshot) {
                      
                      if (snapshot.hasError) {
                        return new Text(
                          '${snapshot.error}',
                          style: TextStyle(color: Colors.red),
                        );  
                      } else if(snapshot.hasData){
                        dynamic crop_list = json.decode(snapshot.data.toString());

                        return ListView.builder(
                            itemCount: crop_list?.length??0,
                            itemBuilder: (BuildContext context, int index) {
                              return _cropbox(crop_list[index]["images"][0], crop_list[index]["name"],
                                  crop_list[index]["introduction"]);
                            });
                      }
                      return new Loading();
                    },
                  ),
                ),
              ))),
    );
  }
}
