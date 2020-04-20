import 'package:auto_size_text/auto_size_text.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:flutter/material.dart';
import 'package:gexxx_flutter/models/user.dart';
import 'package:gexxx_flutter/screens/Home.dart';
import 'package:gexxx_flutter/screens/MainDrawer.dart';
import 'package:gexxx_flutter/screens/NewsPage.dart';
import 'package:gexxx_flutter/screens/UserpProfile.dart';
import 'package:gexxx_flutter/services/auth.dart';
import 'package:provider/provider.dart';

class DashboardPage extends StatefulWidget {
  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  void changeBrightness() {
    DynamicTheme.of(context).setBrightness(
        Theme.of(context).brightness == Brightness.dark
            ? Brightness.light
            : Brightness.dark);
  }
  void changeColor() {
    DynamicTheme.of(context).setThemeData(ThemeData(
        primaryColor: Theme.of(context).primaryColor == Colors.indigo
            ? Colors.red
            : Colors.indigo));
  }

  int CurrentIndex = 0;
  GlobalKey _bottomNavigationKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    final AuthService _auth = AuthService();

    final tabs = [
      Home(user: user),
      NewsPage(),
      Container(
        color: Colors.black,
        child: Center(
            child: Text(
          'p',
          style: TextStyle(color: Colors.white),
        )),
      ),
      Container(
        color: Colors.black,
        child: Center(
            child: Text(
          's',
          style: TextStyle(color: Colors.white),
        )),
      ),
      UserProfile(user: user),
    ];
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          /*FlatButton.icon(
                      onPressed: () async {
                        await _auth.signOut();
                      },
                      icon: Icon(
                        Icons.arrow_back_ios,
                        color: Colors.white,
                      ),
                      label: AutoSizeText(
                        'Logout',
                        maxLines: 1,
                        style: TextStyle(color: Colors.white,fontSize: 15),
                      ))*/
          IconButton(icon: Icon(Theme.of(context).brightness==Brightness.light?Icons.lightbulb_outline:Icons.highlight), onPressed: (){
            DynamicTheme.of(context).setBrightness(Theme.of(context).brightness==Brightness.light?Brightness.dark:Brightness.light);
          })
        ],
        title: Text('GEXXX'),
      ),
      drawer: MainDrawer(),
      bottomNavigationBar: CurvedNavigationBar(
        key: _bottomNavigationKey,
        index: 0,
        height: 70.0,
        items: <Widget>[
          Icon(
            Icons.home,
            size: 30,
            color: Colors.white,
          ),
          Icon(
            Icons.event,
            size: 30,
            color: Colors.white,
          ),
          Icon(
            Icons.event_note,
            size: 30,
            color: Colors.white,
          ),
          Icon(
            Icons.call_split,
            size: 30,
            color: Colors.white,
          ),
          Icon(
            Icons.perm_identity,
            size: 30,
            color: Colors.white,
          ),
        ],
        color: Colors.grey[800],
        buttonBackgroundColor: Colors.grey[800],
        backgroundColor: Colors.black,
        animationCurve: Curves.easeInOut,
        animationDuration: Duration(milliseconds: 600),
        onTap: (index) {
          setState(() {
            CurrentIndex = index;
          });
        },
      ),
      body: tabs[CurrentIndex],
    );
  }
}
