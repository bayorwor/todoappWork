// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:todoapp/SharedData/Todo_Data.dart';

class TodoCard extends StatelessWidget {
  final DataList Tododata;
  const TodoCard({Key? key, required this.Tododata}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      shadowColor: Colors.blue[200],
      margin: EdgeInsets.all(10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        leading: const Icon(
          Icons.check_circle_outline,
          color: Color(0xFFEF31F3),
          size: 27.5,
        ),
        title:  Padding(
          padding: EdgeInsets.only(bottom: 10),
          child: Text(
            Tododata.title.toString(),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(fontSize: 20, color: Color(0xFF40586F)),
          ),
        ),
        subtitle: Text(Tododata.description.toString()),
        trailing: SizedBox(
          width: 100,
          child: Row(
            children: [
              Expanded(
                child: Icon(
                  Icons.notifications_none_outlined,
                  color: Color(0xFFEF31F3),
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                child: Text(
                  Tododata.date.toString(),
                  style: TextStyle(color: Color(0xFFEF31F3)),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
