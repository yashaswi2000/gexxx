import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:gexxx_flutter/models/Crop.dart';
import 'package:gexxx_flutter/screens/CropProfile.dart';
import 'package:gexxx_flutter/screens/MainDrawer.dart';
import 'package:gexxx_flutter/utilities/constants.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class Home extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<Home> {
  Map data;
  List CropData;

  Future getData() async {
    http.Response response = await http.get(
        "https://api.data.gov.in/resource/9ef84268-d588-465a-a308-a864a43d0070?api-key=579b464db66ec23bdd000001cdd3946e44ce4aad7209ff7b23ac571b&format=json&offset=0&limit=30");
    data = json.decode(response.body);
    //debugPrint(response.body);
    setState(() {
      CropData = data["records"];
    });

    debugPrint(CropData.toString());
    print(CropData.length);
  }

  Container MyFeed(String crop_name, String state) {
    return Container(
      margin: EdgeInsets.all(15),
      width: MediaQuery.of(context).size.width,
      height: 300,
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: <Widget>[
          AutoSizeText(
            crop_name,
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'OpenSans',
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
            minFontSize: 15,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: 10),
          AutoSizeText(
            state,
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'OpenSans',
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
            minFontSize: 10,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  GestureDetector MyCrop(String imageval, String crop_name, String price) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => CropProfile()),
        );
      },
      child: Container(
        margin: EdgeInsets.all(15),
        width: 200,
        decoration: BoxDecoration(
            color: Colors.grey, borderRadius: BorderRadius.circular(20)),
        child: Stack(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 5, top: 5),
                  child: Column(
                    children: <Widget>[
                      Container(
                        width: 70,
                        height: 70,
                        margin: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                            color: Colors.green,
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                image: NetworkImage(imageval),
                                fit: BoxFit.fill)),
                      ),
                      AutoSizeText(
                        crop_name,
                        style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'OpenSans',
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                        minFontSize: 10,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: <Widget>[
                      Text(
                        'Price',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'OpenSans',
                          fontSize: 35.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      AutoSizeText(
                        price,
                        style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'OpenSans',
                          fontSize: 25,
                        ),
                        minFontSize: 20,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      )
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          title: Center(
            child: Text('GEXXX'),
          ),
          backgroundColor: Colors.black,
        ),
        backgroundColor: Colors.black,
        drawer: MainDrawer(),
        body: Column(
          children: <Widget>[
            Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)),
                margin: EdgeInsets.all(20),
                height: 150,
                width: MediaQuery.of(context).size.width,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: CropData == null ? 0 : CropData.length,
                    itemBuilder: (BuildContext context, int index) {
                      return MyCrop(
                          "https://media.gettyimages.com/photos/cropped-image-of-person-eye-picture-id942369796?s=612x612",
                          "${CropData[index]["variety"]}",
                          "${CropData[index]["modal_price"]}");
                    })),
            SizedBox(
              height: 10,
            ),
            Container(
              margin: EdgeInsets.all(10),
              height: 600,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(20),
                      topLeft: Radius.circular(
                        20,
                      ))),
              child: ListView.builder(
                itemCount: CropData == null ? 0 : CropData.length,
                itemBuilder: (BuildContext context, int index) {
                  return MyFeed("${CropData[index]["variety"]}",
                      "${CropData[index]["state"]}");
                },
              ),
            ),
          ],
        ));
  }
}
