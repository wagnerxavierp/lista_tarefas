import 'package:flutter/foundation.dart';
import 'package:lista_tarefas/src/models/todo_model.dart';
import 'package:lista_tarefas/src/repositories/todo_repository.dart';

class HomeController {
  List<TodoModel> todos = [];
  late final TodoRepository repository;
  final state = ValueNotifier(HomeState.start);

  HomeController([TodoRepository? repository]) {
    this.repository = repository ?? TodoRepository();
  }

  Future start() async {
    state.value = HomeState.loading;
    try {
      todos = await repository.fetchTodos();
      if (todos.isEmpty) {
        todos.add(TodoModel(
            userId: '0',
            id: '0',
            title: 'Entrar no aplicativo',
            completed: true));
      }
      ordenarLista();
      state.value = HomeState.success;
    } catch (e) {
      print('Erro: ${e.toString()}');
      state.value = HomeState.error;
    }
  }

  ordenarLista() {
    todos.sort(
        (a, b) => ((a.completed != b.completed) && (a.completed)) ? 1 : -1);
  }
}

enum HomeState { start, loading, success, error, atualized }
