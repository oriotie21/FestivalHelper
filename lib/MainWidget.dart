import 'package:flutter/material.dart';

class LargeTitle extends StatelessWidget {
  String title = "";

  LargeTitle(String s) {
    title = s;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Padding(
      padding: EdgeInsets.only(top: 0, bottom: 40, left: 20, right: 20),
      child: Text(
        title,
        style: TextStyle(fontSize: 50.0),
      ),
    );
  }
}