
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wallpapers/firebaseModelClass.dart';

class FavRoute extends StatefulWidget
{
  FavRoute();

  @override
  State<StatefulWidget> createState()
  {
    // TODO: implement createState
    return new FavRouteState();
  }
}

class FavRouteState extends State<FavRoute>
{

  FavRouteState()
  {

  }

  @override
  Widget build(BuildContext context)
  {
    var myGridView = new Container(
      
      child: new Text("Favorites"),
      
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