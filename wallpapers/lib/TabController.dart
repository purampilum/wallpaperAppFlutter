import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wallpapers/AppUtil.dart';
import 'package:wallpapers/MySuperClass.dart';
import 'package:wallpapers/favroute.dart';
import 'package:wallpapers/firebaseModelClass.dart';
import 'package:wallpapers/quotesroute.dart';
import 'package:wallpapers/storyroute.dart';
import 'package:wallpapers/wallpaperroute.dart';
import 'package:bubble_tab_indicator/bubble_tab_indicator.dart';

class TABController extends StatefulWidget {
  WallpaperModel wallpaperModel;
  List sectioncolor;
  List<String> sectionNames;
  String value;

  TABController(WallpaperModel wallpaperModel, List sectioncolor,
      List<String> sectionNames, String value) {
    this.wallpaperModel = wallpaperModel;
    this.sectioncolor = sectioncolor;
    this.sectionNames = sectionNames;
    this.value = value;
  }

  @override
  State<StatefulWidget> createState() {
    return new TABControllerState(
        wallpaperModel, sectioncolor, sectionNames, value);
  }

}

class TABControllerState extends State<TABController>
    with TickerProviderStateMixin {
  WallpaperModel wallpaperModel;
  List sectioncolor;
  List<String> sectionNames;
  String value;
  TabController tabController;
  Color indicatorColor;

  TABControllerState(WallpaperModel wallpaperModel, List sectioncolor,
      List<String> sectionNames, String value) {
    this.wallpaperModel = wallpaperModel;
    this.sectioncolor = sectioncolor;
    this.sectionNames = sectionNames;
    this.value = value;
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
          home: DefaultTabController(
            length: sectionNames.length,
            child: Scaffold(
              appBar: AppBar(
                  backgroundColor: AppUtil.App_color,
                  title: new Text(AppUtil.App_Name),
                  leading: IconButton(
                    icon: Icon(Icons.arrow_back),
                    onPressed: () => Navigator.pop(context, false),
                  ),
                  bottom: TabBar(
                    isScrollable: true,
                    onTap: onTapofTab(),
                    //indicatorSize: TabBarIndicatorSize.tab,
                    controller: tabController,
                    indicatorColor: Colors.white,
                    labelPadding: EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
                    unselectedLabelColor: Colors.white.withOpacity(0.3),
                    indicator: bubbleTabindecator(),
                    tabs: getListofTabs(),
                  )),
              body: tabBarView(),
            ),
          ),
        );
  }


  tabBarView() {
    return TabBarView(
      controller: tabController,
      children: <Widget>[WallpaperRoute(),QuotesRoute(), StoryRoute(), FavRoute()],
    );
  }

  bubbleTabindecator() // bubble tabIndecator
  {
    return BubbleTabIndicator(
      indicatorHeight: 40.0,
      indicatorColor: indicatorColor,
      tabBarIndicatorSize: TabBarIndicatorSize.tab,
    );
  }

  List<Widget> getListofTabs() {
    List<Widget> tabs = [];
    for (var i = 0; i < sectionNames.length; i++) {
      tabs.add(Tab(
          child: Text(sectionNames[i], style: new TextStyle(fontSize: 25.0))));
    }
    return tabs;
  }

  @override
  void initState() {
    var index = sectionNames.indexOf(value);
    tabController = new TabController(length: sectionNames.length, vsync: this);
    tabController.animateTo(index);
    tabController.addListener(onTapofTab);
    super.initState();
  }

  onTapofTab()
  {
    var index = tabController.index;
    tabController.animateTo(index);
    print("onTapofTab called >> " + index.toString());
    setState(()
    {
      indicatorColor = AppUtil.hexToColor(sectioncolor[index]);
    });
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
