import 'package:firebase_database/firebase_database.dart';

class WallpaperModel
{
  Sections sections;
  WallpaperModel({this.sections});

  WallpaperModel.fromSnapshot(DataSnapshot snapshot)
  {
    var snap = snapshot.value['data'];
    sections = new Sections.fromSnapshot(snap);
  }

  Sections get getSection => sections;

  Map<String, dynamic> toJson()
  {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.sections != null) {
      data['sections'] = this.sections.toJson();
    }
    return data;
  }
}

class Sections
{
  List<Data> data;
  Sections(List<dynamic> data) {}

  List<Data> get getSectionList => data;

  Sections.fromSnapshot(List<dynamic> snapshot) {
    //Map<String, dynamic> json = snapshot.ch;
    if (snapshot != null) {
      data = new List<Data>();
      snapshot.forEach((v) {
        data.add(new Data.fromSnapshot(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data
{
  String colorcode;
  List<Data2> data = new List();
  String id;

  Data({this.colorcode, this.data, this.id});

  String get getSectionColor => colorcode;
  List<Data2> get getSectionData => data;
  String get getSectionsID => id;

  Data.fromSnapshot(Map<dynamic, dynamic> snapshot)
  {
    snapshot.entries.forEach((f)
    {
      if (f.key == "colorcode") {
        this.colorcode = f.value;
      } else if (f.key == "id") {
        this.id = f.value;
      } else
      {
        List<dynamic> snapshot1 = f.value;
        if(snapshot1!=null){  data.add( new Data2.fromSnapshot(snapshot1) );  }
      }
    });
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['colorcode'] = this.colorcode;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    data['id'] = this.id;
    return data;
  }
}

class Data2 {
  String author;
  String data;
  String id;
  int isFav;

  String get author_get => author;
  String get data_get => data;
  String get id_get => id;
  int get isFav_grt => isFav;

  Data2();

  Data2.fromSnapshot(List<dynamic> snapshot)
  {
    snapshot.forEach((f)
    {
      Map<dynamic, dynamic> internal = f;
      internal.entries.forEach((v)
      {
        if (v.key == "author")
        {
          this.author = v.value;
        } else if (v.key == "data")
        {
          this.data = v.value;
        } else if (v.key == "id")
        {
          this.id = v.value;
        } else if (v.key == "isFav")
        {
          this.isFav = v.value;
        }
      });
    });
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['author'] = this.author;
    data['data'] = this.data;
    data['id'] = this.id;
    data['isFav'] = this.isFav;
    return data;
  }
}
