
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wallpapers/MySuperClass.dart';
import 'package:wallpapers/firebaseModelClass.dart';

class StoryRoute extends StatefulWidget
{
  StoryRoute();

  @override
  State<StatefulWidget> createState()
  {
    // TODO: implement createState
    return new StoryRouteState();
  }
}

class StoryRouteState extends State<StoryRoute>
{

  StoryRouteState()
  {

  }

  @override
  Widget build(BuildContext context)
  {
    var myGridView = new Container(
      child: new Text("Story"),
    );

    return new Scaffold(
      body: myGridView,
    );
  }


  @override
  void dispose()
  {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }
}