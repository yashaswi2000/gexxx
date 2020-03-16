import 'package:flutter/material.dart';

class Settings extends StatelessWidget {
  String tittle;

  Settings(this.tittle);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text(tittle),
      ),
      body: Center(child: Text(tittle),),
    );
  }
}
