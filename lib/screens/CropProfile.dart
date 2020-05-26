import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:gexxx_flutter/utilities/Loading.dart';
import 'package:gexxx_flutter/utilities/MyhorizantalDivider.dart';
import 'package:gexxx_flutter/utilities/constants.dart';

class CropProfile extends StatefulWidget {
  final String crop_name;

  const CropProfile({Key key, this.crop_name}) : super(key: key);
  @override
  _CropProfileScreenState createState() => _CropProfileScreenState();
}

class _CropProfileScreenState extends State<CropProfile> {
  bool flag = false;
  Container ImageSlides(BuildContext context, String imageval) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.3,
      decoration: BoxDecoration(
        image:
            DecorationImage(image: AssetImage('$imageval'), fit: BoxFit.fill),
      ),
    );
  }

  Container format1(String subheading) {
    return Container(
        color: Colors.grey[800],
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(20),
              child: AutoSizeText(
                subheading,
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'OpenSans',
                  fontSize: 14.0,
                  fontWeight: FontWeight.normal,
                ),
                maxLines: 10,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ));
  }

  Container steps(String heading, String subheading) {
    return Container(
        color: Colors.grey[800],
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top:20,left:20,right:20),
              child: Row(
                children: <Widget>[
                  AutoSizeText(
                    heading,
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'OpenSans',
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 1,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: AutoSizeText(
                subheading,
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'OpenSans',
                  fontSize: 14.0,
                  fontWeight: FontWeight.normal,
                ),
                maxLines: 10,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ));
  }

  Widget _profile(var obj) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 0.3,
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: obj["images"]?.length ?? 0,
              itemBuilder: (BuildContext context, int index) {
                return ImageSlides(context, obj["images"][index]);
              }),
        ),
        SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.only(left: 15.0, right: 15),
          child: Row(
            children: <Widget>[
              AutoSizeText(
                obj["name"],
                style: TextStyle(
                   
                    fontWeight: FontWeight.bold,
                    fontSize: 30),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
        SizedBox(height: 20),

        MyhorizontalDivider(),
        Container(
          width: MediaQuery.of(context).size.width * 0.9,
          height: MediaQuery.of(context).size.height * 0.07,
          child: RaisedButton(
              elevation: 5.0,
              onPressed: () {},
              padding: EdgeInsets.all(15.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              color: Colors.blue[800],
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Treatment Methods',
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'OpenSans',
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Icon(
                    Icons.chevron_right,
                    color: Colors.white,
                    size: 40,
                  )
                ],
              )),
        ),
        MyhorizontalDivider(),
        //SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            children: <Widget>[
              AutoSizeText(
                '1. Introduction',
                style: TextStyle(
                  color: Colors.blue,
                  fontFamily: 'OpenSans',
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
                maxLines: 1,
              ),
            ],
          ),
        ),
        MyhorizontalDivider(),
        format1(obj["introduction"]),
        MyhorizontalDivider(),

        //SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            children: <Widget>[
              AutoSizeText(
                '2. Climate and Soil Requirements',
                style: TextStyle(
                  color: Colors.blue,
                  fontFamily: 'OpenSans',
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
                maxLines: 1,
              ),
            ],
          ),
        ),
        MyhorizontalDivider(),
        format1(obj["climate_and_soil_requirements"]),
        MyhorizontalDivider(),

        Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            children: <Widget>[
              AutoSizeText(
                '3. Land Preparation',
                style: TextStyle(
                  color: Colors.blue,
                  fontFamily: 'OpenSans',
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
                maxLines: 1,
              ),
            ],
          ),
        ),
        MyhorizontalDivider(),
        format1(obj["land_preparation"]),
        MyhorizontalDivider(),
         Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            children: <Widget>[
              AutoSizeText(
                '4. Sowing',
                style: TextStyle(
                  color: Colors.blue,
                  fontFamily: 'OpenSans',
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
                maxLines: 1,
              ),
            ],
          ),
        ),
        MyhorizontalDivider(),
        steps('Sowing time', obj["sowing"][0]["sowingtime"]),
        steps('Seed rate', obj["sowing"][0]["seed_rate"]),
        steps('Spacing', obj["sowing"][0]["spacing"]),
        steps('Seed treatment', obj["sowing"][0]["seed_treatment"]),
        MyhorizontalDivider(),
        Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            children: <Widget>[
              AutoSizeText(
                '5.irrigation',
                style: TextStyle(
                  color: Colors.blue,
                  fontFamily: 'OpenSans',
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
                maxLines: 1,
              ),
            ],
          ),
        ),
        MyhorizontalDivider(),
        format1(obj["irrigation"]),
        MyhorizontalDivider(),
        Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            children: <Widget>[
              AutoSizeText(
                '6. Harvesting and Storage',
                style: TextStyle(
                  color: Colors.blue,
                  fontFamily: 'OpenSans',
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
                maxLines: 1,
              ),
            ],
          ),
        ),
        MyhorizontalDivider(),
        steps('Harvesting', obj["harvesting_and_storage"][0]["harvesting"]),
        steps('Yield', obj["harvesting_and_storage"][0]["yield"]),
        steps('Storage', obj["harvesting_and_storage"][0]["Storage"]),
        
        MyhorizontalDivider(),

        SizedBox(height: 20,),
        Padding(
          padding: const EdgeInsets.all(20),
          child: AutoSizeText(
            'Footer will be placed here',
            style: TextStyle(
              color: Colors.grey[600],
              fontFamily: 'OpenSans',
              fontSize: 15.0,
              fontWeight: FontWeight.normal,
            ),
            maxLines: 1,
          ),
        ),

      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.grey[800],
          title: Text('CropProfile'),
          backgroundColor: kThemeColor,
        ),
<<<<<<< Updated upstream
        backgroundColor: Colors.black,
=======
        backgroundColor: Theme.of(context).brightness == Brightness.light?Colors.white:Colors.black,
      
>>>>>>> Stashed changes
        body: SingleChildScrollView(
          child: Scrollbar(
            child: Container(
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
                  } else if (snapshot.hasData) {
                    dynamic crop_list = json.decode(snapshot.data.toString());
                    for (var i = 0; i < crop_list?.length ?? 0; i++) {
                      if (crop_list[i]["name"] == widget.crop_name) {
                        flag = true;
                        return _profile(crop_list[i]);
                      }
                    }
                    if (flag == false) {
                      return Center(
                          child: Text(
                        'Something went wrong ,Please try again later',
                        style: TextStyle(color: Colors.white),
                      ));
                    }
                  }
                  return new Loading();
                },
              ),
            ),
          ),
        ));
  }
}
