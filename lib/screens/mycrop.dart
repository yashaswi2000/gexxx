import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gexxx_flutter/database/database.dart';
import 'package:gexxx_flutter/models/user.dart';
import 'package:gexxx_flutter/screens/addcrop.dart';
import 'package:gexxx_flutter/screens/editcrop.dart';
import 'package:gexxx_flutter/utilities/Loading.dart';
import 'package:gexxx_flutter/utilities/MyVerticalDivider.dart';
import 'package:gexxx_flutter/utilities/MyhorizantalDivider.dart';
import 'package:gexxx_flutter/utilities/MyverticalDivider2.dart';
import 'package:provider/provider.dart';

class MyCrop extends StatefulWidget {
  @override
  _MyCropScreenState createState() => _MyCropScreenState();
}

class _MyCropScreenState extends State<MyCrop> {
  void showLongToast(String name) {
    Fluttertoast.showToast(
      msg: "$name Crop is deleted",
      toastLength: Toast.LENGTH_LONG,
    );
  }

  Widget cropbox(var obj) {
    DateTime date = obj.data["transplantingdate"].toDate();
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * 0.12,
        decoration: BoxDecoration(
            color: Colors.teal, borderRadius: BorderRadius.circular(5)),
        child: Padding(
          padding: const EdgeInsets.only(top: 10, bottom: 10),
          child: Row(
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width / 4,
                decoration: BoxDecoration(
                    border: Border(
                        right: BorderSide(width: 1, color: Colors.white))),
                child: Center(
                  child: CircleAvatar(
                    radius: MediaQuery.of(context).size.width * 0.10,
                    backgroundImage: AssetImage(obj.data["image"]),
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                    border: Border(
                        right: BorderSide(width: 1, color: Colors.white))),
                width: MediaQuery.of(context).size.width / 3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        child: Center(
                          child: AutoSizeText(
                            obj.data["crop"],
                            style: TextStyle(
                              color: Colors.white,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            minFontSize: 18,
                            maxFontSize: 25,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        child: Center(
                          child: AutoSizeText(
                            "${date.toLocal()}".split(' ')[0],
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontFamily: 'Circular'),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            minFontSize: 18,
                            maxFontSize: 25,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        child: Center(
                          child: AutoSizeText(
                            obj.data["season"],
                            style: TextStyle(color: Colors.white, fontSize: 18),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            minFontSize: 18,
                            maxFontSize: 25,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  child: Center(
                    child: InkWell(
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return Dialog(
                                  backgroundColor: Colors.grey[800],
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Container(
                                    height: MediaQuery.of(context).size.height *
                                        0.5,
                                    width: MediaQuery.of(context).size.width,
                                    child: Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Column(
                                        children: <Widget>[
                                          SizedBox(height: 20),
                                          CircleAvatar(
                                            radius: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.13,
                                            backgroundImage:
                                                AssetImage(obj.data["image"]),
                                          ),
                                          SizedBox(height: 20),
                                          Divider(
                                            color: Colors.white,
                                            height: 2,
                                          ),
                                          SizedBox(
                                            height: 20,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 10.0),
                                            child: Row(
                                              children: <Widget>[
                                                AutoSizeText(
                                                  'Name : ',
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 18),
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                                AutoSizeText(
                                                  obj.data["crop"],
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 18),
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 10.0),
                                            child: Row(
                                              children: <Widget>[
                                                AutoSizeText(
                                                  'Date of cultivation : ',
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 18),
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                                AutoSizeText(
                                                  "${date.toLocal()}"
                                                      .split(' ')[0],
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 18),
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 10.0),
                                            child: Row(
                                              children: <Widget>[
                                                AutoSizeText(
                                                  'Season : ',
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 18),
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                                AutoSizeText(
                                                  obj.data["season"],
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 18),
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 10.0),
                                            child: Row(
                                              children: <Widget>[
                                                AutoSizeText(
                                                  'Area : ',
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 18),
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                                AutoSizeText(
                                                  obj.data["area"],
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 18),
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                                AutoSizeText(
                                                  obj.data["areaunit"],
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 18),
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 10.0),
                                            child: Row(
                                              children: <Widget>[
                                                AutoSizeText(
                                                  'Productivity : ',
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 18),
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                                AutoSizeText(
                                                  obj.data["productivity"],
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 18),
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                                AutoSizeText(
                                                  obj.data["productivityunit"],
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 18),
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ));
                            });
                      },
                      child: Icon(
                        Icons.remove_red_eye,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  child: Center(
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => editcrop(
                                      obj: obj,
                                    )));
                      },
                      child: Icon(
                        Icons.edit,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  child: Center(
                    child: InkWell(
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return Dialog(
                                  backgroundColor: Colors.grey[800],
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Container(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.13,
                                      width: MediaQuery.of(context).size.width,
                                      child: Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Column(
                                          children: <Widget>[
                                            Text(
                                              'Are you sure you want to delete?',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 15),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 20.0),
                                              child: Row(
                                                children: <Widget>[
                                                  Expanded(
                                                    child: Container(
                                                      child: Center(
                                                        child: InkWell(
                                                          onTap: () {
                                                            Navigator.pop(
                                                                context);
                                                          },
                                                          child: Text(
                                                            'no',
                                                            style: TextStyle(
                                                                color:
                                                                    Colors.teal,
                                                                fontSize: 20),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: Container(
                                                      child: Center(
                                                        child: InkWell(
                                                          onTap: () async {
                                                            Navigator.pop(
                                                                context);
                                                            setState(() {
                                                              isloading = true;
                                                            });
                                                            await DatabaseService(
                                                                    uid: obj.data[
                                                                        "uid"])
                                                                .deletecrop(obj
                                                                        .data[
                                                                    "crop"]);

                                                            showLongToast(obj
                                                                .data["crop"]);
                                                            setState(() {
                                                              isloading = false;
                                                            });
                                                            
                                                          },
                                                          splashColor:
                                                              Colors.blue,
                                                          child: Text(
                                                            'yes',
                                                            style: TextStyle(
                                                                color:
                                                                    Colors.teal,
                                                                fontSize: 20),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      )));
                            });
                      },
                      child: Icon(
                        Icons.delete,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  bool isloading = false;
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    // TODO: implement build
    return isloading
        ? Container(
                              child: new Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: new Center(
                                      child: new CircularProgressIndicator())))
        : FutureBuilder(
          future: DatabaseService().getmycrops(user.uid),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return new Text(
                '${snapshot.error}',
                style: TextStyle(color: Colors.red),
              );
            } else if (snapshot.hasData) {
              return snapshot.data.length == 0
                  ? Center(
                      child: Text(
                        'Your Crop list is Empty',
                        style: TextStyle(color: Colors.white),
                      ),
                    )
                  : ListView.builder(
                      itemCount: snapshot.data?.length ?? 0,
                      itemBuilder:
                          (BuildContext context, int index) {
                        return cropbox(snapshot.data[index]);
                      });
            } else if (snapshot.connectionState ==
                ConnectionState.waiting) {
              return Container(
                  child: new Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: new Center(
                          child: new CircularProgressIndicator())));
            } else {
              return Loading();
            }
          },
        );
  }
}