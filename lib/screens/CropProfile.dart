import 'package:flutter/material.dart';

class CropProfile extends StatelessWidget {
  

  Container ImageSlides(BuildContext context,String imageval){
    return Container(
                    width: MediaQuery.of(context).size.width,
                    height: 300,
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
          title: Text('Cropprofile'),
        ),
        backgroundColor: Colors.black,
        body: SingleChildScrollView(
                  child: Column(
            children: <Widget>[
              Container(
                height: 300,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: <Widget>[
                    ImageSlides(context,"https://p.bigstockphoto.com/GeFvQkBbSLaMdpKXF1Zv_bigstock-Aerial-View-Of-Blue-Lakes-And--227291596.jpg"),
                    ImageSlides(context, "https://media.gettyimages.com/photos/cropped-image-of-person-eye-picture-id942369796?s=612x612"),
                  ],
                ),
              ),
              SizedBox(height:10),
              Text(
                'Tomato',
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'OpenSans',
                  fontSize: 30.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  'The tomato is the edible, often red, berry of the plant Solanum lycopersicum,[2][1] commonly known as a tomato plant. The species originated in western South America and Central America.[2][3] The Nahuatl (Aztec language) word tomatl gave rise to the Spanish word tomate, from which the English word tomato derived.[3][4] Its domestication and use as a cultivated food may have originated with the indigenous peoples of Mexico.[2][5] The Aztecs used tomatoes in their cooking at the time of the Spanish conquest of the Aztec Empire, and after the Spanish encountered the tomato for the first time after their contact with the Aztecs, they brought the plant to Europe. From there, the tomato was introduced to other parts of the European-colonized world during the 16th century',
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'OpenSans',
                    fontSize: 15.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),        


            ],
          ),
        ));
  }
}
