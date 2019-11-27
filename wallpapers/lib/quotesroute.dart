import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wallpapers/AppUtil.dart';
import 'package:wallpapers/firebaseModelClass.dart';

class QuotesRoute extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new QuotesRouteState();
  }
}

class QuotesRouteState extends State<QuotesRoute> {
  final databaseReference =
      FirebaseDatabase.instance.reference().child("sections/data/1");
  List<dynamic> quotesList;
  String color = "";

  StreamSubscription<Event> _ondataAdded;
  StreamSubscription<Event> _ondataChanged;

  QuotesRouteState() {
    _ondataChanged = databaseReference.onChildChanged.listen(_onEntryEdited);
    _ondataAdded = databaseReference.onChildAdded.listen(_onEntryEdited);
  }

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);

    return new Scaffold(
        backgroundColor: AppUtil.hexToColor(color).withOpacity(0.50),
        body: ListViewItem);
  }

  Widget get ListViewItem {
    return ListView.builder(
        itemCount: quotesList.length,
        padding: const EdgeInsets.all(10.0),
        itemBuilder: (BuildContext context, int index) => getListItems(index));
  }

  Widget ImageItem(data)
  {
    var url;
    Map<dynamic, dynamic> values = data;
    void iterateMapEntry(key, value) {
      if (key == "id") {
        url = value;
      }
    }
    values.forEach(iterateMapEntry);
    return new Container(
        width: 90,
        height: 90,
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
              fit: BoxFit.cover,
              image: NetworkImage(url ?? ''),
            )));
  }

  Widget getListItems(index) {
    var data = quotesList[index];
    return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            height: 250.0,
            color: Colors.transparent,
            child: Stack(
              children: <Widget>[
                Positioned(
                  left: 40.0,
                  child: getCardItem(data),
                ),
                Positioned(top: 13, child: ImageItem(data)),
              ],
            ),
          ),
        ]);
  }

  Widget getCardItem(data) {
    var text;
    var author;
    Map<dynamic, dynamic> values = data;
    void iterateMapEntry(key, value) {
      if (key == "author") {
        author = value;
      } else if (key == "data") {
        text = value;
      }
    }
    values.forEach(iterateMapEntry);

    return Container(
      constraints:
          BoxConstraints(maxWidth: 350.0, minWidth: 350.0, minHeight: 115),
      child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          elevation: 6,
          color: AppUtil.hexToColor(color),
          child: Padding(
            padding: const EdgeInsets.only(
              top: 15.0,
              right: 15.0,
              left: 50.0,
            ),
            child: Column(
              children: <Widget>[
                Text(text,
                    style: TextStyle(color: Colors.white, fontSize: 20.0)),
                Text("- " + author, style: TextStyle(color: Colors.white)),
              ],
            ),
          )),
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
    if (this.mounted) {
      setState(() {
        databaseReference.once().then((DataSnapshot snapshot) {
          Map<dynamic, dynamic> values = snapshot.value;
          void iterateMapEntry(key, value) {
            if (key == "data") {
              quotesList = value;
            } else if (key == "colorcode") {
              color = value;
              print("color code" + color);
            }
          }

          values.forEach(iterateMapEntry);
        });
      });
    }
  }
}
