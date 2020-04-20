import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gexxx_flutter/screens/Home.dart';
import 'package:gexxx_flutter/screens/authenticate/Password.dart';
import 'package:gexxx_flutter/services/auth.dart';
import 'package:gexxx_flutter/utilities/MyhorizantalDivider.dart';
import 'package:gexxx_flutter/utilities/constants.dart';

class NewsPage extends StatefulWidget {
  @override
  _NewsPageScreenState createState() => _NewsPageScreenState();
}

class _NewsPageScreenState extends State<NewsPage> {
  Widget _newsbox(String imageval,String heading,String subheading,String newswebsite) {
    return InkWell(
      onTap: (){},
          child: Container(
          margin: EdgeInsets.only(top:20),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 0.3,
          decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10), color: Colors.grey[800]),
          child: Column(
      children: <Widget>[
        Container(
          width: MediaQuery.of(context).size.width * 0.9,
          height: MediaQuery.of(context).size.height * 0.15,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                  image: NetworkImage(
                      imageval),
                  fit: BoxFit.fitWidth)),
        ),
       SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.only(left:10.0),
          child : Row(
            children: <Widget>[
              Expanded(
                              child: Text(
                  heading,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
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
        ),
        SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.only(left:10.0),
          child : Row(
            children: <Widget>[
              Expanded(
                              child: Text(
                  subheading,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'OpenSans',
                    fontSize: 12.0,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.only(left:10.0),
          child : Row(
            children: <Widget>[
              Expanded(
                              child: Text(
                  newswebsite,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  style: TextStyle(
                    color: Colors.blue[800],
                    fontFamily: 'OpenSans',
                    fontSize: 12.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
          ),
        ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.only(top: 60, left: 20, right: 20),
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 20.0, right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'News',
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'OpenSans',
                      fontSize: 30.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Icon(Icons.refresh, color: Colors.white, size: 30)
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20.0, bottom: 20),
              child: MyhorizontalDivider(),
            ),
            _newsbox('https://static.producer.com/wp-content/uploads/2020/03/28125239/51-4-col-RTS2D76Y.jpg','COVID-19 undermines Indian crop prices, derails rural rebound','MUMBAI, India (Reuters) — Indian farmer Banwarilal Bhardwaj was planning to buy a car after harvesting his winter-sown crops that were promising bumper returns.But the COVID-19 virus has shattered that dream, undermining farm commodity prices as it spreads around the world.“I can’t buy a car. Whatever I would earn, that will now be needed to repay a loan,” said Bhardwaj, who has planted rapeseed and chickpeas on his 15 acre farm in the northwestern state of Rajasthan.','News18.c0m'),
            _newsbox('https://static.agriculture.com/styles/node_article_image_full_large/s3/s3fs-public/image/2016/05/10/EmergingCorn2-CloseUp.jpg?timestamp=1550618773','NEW CROP TOOLS MAXIMIZE N EFFICIENCY IN CORN, SOYBEANS, AND OTHER CROPS','One theme of the 2020 Commodity Classic Trade Show was the number of vendors offering products that turn atmospheric nitrogen into usabel nitrogen for crop use. These products are promised to boost crop yield, plus provide a more consistent and dependable nitrogen supply that isn’t lost due to leaching or volatilization. We caught up with three companies and learned more about their products. ','agriculture.com'),
            _newsbox('https://akm-img-a-in.tosshub.com/sites/btmt/images/stories/indian_farmer_660_220220051659.jpg','Govt pays over Rs 50,000 crore to farmers under PM-KISAN scheme','The Centre on Saturday said it has disbursed Rs 50,850 crore to farmers so far under its landmark scheme PM-KISAN, enabling them to meet farm input cost and household expenses. The agriculture ministry shared the progress made under the scheme, ahead of its first anniversary on February 24.','businnestoday.in'),
            //_newsbox('https://static.producer.com/wp-content/uploads/2020/03/28125239/51-4-col-RTS2D76Y.jpg','COVID-19 undermines Indian crop prices, derails rural rebound','MUMBAI, India (Reuters) — Indian farmer Banwarilal Bhardwaj was planning to buy a car after harvesting his winter-sown crops that were promising bumper returns.But the COVID-19 virus has shattered that dream, undermining farm commodity prices as it spreads around the world.“I can’t buy a car. Whatever I would earn, that will now be needed to repay a loan,” said Bhardwaj, who has planted rapeseed and chickpeas on his 15 acre farm in the northwestern state of Rajasthan.','News18.c0m'),
          ],
        ),
      )),
    );
  }
}
