import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading2 extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      color: Colors.black,
      child: Center(
        child: SpinKitChasingDots(
          color: Colors.blue,
          size: 50,
        ),
      ),
    );
  }

}