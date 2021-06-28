import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lista_tarefas/src/repositories/todo_repository.dart';
import 'package:mockito/mockito.dart';

class DioMock extends Mock implements Dio {
  @override
  Future<Response<T>> get<T>(String path,
      {Map<String, dynamic>? queryParameters,
      Options? options,
      CancelToken? cancelToken,
      ProgressCallback? onReceiveProgress}) async {
    //implementacao fake
    var response = Response(
        data: jsonDecode(jsonData),
        requestOptions: RequestOptions(path: path)) as Response<T>;
    return response;
  }
}

main() {
  final dioMock = DioMock();
  final repository = TodoRepository(dioMock);

  test('Deve trazer uma lista de todo', () async {
    final list = await repository.fetchTodos();
    print(list);
    expect(list, []);
  });
}

String jsonData = '''
  [
  {
    "userId": 1,
    "id": 1,
    "title": "delectus aut autem",
    "completed": false
  },
  {
    "userId": 1,
    "id": 2,
    "title": "quis ut nam facilis et officia qui",
    "completed": false
  }
]
''';
