import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gexxx_flutter/app_localizations.dart';
import 'package:gexxx_flutter/database/database.dart';
import 'package:url_launcher/url_launcher.dart';

class Schema extends StatefulWidget {
  String category;
  Schema({this.category});
  @override
  _SchemaState createState() => _SchemaState();
}

class _SchemaState extends State<Schema> {
  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Object>(
        future: DatabaseService().getpolicies(widget.category),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<DocumentSnapshot> snapshots = snapshot.data;
            return Scaffold(
              backgroundColor: Colors.grey[200],
              body: SafeArea(
                child: SingleChildScrollView(
                  child: Column(
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
                              onPressed: () {},
                            ),
                            Text(
                              widget.category,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                            Icon(
                              Icons.search,
                              color: Colors.black,
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: snapshots.length,
                          itemBuilder: (c, i) {
                            if (snapshots.length == 0) {
                              return Center(
                                child: Text(
                                  'No schemas',
                                  style: TextStyle(color: Colors.black),
                                ),
                              );
                            } else {
                              return Padding(
                                padding: const EdgeInsets.only(
                                    left: 10.0, right: 10, bottom: 10),
                                child: Container(
                                  padding: EdgeInsets.all(10),
                                  width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(5)),
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                          snapshots[i]['title']
                                              .toString()
                                              .trimLeft(),
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        InkWell(
                                          onTap: () {
                                            _launchURL(
                                                snapshots[i]['downloadlink']);
                                          },
                                          child: Text(
                                            'go to pdf',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                color: Colors.blue,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            }
                          })
                    ],
                  ),
                ),
              ),
            );
          } else {
            return Scaffold(
              backgroundColor: Colors.grey[200],
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
        });
  }
}
