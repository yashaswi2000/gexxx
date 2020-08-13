import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gexxx_flutter/screens/CropProfile.dart';
import 'package:gexxx_flutter/utilities/Loading.dart';
import 'package:gexxx_flutter/utilities/constants.dart';

class Cropslist extends StatefulWidget {
  @override
  _CropslistScreenState createState() => _CropslistScreenState();
}

class _CropslistScreenState extends State<Cropslist> {
  Widget _cropbox(String imageval, String crop_name, String description) {
    print(imageval);
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => CropProfile(crop_name: crop_name)));
      },
      child: Container(
          margin: EdgeInsets.only(top: 20),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 0.12,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                    color: Colors.grey[200], spreadRadius: 1, blurRadius: 5)
              ]),
          child: Row(
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: SizedBox(
                    height: MediaQuery.of(context).size.height * 0.12,
                    width: MediaQuery.of(context).size.width * 0.3,
                    child: Image.asset(
                      '$imageval',
                      fit: BoxFit.cover,
                    )),
              ),
              SizedBox(width: 10),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        crop_name,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'OpenSans',
                          fontSize: MediaQuery.of(context).size.width * 0.04,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        description,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'OpenSans',
                          fontSize: MediaQuery.of(context).size.width * 0.03,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
            child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: <Widget>[
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
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
                          'All Crops in India',
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.w500),
                        )
                      ],
                    ),
                    FutureBuilder(
                      future: DefaultAssetBundle.of(context)
                          .loadString("Crop_database/crop_database.json"),
                      builder: (context, snapshot) {
                        if (snapshot.hasError) {
                          return new Text(
                            '${snapshot.error}',
                            style: TextStyle(color: Colors.red),
                          );
                        } else if (snapshot.hasData) {
                          dynamic crop_list =
                              json.decode(snapshot.data.toString());

                          return ListView.builder(
                              shrinkWrap: true,
                              itemCount: crop_list?.length ?? 0,
                              itemBuilder: (BuildContext context, int index) {
                                return _cropbox(
                                    crop_list[index]["images"][0],
                                    crop_list[index]["name"],
                                    crop_list[index]["introduction"]);
                              });
                        }
                        return new Loading();
                      },
                    ),
                  ],
                ))),
      ),
    );
  }
}
