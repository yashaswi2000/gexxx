// Copyright 2019 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:gexxx_flutter/database/database.dart';
import 'package:gexxx_flutter/models/user.dart';
import 'package:gexxx_flutter/screens/Home.dart';
import 'package:gexxx_flutter/screens/UserpProfile.dart';
import 'package:gexxx_flutter/services/auth.dart';
import 'package:provider/provider.dart';

enum BottomNavigationDemoType {
  withLabels,
  withoutLabels,
}

class BottomNavigationDemo extends StatefulWidget {
  const BottomNavigationDemo({Key key, @required this.type}) : super(key: key);

  final BottomNavigationDemoType type;

  @override
  _BottomNavigationDemoState createState() => _BottomNavigationDemoState();
}

class _BottomNavigationDemoState extends State<BottomNavigationDemo>
    with TickerProviderStateMixin {
  int _currentIndex = 0;
  List<_NavigationIconView> _navigationViews;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_navigationViews == null) {
      _navigationViews = <_NavigationIconView>[
        _NavigationIconView(
          icon: const Icon(Icons.home),
          title: 'Home',
          vsync: this,
        ),
        _NavigationIconView(
          icon: const Icon(Icons.calendar_today),
          title: 'aaa',
          vsync: this,
        ),
        _NavigationIconView(
          icon: const Icon(Icons.account_circle),
          title: 'aaa',
          vsync: this,
        ),
        _NavigationIconView(
          icon: const Icon(Icons.alarm_on),
          title: 'aaa',
          vsync: this,
        ),
        _NavigationIconView(
          icon: const Icon(Icons.people),
          title: 'Profile',
          vsync: this,
        ),
      ];

      _navigationViews[_currentIndex].controller.value = 1;
    }
  }

  @override
  void dispose() {
    for (final view in _navigationViews) {
      view.controller.dispose();
    }
    super.dispose();
  }

  Widget _buildTransitionsStack(UserData userdata) {
    final transitions = <FadeTransition>[];
    List<Widget> bodys = [
      Home(
        userData: userdata,
      ),
      Container(),
      Container(),
      Container(),
      UserProfile(
        userData: userdata,
      ),
    ];
    int i = 0;
    for (final view in _navigationViews) {
      transitions.add(view.transition(context, bodys[i]));
      i++;
    }

    // We want to have the newly animating (fading in) views on top.
    transitions.sort((a, b) {
      final aAnimation = a.opacity;
      final bAnimation = b.opacity;
      final aValue = aAnimation.value;
      final bValue = bAnimation.value;
      return aValue.compareTo(bValue);
    });

    return Stack(children: transitions);
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    final AuthService _auth = AuthService();

    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    var bottomNavigationBarItems = _navigationViews
        .map<BottomNavigationBarItem>((navigationView) => navigationView.item)
        .toList();
    if (widget.type == BottomNavigationDemoType.withLabels) {
      bottomNavigationBarItems =
          bottomNavigationBarItems.sublist(0, _navigationViews.length - 2);
      _currentIndex =
          _currentIndex.clamp(0, bottomNavigationBarItems.length - 1).toInt();
    }

    return StreamBuilder<UserData>(
        stream: DatabaseService(uid: user.uid).userData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            UserData userData = snapshot.data;
            return Scaffold(
              body: Center(
                child: _buildTransitionsStack(userData),
              ),
              bottomNavigationBar: BottomNavigationBar(
                showUnselectedLabels:
                    widget.type == BottomNavigationDemoType.withLabels,
                items: bottomNavigationBarItems,
                currentIndex: _currentIndex,
                type: BottomNavigationBarType.fixed,
                selectedFontSize: textTheme.caption.fontSize,
                unselectedFontSize: textTheme.caption.fontSize,
                onTap: (index) {
                  setState(() {
                    _navigationViews[_currentIndex].controller.reverse();
                    _currentIndex = index;
                    _navigationViews[_currentIndex].controller.forward();
                  });
                },
                selectedItemColor: colorScheme.onPrimary,
                unselectedItemColor: colorScheme.onPrimary.withOpacity(0.38),
                backgroundColor: Colors.black,
              ),
            );
          } else {
            return Container(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
        });
  }
}

class _NavigationIconView {
  _NavigationIconView({
    this.title,
    this.icon,
    TickerProvider vsync,
  })  : item = BottomNavigationBarItem(
          icon: icon,
          title: Text(title),
        ),
        controller = AnimationController(
          duration: kThemeAnimationDuration,
          vsync: vsync,
        ) {
    _animation = controller.drive(CurveTween(
      curve: const Interval(0.5, 1.0, curve: Curves.fastOutSlowIn),
    ));
  }

  final String title;
  final Widget icon;
  final BottomNavigationBarItem item;
  final AnimationController controller;
  Animation<double> _animation;

  FadeTransition transition(BuildContext context, Widget body) {
    return FadeTransition(
      opacity: _animation,
      child: ExcludeSemantics(child: body),
    );
  }
}
