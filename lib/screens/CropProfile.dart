import 'package:flutter/material.dart';
import 'package:gexxx_flutter/utilities/MyhorizantalDivider.dart';

class CropProfile extends StatelessWidget {
  final String cropname;
  final String price;

  const CropProfile({Key key, this.cropname, this.price}) : super(key: key);

  Container ImageSlides(BuildContext context, String imageval) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.3,
      decoration: BoxDecoration(
        image: DecorationImage(image: NetworkImage(imageval), fit: BoxFit.fill),
      ),
    );
  }

  Container steps(String heading, String subheading) {
    return Container(
        child: Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            children: <Widget>[
              Text(
                heading,
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
        Padding(
          padding: const EdgeInsets.only(left: 20.0, right: 20),
          child: Text(
            subheading,
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'OpenSans',
              fontSize: 13.0,
              fontWeight: FontWeight.normal,
            ),
          ),
        ),
      ],
    ));
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
                height: MediaQuery.of(context).size.height * 0.3,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: <Widget>[
                    ImageSlides(context,
                        "https://images.unsplash.com/photo-1529511582893-2d7e684dd128?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1190&q=80"),
                    ImageSlides(context,
                        "https://images.unsplash.com/photo-1543257580-7269da773bf5?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1050&q=80"),
                  ],
                ),
              ),
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.only(left: 20.0, right: 20, top: 10),
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
              Container(
                width: MediaQuery.of(context).size.width * 0.9,
                height: MediaQuery.of(context).size.height * 0.120,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.grey[800]),
                child: Padding(
                  padding:
                      const EdgeInsets.only(left: 14.0, top: 10, bottom: 10),
                  child: Column(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Text(
                            'Land Area : 500',
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'OpenSans',
                              fontSize: 15.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: <Widget>[
                          Text(
                            'Type of Seed : Natural',
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'OpenSans',
                              fontSize: 15.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: <Widget>[
                          Text(
                            'Date of Cultivation : 27-03-2020',
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'OpenSans',
                              fontSize: 15.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),
              Container(
                width: MediaQuery.of(context).size.width * 0.9,
                height: MediaQuery.of(context).size.height * 0.07,
                child: RaisedButton(
                  elevation: 5.0,
                  onPressed: () => print(' Treatment methods Pressed'),
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
                  Icon(Icons.chevron_right,color: Colors.white,size: 40,)
                    ],
                  )
                  
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
              steps('1. Choose a good location',
                  'The very important part of wheat farming is selection of an appropriate place.  You must look for a place that has fertile soil for wheat farming. Soil with a loam texture, good structure and moderate water holding capacity are some factors that you must consider to grow wheat.'),
              steps('2. Soil Preparation',
                  'The soil must be properly prepared before starting the wheat farming. For this you can plough the soil either with disc or mould board plough. Then arrange the soil by giving one deep plough, followed by 2 to 3 light ploughing and planking. Now add natural fertilizers to it. For commercial wheat farming, an average of 50 kg Nitrogen, 25 kg Phosphorus and 12 kg Potash is sufficient in one acre of land. Add more organic contents while preparing the soil.'),
              steps('3. Weather requirements',
                  'Wheat plants can be grown and planted in a wide range of agro-climatic conditions. The plants have high flexibility and hence can be grown in the tropical, sub-tropical zones and temperate zone. The most suitable climate for wheat farming is moist and cool weather.  The plants can easily survive in temperature between 3.5 °C and 35 °C, but the best temperature for wheat farming is between 21 °C and 26 °C.'),

              steps('4. Pick a variety',
                  'Make sure you choose the right variety of wheat according to the climatic conditions of your region. You can also consult an experienced farmer in your area to help you choose the right wheat variety.'),
              steps('5. Seeding',
                  'Wheat seeds are easily available in the market. While purchasing the seeds, make sure it is of good quality, high yielding and disease free. Usually 40 to 50 kg seeds are required in one acre of land. Although exact amount of seeds required depends on the variety and sowing method.'),

              steps('6. Planting',
                  'The wheat seeds must be sown in about 4 to 5 cm inside the soil. Always put the seeds in rows and maintain a spacing of 20-22.5 cm between the rows. Planting or sowing the seeds in the right time is also important as delayed sowing can cause a gradual decline in the production. In India, it is generally sown in the end of October and early November.Also see that the wheat seeds is properly graded and thoroughly cleaned before sowing. Here you can apply fungicide for treating the seeds.'),
              steps('7. Caring',
                  'The wheat plants are quite tough and strong. They generally do well in favorable climate conditions and require less care. And if you take some extra care, it will be good and will ensure maximum production.'),

              steps('8. Pest and disease control ',
                  'The wheat plants are susceptible to many pests and diseases like aphids and termites. While some of the common diseases in wheat plants are brown rust, powdery mildew, Flag smut, etc. To control the pests or diseases, you can use good quality pesticides or insecticides. You can also consult with the local agriculture extension office or an expert who can give you proper advice on it.'),
              steps('9. Harvesting',
                  'Harvesting starts when the leaves and stem turn yellow in color and become fairly dry. Remember that the wheat must be harvested before it is dead ripe to avoid loss in yield. Thus, timely harvesting is necessary for good quality as well as maximum production of wheat. When the moisture content in the wheat reaches to about 25 - 30%, then the wheat is ready to be harvested. Combine harvester are available in the market for harvesting, threshing and winnowing of wheat crop in a single operation.'),

              ////////////////////////////////
              ///
              ///
              ///
            ],
          ),
        ));
  }
}
