import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:wallpapers/WallpaperHero.dart';

class WallpaperRoute extends StatefulWidget
{
  @override
  State<StatefulWidget> createState() {
    return new WallpaperRouteState();
  }
}

class WallpaperRouteState extends State<WallpaperRoute> {

  final databaseReference =
      FirebaseDatabase.instance.reference().child("sections/data/0");

  var index ;
  var url = "";
  var textData = "";
  var isFav = 0;

  StreamSubscription<Event> _ondataAdded;
  StreamSubscription<Event> _ondataChanged;

  Map<String, dynamic> finaldatafromFirebs;
  List<dynamic> dataWallpaper;

  WallpaperRouteState()
  {
    _ondataChanged = databaseReference.onChildChanged.listen(_onEntryEdited);
    _ondataAdded = databaseReference.onChildAdded.listen(_onEntryEdited);
  }

  @override
  Widget build(BuildContext context)
  {
    IconData favBlack =
    IconData(0xe87d, fontFamily: 'MaterialIcons');

    IconData favWhite =
    IconData(0xe87e, fontFamily: 'MaterialIcons');

    _onFavPressed(BuildContext context, int index)
    {
      print("isFav old >> " + isFav.toString());
      isFav = (isFav == 1) ? 0 : 1;
      databaseReference.child("data/" + index.toString()).child("isKey").set(isFav);
    }

    createChildElement(dynamic value, int index1)
    {
      void iterateMapEntry(key, value) {
        if (key == "data") {
          url = value;
        } else if (key == "author") {
          textData = value;
        } else if (key == "isFav") {
          isFav = value;
        } else {
          index = value;
        }
      }

      value.forEach(iterateMapEntry);

      var childImageContainer = new Hero(
          tag: "wallpaper" + index1.toString() ,
          child: new FadeInImage.assetNetwork(
            placeholder: "images/images.png",
            image: url,
          ));

      var text = new Text(textData);
      var favIcon = IconButton(
          tooltip: index.toString(),
          icon: new Icon(isFav == 1 ? favBlack : favWhite),
          onPressed: _onFavPressed(context, index1));

      var bottomContainer = new Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[text, favIcon]);

      return new GestureDetector(
        onTap: (){ onclickOfCard(index1); },
        child: new Card(
          semanticContainer: true,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          child: new Column(
              children: <Widget>[childImageContainer, bottomContainer]),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.0),
          ),
          elevation: 5,
          margin: EdgeInsets.all(3.0),
        ),
      );
    }

    var myGridView;
    if (dataWallpaper != null && !dataWallpaper.isEmpty) {
      myGridView = new StaggeredGridView.countBuilder(
        crossAxisCount: 4,
        padding: EdgeInsets.all(5.0),
        itemCount: dataWallpaper.length,
        itemBuilder: (BuildContext context, int index) =>
            new Container(child: createChildElement(dataWallpaper[index], index)),
        staggeredTileBuilder: (int index) => new StaggeredTile.fit(2),
        mainAxisSpacing: 5.0,
        crossAxisSpacing: 5.0,
      );
    }

    return new Scaffold(
      //appBar: new AppBar(title: new Text(AppUtil.App_Name)),
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

  void _onEntryEdited(Event event)
  {
    if (this.mounted) {
      setState(()
      {
        databaseReference.once().then((DataSnapshot snapshot) {
          Map<dynamic, dynamic> values = snapshot.value;
          void iterateMapEntry(key, value)
          {
            if (key == "data") {
              dataWallpaper = value;
            }
          }
          values.forEach(iterateMapEntry);
        });
      });
    }
  }

  void onclickOfCard(int index)
  {
    print("index >>  onclickOfCard >> " + index.toString());
    Map<dynamic, dynamic> obj = dataWallpaper[index];
    Navigator.push(
      context,
      //MaterialPageRoute(builder: (context) => SpringPage()),
      MaterialPageRoute(builder: (context) => WallpaperHero(obj, index))
    );

  }
}
