import 'package:get/state_manager.dart';
import 'package:todo/models/Todo.dart';
import 'package:get_storage/get_storage.dart';

class TodoController extends GetxController {
  // from model/todo, this is a connection to the controller
  var todos = <Todo>[].obs;
  @override
  // life cycle, init.
  void onInit() {
    List? storedTodos = GetStorage().read<List>('todos');
    if (storedTodos != null && storedTodos.isNotEmpty) {
      todos = storedTodos.map((e) => Todo.fromJson(e)).toList().obs;
    }
    ever(todos, (_) {
      GetStorage().write('todos', todos.toList());
    });
    super.onInit();
  }
}
