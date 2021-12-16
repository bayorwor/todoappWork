// ignore_for_file: prefer_const_constructors, void_checks, avoid_function_literals_in_foreach_calls

import 'package:flutter/material.dart';
import "package:flutter/cupertino.dart";
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:todoapp/CLient/network_helper.dart';
import 'package:todoapp/SharedData/Todo_Data.dart';
import 'package:todoapp/custom_widgets/todo_card.dart';

void main() {
  runApp(TodoApp());
}

class TodoApp extends StatelessWidget {
  const TodoApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: "Todo app",
      home: TodoHome(),
    );
  }
}

class TodoHome extends StatefulWidget {
  const TodoHome({Key? key}) : super(key: key);

  @override
  State<TodoHome> createState() => _TodoHomeState();
}

class _TodoHomeState extends State<TodoHome> {
  late Future<TodoData?> todoList;

  @override
  void initState() {
    super.initState();
    todoList = NetworkHelper().getTodoData(endpoint: "todos");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF4F7FE),
      appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          centerTitle: false,
          leading: const Padding(
            padding: EdgeInsets.fromLTRB(16, 0, 0, 10),
            child: CircleAvatar(
              child: Text("BA"),
            ),
          ),
          title: Text("My Tasks"),
          actions: const [
            Icon(Icons.sort),
            SizedBox(
              width: 20,
            ),
            Icon(Icons.search)
          ]),
      body: FutureBuilder<TodoData?>(
          future: todoList,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.separated(
                itemCount: snapshot.data!.data!.length,
                itemBuilder: (context, index) {
                  return TodoCard(Tododata: snapshot.data!.data![index]);
                },
                separatorBuilder: (context, index) {
                  return Divider();
                },
              );
            }

            return Center(child: CircularProgressIndicator());
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(
          Icons.add,
          size: 50,
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: InkWell(
          onTap: () {
            showBarModalBottomSheet(
              context: context,
              builder: (context) => Container(
                color: Color(0xFFDEDEDE),
                height: MediaQuery.of(context).size.height - 150,
                child: FutureBuilder<TodoData?>(
                    future: todoList,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        var data = snapshot.data;
                        for (int i = 0; i < data!.data!.length; i++) {
                          if (data!.data![i].status == false) {
                            return TodoCard(Tododata: data.data![i]);
                          }
                        }
                      }
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(
                            child: CircularProgressIndicator.adaptive());
                      }

                      return Center(child: Text("No Completed Task"));
                    }),
              ),
            );
          },
          child: Container(
            margin: const EdgeInsets.all(15),
            height: 60,
            decoration: BoxDecoration(
              color: Color(0xFFCCD9E5),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(children: const [
                    Icon(CupertinoIcons.check_mark_circled_solid),
                    SizedBox(
                      width: 10,
                    ),
                    Text("completed"),
                    SizedBox(
                      width: 10,
                    ),
                    Icon(Icons.keyboard_arrow_down)
                  ]),
                  Text("")
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
