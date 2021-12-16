// ignore_for_file: file_names

import 'dart:convert';

class TodoData {
  bool? status;
  String? message;
  List<DataList>? data;

  TodoData({this.status, this.message, this.data});

  factory TodoData.fromJson(json) {
    return TodoData(
      message: json["message"],
      status: json["status"],
      data: List<DataList>.from(json["data"].map((x) => DataList.fromJson(x))),
    );
  }
}

class DataList {
  String? id;
  String? title;
  String? description;
  bool? status;
  String? date;

  DataList({this.id, this.title, this.description, this.status, this.date});

  factory DataList.fromJson(json) {
    return DataList(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        status: json["status"],
        date: json["date_time"]);
  }
}
