import 'package:flutter_test/flutter_test.dart';
import 'package:lista_tarefas/src/controllers/home_controller.dart';
import 'package:lista_tarefas/src/models/todo_model.dart';
import 'package:lista_tarefas/src/repositories/todo_repository.dart';
import 'package:mockito/mockito.dart';

class TodoRepositoryMock extends Mock implements TodoRepository {
  @override
  Future<List<TodoModel>> fetchTodos() async {
    return [
      TodoModel(userId: '1', id: '1', title: 'title1', completed: true),
      TodoModel(userId: '2', id: '2', title: 'title2', completed: false),
    ];
  }
}

main() {
  final repository = TodoRepositoryMock();
  final homeController = HomeController(repository);

  test('Deve preencher variavel todos', () async {
    expect(homeController.state.value, HomeState.start);
    await homeController.start();
    expect(homeController.todos.isNotEmpty, true);
    expect(homeController.state.value, HomeState.success);
  });
}
