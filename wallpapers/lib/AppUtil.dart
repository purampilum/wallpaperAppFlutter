import 'package:flutter/material.dart';

class AppUtil
{
  static Color hexToColor(String code) {
    return new Color(int.parse(code.substring(1, 7), radix: 16) + 0xFF000000);
  }

  static final String App_Name = "App Name";
  static final Color App_color =  Colors.deepOrangeAccent;


}

