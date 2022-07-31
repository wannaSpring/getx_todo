import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo/controllers/TodoController.dart';
import 'package:todo/models/Todo.dart';
import 'package:todo/screens/TodoScreen.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // connect to the controllers
    final TodoController todoController = Get.put(TodoController());
    // return visualization
    return Scaffold(
      appBar: AppBar(
        title: const Text('There is just a TODO list '),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Get.to(TodoScreen());
        },
      ),
      body: Container(
          child: Obx(() => ListView.separated(
                itemCount: todoController.todos.length,
                separatorBuilder: (BuildContext context, int index) =>
                    const Divider(),
                itemBuilder: (context, index) => Dismissible(
                    key: UniqueKey(),
                    onDismissed: (_) {
                      Todo? removed = todoController.todos[index];
                      todoController.todos.removeAt(index);
                      Get.snackbar(removed.text,
                          'Task removed: "${removed.text}" was successfully removed.',
                          mainButton: TextButton(
                            child: const Text(
                              'Undo',
                              style: TextStyle(color: Colors.red),
                            ),
                            onPressed: () {
                              if (removed == null) {
                                return;
                              }
                              todoController.todos
                                  .insert(index, removed as Todo);
                              removed = null;
                              if (Get.isSnackbarOpen) {
                                Get.back();
                              }
                            },
                          ));
                    },
                    child: ListTile(
                      title: Text(todoController.todos[index].text,
                          style: (todoController.todos[index].done)
                              ? const TextStyle(
                                  color: Colors.red,
                                  decoration: TextDecoration.lineThrough)
                              : TextStyle(
                                  color: Theme.of(context)
                                      .textTheme
                                      .bodyText1
                                      ?.color)),
                      onTap: () {
                        Get.to(TodoScreen(index: index));
                      },
                      trailing: Checkbox(
                        value: todoController.todos[index].done,
                        onChanged: (v) {
                          var changed = todoController.todos[index];
                          changed.done = v!;
                          todoController.todos[index] = changed;
                        },
                      ),
                    )),
              ))),
    );
  }
}
