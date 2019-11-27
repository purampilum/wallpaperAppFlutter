import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:wallpapers/TabController.dart';
import 'package:wallpapers/firebaseModelClass.dart';

class MySuperClass extends InheritedWidget
{
  MyInheritedState data;
  Widget child;

  MySuperClass({
    Key key,
    @required Widget child,
    @required this.data,
  }) : super(key: key, child: child);

  @override
  bool updateShouldNotify(MySuperClass old)
  {
    return true;
  }
}

class MyInherited extends StatefulWidget
{
  Widget child;
  TABControllerState data;
  MyInherited({this.child, this.data});

  @override
  MyInheritedState createState() => new MyInheritedState(data);

  static MyInheritedState of(BuildContext context)
  {
    return (context.inheritFromWidgetOfExactType(MySuperClass) as MySuperClass).data;
  }
}

class MyInheritedState extends State<MyInherited>
{
  TABControllerState data;

  MyInheritedState(TABControllerState data)
  {
    this.data = data;
  }

  @override
  Widget build(BuildContext context)
  {
    return new MySuperClass(
      data : this,
      child: widget.child,
    );
  }
}
