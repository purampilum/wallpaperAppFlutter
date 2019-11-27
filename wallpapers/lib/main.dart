
import 'package:flutter/material.dart';
import 'package:wallpapers/AppUtil.dart';
import 'package:wallpapers/DashboardRoute.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget
{
  @override
  Widget build(BuildContext context)
  {
    return new MaterialApp(
      title: 'Home',
      home: new Wallpaper(),
      theme: new ThemeData(primaryColor: AppUtil.App_color ),
    );
  }
}

