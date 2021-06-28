import 'package:dio/dio.dart';
import 'package:lista_tarefas/src/models/todo_model.dart';

class TodoRepository {
  Dio dio;
  final url = 'https://jsonplaceholder.typicode.com/todos';

  TodoRepository([Dio? cliente]) : this.dio = cliente ?? Dio();

  Future<List<TodoModel>> fetchTodos() async {
    /*
    final response = await dio.get(url);
    var list = response.data as List;
    list = [list[1], list[2]];

    return list.map((json) => TodoModel.fromJson(json)).toList();
     */
    return [];
  }
}
