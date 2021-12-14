// ignore_for_file: file_names


class TodoData {
  String? id;
  String? title;
  String? description;
  String? status;
  String? date;

  TodoData({this.id, this.title, this.description, this.status, this.date});

  factory TodoData.fromJson(json) {
    return TodoData(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      status: json['status'] as String,
      date: json['date'] as String,
    );
  }
}
