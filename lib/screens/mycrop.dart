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
  Widget cropbox(var obj,VoidCallback ondelete  ) {
    DateTime date = obj.data["transplantingdate"].toDate();
    return Dismissible(
      key: Key(obj.data["crop"]),
      onDismissed: (direction){
        showLongToast(obj.data["crop"]);
        ondelete();
        
      },
      background: Container(color: Colors.red,padding: EdgeInsets.only(right:10),child: Icon(Icons.delete,color: Colors.white,),),
          child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 0.12,
          decoration: BoxDecoration(
              color: Colors.white38, borderRadius: BorderRadius.circular(20)),
          child: Padding(
            padding:
                const EdgeInsets.only(left: 20.0, right: 20, top: 10, bottom: 10),
            child: Row(
              children: <Widget>[
                CircleAvatar(
                  radius: MediaQuery.of(context).size.width * 0.1,
                  backgroundImage: AssetImage(obj.data["image"]),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10.0, right: 10),
                  child: MyVerticalDivider2(),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10.0),
                      child: AutoSizeText(
                        obj.data["crop"],
                        style: TextStyle(color: Colors.white, fontSize: 18),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10.0),
                      child: AutoSizeText(
                        "${date.toLocal()}".split(' ')[0],
                        style: TextStyle(color: Colors.white, fontSize: 18),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Row(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(right: 25.0),
                          child: InkWell(
                            onTap: () {
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return Dialog(
                                        backgroundColor: Colors.grey[800],
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: Container(
                                          height:
                                              MediaQuery.of(context).size.height *
                                                  0.5,
                                          width:
                                              MediaQuery.of(context).size.width,
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
                                                  backgroundImage: AssetImage(
                                                      obj.data["image"]),
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
                                                  padding: const EdgeInsets.only(bottom:10.0),
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
                                                  padding: const EdgeInsets.only(bottom:10.0),
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
                                                  padding: const EdgeInsets.only(bottom:10.0),
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
                                                  padding: const EdgeInsets.only(bottom:10.0),
                                                  child: Row(
                                                    children: <Widget>[
                                                       AutoSizeText(
                                                        'Period : ',
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 18),
                                                        maxLines: 1,
                                                        overflow:
                                                            TextOverflow.ellipsis,
                                                      ),
                                                      AutoSizeText(
                                                        obj.data["period"],
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
                                                  padding: const EdgeInsets.only(bottom:10.0),
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
                                                  padding: const EdgeInsets.only(bottom:10.0),
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
                        Padding(
                          padding: const EdgeInsets.only(right: 25.0),
                          child: InkWell(
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>editcrop(
                                cropname: obj.data["crop"],
                                period: obj.data["period"],
                                season: obj.data["season"],
                                area: obj.data["area"],
                                areaunit: obj.data["areaunit"],
                                productivity: obj.data["productivity"],
                                productivityunit: obj.data["productivityunit"],
                                date: obj.data["transplantingdate"].toDate(),
                                image: obj.data["image"],
                              )));


                            },
                            child: Icon(
                              Icons.edit,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 25.0),
                          child:  AutoSizeText(
                        'Swipe to delete',
                        style: TextStyle(color: Colors.white, fontSize: 10),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                        ),
                      ],
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    // TODO: implement build
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: <Widget>[
          MyhorizontalDivider(),
          SingleChildScrollView(
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.44,
              child: FutureBuilder(
                future: DatabaseService().getmycrops(user.uid),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return new Text(
                      '${snapshot.error}',
                      style: TextStyle(color: Colors.red),
                    );
                  } else if (snapshot.hasData) {
                    return snapshot.data.length==0?Center(child: Text('Your Crop list is Empty',style: TextStyle(color: Colors.white),),):ListView.builder(
                        itemCount: snapshot.data?.length ?? 0,
                        itemBuilder: (BuildContext context, int index) {
                          return cropbox(snapshot.data[index],(){DatabaseService(uid:snapshot.data[index].data["uid"]).deletecrop(snapshot.data[index].data["crop"]);});
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
              ),
            ),
          ),
          MyhorizontalDivider(),
          SizedBox(height: 10),
          FloatingActionButton.extended(
            backgroundColor: Colors.blue,
            isExtended: true,
            label: Text('Add a Crop'),
            elevation: 10,
            tooltip: 'Add a Crop',
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context)=>addcrop()));
            },
            icon: Icon(Icons.add),
          ),
        ],
      ),
    );
  }
}
