// ignore_for_file: non_constant_identifier_names

import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:todoapp/SharedData/Todo_Data.dart';

class NetworkHelper {
  String baseUrl = "https://todo-yison.herokuapp.com/";

  Future<TodoData> getTodoData({String endpoint = ""}) async {
    var client = http.Client();
    TodoData TodoModel  = TodoData();
    try {
      final response = await client.get(
        Uri.parse(baseUrl + endpoint),
        headers: {"Content-Type": "application/json"},
      );
      if (response.statusCode == 200) {
        TodoModel = TodoData.fromJson(json.decode(response.body));
        return TodoModel;
      }
      return TodoModel;
    } catch (e) {
           print(e);
            return TodoModel;
      
    }
  }

  Future<TodoData> postTodoData(
      {String endpoint = "",
      required String title,
      required String description,
      bool? status,
      required String date_time}) async {
    var client = http.Client();
    var TodoModel = TodoData();
    try {
      final response = await client.post(Uri.parse(baseUrl + endpoint), headers: {
        "Content-Type": "application/json"
      }, body: {
        "title": title,
        "description": description,
        "status": status ?? false,
        "date_time": date_time
      });

      if (response.statusCode == 200) {
        TodoModel =  TodoData.fromJson(json.decode(response.body));
      } 
      return TodoModel;
    } catch (e) {
      print(e);
      return TodoModel;
    }
  }

  Future<TodoData> updateTodoData({
    String endpoint = "",
    required String id,
    String? title,
    String? description,
    bool? status,
    String? date_time,
  }) async {
    var client = http.Client();
    var TodoModel = TodoData();

    try {
      final response =
          await client.put(Uri.parse(baseUrl + endpoint + id), headers: {
        "Content-Type": "application/json"
      }, body: {
        "title": title ?? TodoData().title,
        "description": description ?? TodoData().description,
        "status": status ?? false,
        "date_time": date_time ?? TodoData().date
      });

      if (response.statusCode == 200) {
        TodoModel = TodoData.fromJson(json.decode(response.body));
      } 
      return TodoModel;
    } catch (e) {
      print(e);
      return TodoModel;
    }
  }




Future<TodoData> deleteTodoData({required String id}) async {
    var client = http.Client();
    var TodoModel = TodoData();
    try {
      final response = await client.delete(Uri.parse(baseUrl + id), headers: {
        "Content-Type": "application/json"
      });

      if (response.statusCode == 200) {
        TodoModel = TodoData.fromJson(json.decode(response.body));
      }
      return TodoModel;
    } catch (e) {
      print(e);
      return TodoModel;
    }
  }

}
