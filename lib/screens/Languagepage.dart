import 'package:flutter/material.dart';
import 'package:gexxx_flutter/main.dart';
import 'package:gexxx_flutter/models/language.dart';
import 'package:gexxx_flutter/screens/authenticate/login2.dart';
import 'package:gexxx_flutter/utilities/MyVerticalDivider.dart';
import 'package:gexxx_flutter/utilities/MyhorizantalDivider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LanguagePage extends StatefulWidget {
  @override
  _LanguagePageScreenState createState() => _LanguagePageScreenState();
}

class _LanguagePageScreenState extends State<LanguagePage> {
  List<Language> languages;

  @override
  void initState() {
    super.initState();
    languages = Language.getLanguages();
  }

  bool isSelected = false;
  String LanguageSelected;
  int selectedindex;
  bool visible = false;
  Widget _languagebox(String one, String two, int index, int selecteditem) {
    return Container(
      decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: Colors.white, width: 1))),
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.07,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.only(left: 20.0, right: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                one,
                style: TextStyle(
                  color: index == selecteditem ? Colors.blue : Colors.black,
                ),
              ),
              SizedBox(
                width: 20,
              ),
              Text(
                '-',
                style: TextStyle(color: Colors.black),
              ),
              SizedBox(
                width: 20,
              ),
              Text(
                two,
                style: TextStyle(
                    color: index == selecteditem ? Colors.blue : Colors.black,
                    fontSize: 20),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 30.0, left: 10, right: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Please Select your Language',
                  style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'OpenSans',
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 50,
                ),
                ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: languages.length,
                    itemBuilder: (BuildContext context, int index) {
                      return InkWell(
                        onTap: () {
                          setState(() {
                            visible = false;
                            languages[index].Selected = true;
                            LanguageSelected = languages[index].Name;
                            selectedindex = index;
                          });
                        },
                        child: _languagebox(
                            languages[index].Name,
                            languages[index].TranslatedName,
                            index,
                            selectedindex),
                      );
                    }),
                SizedBox(height: 20),
                Visibility(
                  child: Center(
                    child: Text(
                      'Please select language',
                      style: TextStyle(
                          color: Colors.red, fontWeight: FontWeight.bold),
                    ),
                  ),
                  visible: visible,
                ),
                SizedBox(
                  height: 20,
                ),
                FloatingActionButton.extended(
                  backgroundColor: Colors.grey[800],
                  isExtended: true,
                  label: Text(
                    'Next',
                    style: TextStyle(color: Colors.white),
                  ),
                  elevation: 2,
                  tooltip: 'next',
                  onPressed: () async {
                    print(selectedindex);
                    if (selectedindex != null) {
                      Locale newLocale =
                          Locale(languages[selectedindex].code, 'IN');
                      SharedPreferences prefs =
                          await SharedPreferences.getInstance();
                      prefs.setString(
                          'language_code', languages[selectedindex].code);
                      prefs.setString('country_code', "IN");
                      MyApp.setLocale(context, newLocale);
                      Navigator.pop(context);
                    } else {
                      setState(() {
                        visible = true;
                      });
                    }

                    //Navigator.pop(context);
                  },
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5)),
                  icon: Icon(
                    Icons.arrow_forward,
                    color: Colors.white,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
