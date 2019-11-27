import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wallpaper/wallpaper.dart';
import 'package:wallpapers/MySuperClass.dart';
import 'package:rubber/rubber.dart';

class WallpaperHero extends StatefulWidget {
  Map<dynamic, dynamic> obj;
  int index;
  WallpaperHero(Map<dynamic, dynamic> obj, int index) {
    this.obj = obj;
    this.index = index;
  }

  @override
  State<StatefulWidget> createState()
  {
    return new WallpaperHeroState(obj, index);
  }
}

class WallpaperHeroState extends State<WallpaperHero>
    with SingleTickerProviderStateMixin
{
  static const IconData favBlack =
      IconData(0xe87d, fontFamily: 'MaterialIcons');

  Map<dynamic, dynamic> obj;
  int index;
  var result = "Waiting to set wallpaper";

  RubberAnimationController _controller;
  double _dampingValue = DampingRatio.LOW_BOUNCY;
  double _stiffnessValue = Stiffness.VERY_LOW;

  WallpaperHeroState(Map<dynamic, dynamic> obj, int index)
  {
    this.obj = obj;
    this.index = index;
  }

  @override
  Widget build(BuildContext context) {
    var url = "";

    void iterateMapEntry(key, value) {
      if (key == "data") {
        url = value;
      }
    }

    obj.forEach(iterateMapEntry);

    var reaisedButton = new FlatButton(
      padding: const EdgeInsets.all(8.0),
      textColor: Colors.white,
      color: Colors.transparent,
      onPressed: () {
        onPressSetWallpaper(url);
      },
      child: new Text("Set as Wallpaper"),
    );

    var childImageContainer = new Hero(
        tag: "wallpaper" + index.toString(),
        child: new FadeInImage.assetNetwork(
            placeholder: "images/images.png",
            image: url,
            fit: BoxFit.fitHeight));

    Widget _getUpperLayer()
    {
      return Container(
        color: Colors.black38.withOpacity(0.2),

      );
    }

    return new Container(
        child: new Stack(fit: StackFit.expand, children: <Widget>[
      childImageContainer,
      new Scaffold(
          backgroundColor: Colors.transparent,
          appBar: new AppBar(
              backgroundColor: Colors.black38.withOpacity(0.4),
              elevation: 0.0,
              actions: <Widget>[reaisedButton],
              leading: IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () => Navigator.pop(context, false),
              )),
          body: Column(
            children: <Widget>[
              Expanded(
                child: RubberBottomSheet(
                  lowerLayer: Container(),
                  upperLayer: _getUpperLayer(),
                  animationController: _controller,
                ),
              ),
            ],
          ))
    ]));
  }



  @override
  void initState() {
    _controller = RubberAnimationController(
      vsync: this,
    );

    super.initState();
  }

  void onPressSetWallpaper(String url) async {
    String res;
    res = await Wallpaper.homeScreen(url);
    if (!mounted) return;
    setState(() {
      result = res.toString();
    });
  }
}
