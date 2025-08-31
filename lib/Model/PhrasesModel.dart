class PhrasesModel {
  List<Data>? data;

  PhrasesModel({this.data});

  PhrasesModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? title;
  List<Subdata>? subdata;

  Data({this.title, this.subdata});

  Data.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    if (json['subdata'] != null) {
      subdata = <Subdata>[];
      json['subdata'].forEach((v) {
        subdata!.add(new Subdata.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    if (this.subdata != null) {
      data['subdata'] = this.subdata!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Subdata {
  String? title;
  List<String>? subData;

  Subdata({this.title, this.subData});

  Subdata.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    subData = json['SubData'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['SubData'] = this.subData;
    return data;
  }
}
