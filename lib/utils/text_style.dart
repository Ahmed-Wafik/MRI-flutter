import 'package:flutter/material.dart';

TextStyle firstTextStyle() => TextStyle(
    color:  Color.fromRGBO(0, 160, 163, 1),
    fontSize: 23,

    letterSpacing: .4,
    fontWeight: FontWeight.bold);

TextStyle secondTextStyle() =>
    TextStyle(color: Colors.blue, fontSize: 25, fontWeight: FontWeight.w600);
TextStyle callNowTextStyle() =>
    TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 19);
