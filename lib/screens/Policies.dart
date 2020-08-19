import 'package:flutter/material.dart';
import 'package:gexxx_flutter/app_localizations.dart';
import 'package:gexxx_flutter/screens/schema.dart';

class Policies extends StatefulWidget {
  @override
  _PoliciesState createState() => _PoliciesState();
}

class _PoliciesState extends State<Policies> {
  Widget category(String name, Function function) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0, left: 10, right: 10),
      child: InkWell(
        onTap: function,
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 0.06,
          decoration: BoxDecoration(
              color: Colors.blue,
              boxShadow: [
                BoxShadow(
                    color: Colors.grey[200], spreadRadius: 1, blurRadius: 5)
              ],
              borderRadius: BorderRadius.circular(5)),
          child: Center(
            child: Text(
              name,
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
      ),
    );
  }

  List<String> categories;
  @override
  void initState() {
    // TODO: implement initState

    super.initState();

    categories = [
      'Agricultural Marketing',
      'International Cooperation',
      'Agriculture Census',
      'Budget',
      'Natural Resource Management',
      'Cooperation',
      'Official Language',
      'Credit',
      'Oilseeds Divisions',
      'Crops & NFSM',
      'Plan Coordination',
      'Drought Management',
      'Plant Protection',
      'Economic Administration',
      'Policy',
      'Extension',
      'Rainfed Farming System',
      'General Administration',
      'Rashtriya Krishi Vikas Yojana',
      'General Coordination',
      'Seeds',
      'Horticulture',
      'Trade',
      'Integrated Nutrient Management',
      'Vigilance'
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
                      onPressed: () {},
                    ),
                    Text(
                      AppLocalizations.of(context).translate('Policies'),
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
              SizedBox(
                height: 10,
              ),
              ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: categories.length,
                  itemBuilder: (c, i) {
                    return category(categories[i], () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Schema(
                                    category: categories[i],
                                  )));
                    });
                  })
            ],
          ),
        ),
      ),
    );
  }
}
