import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gexxx_flutter/database/database.dart';
import 'package:url_launcher/url_launcher.dart';

class CropPest extends StatefulWidget {
  String crop;
  CropPest({this.crop});
  @override
  _CropPestState createState() => _CropPestState();
}

class _CropPestState extends State<CropPest> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<DocumentSnapshot>>(
        future: DatabaseService().getpests(widget.crop),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<DocumentSnapshot> snapshots = snapshot.data;
            print(snapshots.length);
            return Scaffold(
              backgroundColor: Colors.grey[200],
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
                              widget.crop,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
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
                        padding: const EdgeInsets.only(
                            left: 20.0, top: 10, bottom: 10),
                        child: Text(
                          'Pests/Diseases',
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize:
                                  MediaQuery.of(context).size.height * 0.02),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: snapshots.length,
                          itemBuilder: (c, i) {
                            print(snapshots[i]['pestimages'][0]);
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 10.0),
                              child: InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Pest(
                                                pestname: snapshots[i]
                                                    ['pestname'],
                                                snapshot: snapshots[i],
                                              )));
                                },
                                child: ListTile(
                                  leading: Image.network(
                                      snapshots[i]['pestimages'][0]),
                                  title: Text(
                                    snapshots[i]['pestname'],
                                    style: TextStyle(color: Colors.black),
                                  ),
                                ),
                              ),
                            );
                          })
                    ],
                  ),
                ),
              ),
            );
          } else {
            return Scaffold(
              backgroundColor: Colors.grey[200],
              body: SafeArea(
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
                            widget.crop,
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
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
                    Expanded(
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    )
                  ],
                ),
              ),
            );
          }
        });
  }
}

class Pest extends StatefulWidget {
  String pestname;
  DocumentSnapshot snapshot;
  Pest({this.pestname, this.snapshot});
  @override
  _PestState createState() => _PestState();
}

class _PestState extends State<Pest> {
  _launchURL(String url) async {
    if (await canLaunch(url)) {
      print(url);
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
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
                      widget.pestname,
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
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.3,
                child: ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: widget.snapshot['pestimages'].length,
                    itemBuilder: (c, i) {
                      return Image.network(
                        widget.snapshot['pestimages'][i],
                        fit: BoxFit.cover,
                      );
                    }),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 10.0, top: 20, bottom: 20, right: 40),
                child: Text(
                  'Recommended Solutions for this Pest/Disease',
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: MediaQuery.of(context).size.height * 0.02),
                ),
              ),
              ListView.builder(
                  shrinkWrap: true,
                  itemCount: widget.snapshot['solobj'].length,
                  itemBuilder: (c, i) {
                    print(widget.snapshot['solobj'][i]['image']);
                    return Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            '${i + 1} . ${widget.snapshot['solobj'][i]['solutionname']}',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                                fontSize:
                                    MediaQuery.of(context).size.height * 0.017),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          InkWell(
                            onTap: () {
                              print('button pressed');
                              _launchURL(widget.snapshot['solobj'][i]['url']);
                            },
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(5)),
                              child: ListTile(
                                leading: Image.network(
                                    widget.snapshot['solobj'][i]['image']),
                                title: Text(
                                  'Get more info',
                                  style: TextStyle(
                                      color: Colors.grey[800],
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    );
                  })
            ],
          ),
        ),
      ),
    );
  }
}
