import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class marketview extends StatefulWidget {
  List<DocumentSnapshot> snapshots;
  marketview({this.snapshots});
  @override
  _marketviewState createState() => _marketviewState();
}

class _marketviewState extends State<marketview> {
  Widget cropbox(List list, String commodity) {
    return Column(
      children: <Widget>[
        Container(
          height: MediaQuery.of(context).size.height * 0.05,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              color: Colors.blue, borderRadius: BorderRadius.circular(10)),
          child: Row(
            children: <Widget>[
              SizedBox(
                width: 10,
              ),
              Text(commodity,
                  style: TextStyle(
                    color: Colors.white,
                  )),
            ],
          ),
        ),
        SizedBox(
          height: 10,
        ),
        ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: list.length,
            itemBuilder: (c, index) {
              int day = DateTime.fromMillisecondsSinceEpoch(
                      int.parse(list[index]['market_list'][0]['timestamp']) *
                          1000)
                  .day;
              int month = DateTime.fromMillisecondsSinceEpoch(
                      int.parse(list[index]['market_list'][0]['timestamp']) *
                          1000)
                  .month;
              int year = DateTime.fromMillisecondsSinceEpoch(
                      int.parse(list[index]['market_list'][0]['timestamp']) *
                          1000)
                  .year;
              String percentage = '0';
              Color co = Colors.grey[200];
              int size = list[index]['market_list'].length-1;
              if (size > 0) {
                int diff =  int.parse(list[index]['market_list'][size]['modal_price']) -
                    int.parse(list[index]['market_list'][size - 1]['modal_price']);

                percentage = ((diff /
                        int.parse(list[index]['market_list'][size - 1]['modal_price']))).abs().toStringAsPrecision(2);
                if (diff >= 0) {
                  co = Colors.green;
                } else {
                  co = Colors.red;
                }
              }
              return Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5)),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              list[index]['market'],
                              style: TextStyle(
                                  color: Colors.grey[800],
                                  fontWeight: FontWeight.w500,
                                  fontSize: MediaQuery.of(context).size.height *
                                      0.018),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              '${list[index]['district']} , ${list[index]['state']}',
                              style: TextStyle(
                                  color: Colors.grey[800],
                                  fontWeight: FontWeight.w500,
                                  fontSize: MediaQuery.of(context).size.height *
                                      0.018),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              '${day}-${month}-${year}',
                              style: TextStyle(
                                  color: Colors.grey[800],
                                  fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: <Widget>[
                            Text(
                              '₹ ${list[index]['market_list'][0]['modal_price']}/-',
                              style: TextStyle(
                                  color: Colors.grey[800],
                                  fontWeight: FontWeight.bold,
                                  fontSize: MediaQuery.of(context).size.height *
                                      0.02),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  color: co,
                                  borderRadius: BorderRadius.circular(10)),
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 20.0, right: 20, top: 10, bottom: 10),
                                child: Text(
                                  percentage.toString(),
                                  style: TextStyle(
                                      color: Colors.grey[800],
                                      fontWeight: FontWeight.bold,
                                      fontSize:
                                          MediaQuery.of(context).size.height *
                                              0.017),
                                ),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              );
            })
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    IconButton(
                      icon: Icon(Icons.arrow_back, color: Colors.black),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
                ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: widget.snapshots.length,
                    itemBuilder: (c, i) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 10.0),
                        child: cropbox(widget.snapshots[i]['pricelist'],
                            widget.snapshots[i]['commodity']),
                      );
                    }),
                SizedBox(
                  height: 100,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
