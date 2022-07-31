import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/instance_manager.dart';
import 'package:get/get.dart';
import 'package:todo/controllers/TodoController.dart';
import 'package:todo/models/Todo.dart';

class TodoScreen extends StatelessWidget {
  final TodoController todoController = Get.find<TodoController>();
  final int? index;

  TodoScreen({Key? key, this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String text = '';
    if (index != null) {
      text = todoController.todos[index as int].text;
    }
    TextEditingController textEditingController =
        TextEditingController(text: text);
    return Scaffold(
      body: Container(
          padding: const EdgeInsets.all(12.0),
          child: Column(children: [
            Expanded(
              child: TextField(
                controller: textEditingController,
                autofocus: true,
                maxLines: 99,
                keyboardType: TextInputType.multiline,
                cursorColor: Colors.black,
                style: const TextStyle(
                  fontSize: 25,
                ),
                decoration: const InputDecoration(
                  hintText: 'what do you want to accomplish?',
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  hintStyle: TextStyle(
                    fontSize: 25,
                  ),
                  hintMaxLines: 20,
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                    onPressed: () {
                      Get.back();
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.red,
                      shape: StadiumBorder(),
                    ),
                    child: const Text('Cancel')),
                ElevatedButton(
                    onPressed: () {
                      if (index != null) {
                        var editing = todoController.todos[index as int];
                        editing.text = textEditingController.text;
                        todoController.todos[index as int] = editing;
                      } else {
                        todoController.todos
                            .add(Todo(text: textEditingController.text));
                      }
                      Get.back();
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.blue,
                      shape: StadiumBorder(),
                    ),
                    child: Text((index != null ? 'Edit' : 'Add'))),
              ],
            ),
          ])),
    );
  }
}
