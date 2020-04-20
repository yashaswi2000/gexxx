import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gexxx_flutter/utilities/Loading.dart';

class statetmenu extends StatefulWidget {
  String state;
  statetmenu({this.state});
  @override
  _statetmenuScreenState createState() => _statetmenuScreenState();
}

class _statetmenuScreenState extends State<statetmenu> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return Dialog(
        backgroundColor: Colors.grey[900],
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Scrollbar(
            child: FutureBuilder(
              future: DefaultAssetBundle.of(context)
                  .loadString("State_names/State_names.json"),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data != null) {
                    dynamic state_list = json.decode(snapshot.data.toString());
                    return ListView.builder(
                        itemCount: state_list?.length ?? 0,
                        itemBuilder: (BuildContext context, int index) {
                          return InkWell(
                            splashColor: Colors.blue,
                            onTap: () {
                              setState(() {
                                widget.state =  state_list[index]["state"];
                                Navigator.pop(
                                    context);
                              });
                            },
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height * 0.07,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 10.0),
                                child: Row(
                                  children: <Widget>[
                                    Text(
                                      state_list[index]["state"],
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
                  } else {
                    return new CircularProgressIndicator();
                  }
                } else if (snapshot.connectionState ==
                    ConnectionState.waiting) {
                  return Container(
                      child: new Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: new Center(
                              child: new CircularProgressIndicator())));
                } else if (snapshot.hasError) {
                  return new Text(
                    '${snapshot.error}',
                    style: TextStyle(color: Colors.red),
                  );
                } else {
                  return Loading();
                }
              },
            ),
          ),
        ));
  }
}
