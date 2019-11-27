import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:wallpapers/AppUtil.dart';
import 'package:wallpapers/firebaseModelClass.dart';
import 'package:flutter/material.dart';
import 'package:wallpapers/TabController.dart';

class Wallpaper extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new WallpaperState();
  }
}

class WallpaperState extends State<Wallpaper>
{
  final databaseReference = FirebaseDatabase.instance.reference();
  StreamSubscription<Event> _ondataAdded;
  StreamSubscription<Event> _ondataChanged;
  WallpaperModel wallpaperModel;
  Map<String, dynamic> finaldatafromFirebs;

  WallpaperState() {
    _ondataChanged = databaseReference.onChildChanged.listen(_onEntryEdited);
    _ondataAdded = databaseReference.onChildAdded.listen(_onEntryEdited);
  }

  @override
  Widget build(BuildContext context) {
    List<String> sectionNames = new List();
    var sectioncolor = [];

    if (wallpaperModel != null) {
      List<Data> ob = wallpaperModel.sections.getSectionList;

      ob.forEach((data) {
        sectioncolor.add(data.getSectionColor);
        sectionNames.add(data.getSectionsID);
      });
    }
    var size = MediaQuery.of(context).size;

    /*24 is for notification bar on Android*/
    final double itemHeight = (size.height - kToolbarHeight - 24) / 2;
    final double itemWidth = size.width / 2;
    var index = -1;

    var myGridView = new Container(
      child: new GridView.count(
        crossAxisCount: 2,
        childAspectRatio: (itemWidth / itemHeight),
        controller: new ScrollController(keepScrollOffset: false),
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        children: sectionNames.map((String value) {
          index++;
          return new Material(
              color: AppUtil.hexToColor(sectioncolor[index]),
              child: InkWell(
                  onTap: () {
                    _onClicOfDashboardBox(
                        wallpaperModel, sectioncolor, sectionNames, value);
                  },
                  radius: 250,
                  child: Container(
                    margin: new EdgeInsets.all(2.0),
                    child: new Center(
                      child: new Text(
                        value.toUpperCase(),
                        style: new TextStyle(
                          fontSize: 30.0,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  )));
        }).toList(),
      ),
    );

    return new Scaffold(
      appBar: new AppBar(title: new Text(AppUtil.App_Name)),
      body: myGridView,
    );
  }

  @override
  void dispose() {
    _ondataChanged.cancel();
    _ondataAdded.cancel();
    super.dispose();
  }

  @override
  void initState() {
    _ondataChanged = databaseReference.onChildChanged.listen(_onEntryEdited);
    _ondataAdded = databaseReference.onChildAdded.listen(_onEntryEdited);
    super.initState();
  }

  void _onEntryEdited(Event event) {
    setState(() {
      var a = "";
      wallpaperModel = new WallpaperModel.fromSnapshot(event.snapshot);
      finaldatafromFirebs = wallpaperModel.toJson();
      a = finaldatafromFirebs.toString();
      print(" >>> data ::: " + a);
    });
  }

  void _onClicOfDashboardBox(WallpaperModel wallpaperModel, List sectioncolor,
      List<String> sectionNames, String value)
  {
    var material = MaterialPageRoute(
        builder: (context) =>
            TABController(wallpaperModel, sectioncolor, sectionNames, value));

//    if (value.contains("Favourites".toUpperCase())) {
//      material = MaterialPageRoute(
//          builder: (context) =>
//              TABController(wallpaperModel, sectioncolor, sectionNames, value));
//    } else if (value.contains("Quotes".toUpperCase())) {
//      material = MaterialPageRoute(
//          builder: (context) =>
//              TABController(wallpaperModel, sectioncolor, sectionNames, value));
//    } else if (value.contains("Wallpaper".toUpperCase())) {
//      material = MaterialPageRoute(
//          builder: (context) =>
//              TABController(wallpaperModel, sectioncolor, sectionNames, value));
//    } else {
//      material = MaterialPageRoute(
//          builder: (context) =>
//              TABController(wallpaperModel, sectioncolor, sectionNames, value));
//    }

    Navigator.push(context, material);
  }
}
