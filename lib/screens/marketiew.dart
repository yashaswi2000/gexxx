import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class marketview extends StatefulWidget {
  DocumentSnapshot snapshot;
  marketview({this.snapshot});
  @override
  _marketviewState createState() => _marketviewState();
}

class _marketviewState extends State<marketview> {
  Widget cropbox(List list, int i) {
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
              Text(list[i]['commodity'],
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
            itemCount: list[i]['pricelist'].length,
            itemBuilder: (c, index) {
              int day = DateTime.fromMillisecondsSinceEpoch(
                      int.parse(list[i]['timestamp']) * 1000)
                  .day;
              int month = DateTime.fromMillisecondsSinceEpoch(
                      int.parse(list[i]['timestamp']) * 1000)
                  .day;
              int year = DateTime.fromMillisecondsSinceEpoch(
                      int.parse(list[i]['timestamp']) * 1000)
                  .year;
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
                              list[i]['pricelist'][index]['market'],
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
                              '${list[i]['pricelist'][index]['district']} , ${list[i]['pricelist'][index]['state']}',
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
                              '₹ ${list[i]['pricelist'][index]['modal_price']}/-',
                              style: TextStyle(
                                  color: Colors.grey[800],
                                  fontWeight: FontWeight.bold,
                                  fontSize: MediaQuery.of(context).size.height *
                                      0.02),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              '${list[i]['pricelist'][index]['modal_price_trend']}',
                              style: TextStyle(
                                  color: Colors.grey[800],
                                  fontWeight: FontWeight.w400),
                            ),
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
                    itemCount: widget.snapshot.data['list'].length,
                    itemBuilder: (c, i) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 10.0),
                        child: cropbox(widget.snapshot.data['list'], i),
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
