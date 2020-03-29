import 'package:flutter/material.dart';
import 'package:gexxx_flutter/utilities/MyhorizantalDivider.dart';

class CropProfile extends StatelessWidget {

  final String cropname;
  final String price;

  const CropProfile({Key key, this.cropname, this.price}) : super(key: key);
  

  Container ImageSlides(BuildContext context,String imageval){
    return Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height*0.3,
                    decoration: BoxDecoration(
                      image: DecorationImage(image: NetworkImage(imageval),fit: BoxFit.fill),

                    ),
                  );
  }


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Text('CropProfile'),
        ),
        backgroundColor: Colors.black,
        body: SingleChildScrollView(
                  child: Column(
            children: <Widget>[
              Container(
                height: MediaQuery.of(context).size.height*0.3,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: <Widget>[
                    ImageSlides(context,"https://images.unsplash.com/photo-1529511582893-2d7e684dd128?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1190&q=80"),
                    ImageSlides(context, "https://images.unsplash.com/photo-1543257580-7269da773bf5?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1050&q=80"),
                  ],
                ),
              ),
              SizedBox(height:10),
              Padding(
                padding: const EdgeInsets.only(left:20.0,right:20,top:10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    
                    Text(
                      this.cropname,
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'OpenSans',
                        fontSize: 30.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '${this.price} / kg',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'OpenSans',
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              MyhorizontalDivider(),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Center(
                  child: Text(
                    'CULTIVATION',
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'OpenSans',
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),        


            ],
          ),
        ));
  }
}
