import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:flutter/material.dart';
import 'package:gexxx_flutter/screens/Languagepage.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:gexxx_flutter/screens/wrapper.dart';
import 'package:gexxx_flutter/services/auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:provider/provider.dart';
import 'app_localizations.dart';

import 'models/user.dart';




//testing docker!!!!
void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  MyApp({Key key}) : super(key: key);

   static void setLocale(BuildContext context, Locale newLocale) async {
      _MyAppState state =
           context.findAncestorStateOfType<_MyAppState>();
        state.changeLanguage(newLocale);
     }
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

 Locale locale;
 changeLanguage(Locale locale) {
     setState(() {
      this.locale = locale;
     });
    }

  @override
  void initState() {
    super.initState();
    this._fetchLocale().then((locale) {
      setState(() {
        this.locale = locale;
      });
    });
  }

 _fetchLocale() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //print(prefs.getString('language_code')+"temp");
    //print(prefs.getString('country_code'));
    if(prefs.getString('language_code') == null)
    {
      return null;
    }
    return Locale(prefs.getString('language_code'), 
      prefs.getString('country_code'));
  }


  @override
  Widget build(BuildContext context) {
        if(this.locale == null)
        {
        return new DynamicTheme(
          defaultBrightness: Brightness.dark,
          data: (brightness) => new ThemeData(
            primarySwatch: Colors.teal,
            brightness: brightness,
          ),
          themedWidgetBuilder: (context, theme) {
            return StreamProvider<User>.value(
                value: AuthService().user,
                child: MaterialApp(
                  locale: Locale("en","IN"),
                  supportedLocales: [
              Locale('en','IN'),
              Locale('hi','IN')
            ],
            localizationsDelegates: [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
            ],
            localeListResolutionCallback: (locale, supportedLocales){
               print(locale);
               print(supportedLocales.elementAt(0));
               print(supportedLocales);
               var it = supportedLocales.iterator;
               while(it.moveNext())
               {
                 print(it.current.languageCode);
                 if(it.current.languageCode == locale[0].languageCode)
                 {
                   return locale[0];
                 }
               }
               return supportedLocales.elementAt(0);
            },
                  debugShowCheckedModeBanner: false,
                  home: Wrapper(),
                  theme: theme,
                ));
          }
        );
        }
        else
        {
          return new DynamicTheme(
          defaultBrightness: Brightness.dark,
          data: (brightness) => new ThemeData(
            primarySwatch: Colors.teal,
            brightness: brightness,
          ),
          themedWidgetBuilder: (context, theme) {
            return StreamProvider<User>.value(
                value: AuthService().user,
                child: MaterialApp(
                  locale: this.locale,
                  supportedLocales: [
              Locale('en','IN'),
              Locale('hi','IN')
            ],
            localizationsDelegates: [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
            ],
            localeListResolutionCallback: (locale, supportedLocales){
               print(locale);
               print(supportedLocales.elementAt(0));
               print(supportedLocales);
               var it = supportedLocales.iterator;
               while(it.moveNext())
               {
                 print(it.current.languageCode);
                 if(it.current.languageCode == locale[0].languageCode)
                 {
                   return locale[0];
                 }
               }
               return supportedLocales.elementAt(0);
            },
                  debugShowCheckedModeBanner: false,
                  home: Wrapper(),
                  theme: theme,
                ));
          }
        );
        }
      }
}