import 'package:flutter/material.dart';
import 'package:lista_tarefas/src/controllers/home_controller.dart';
import 'package:lista_tarefas/src/models/todo_model.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final HomeController controller = HomeController();
  TextEditingController _textFieldController = TextEditingController();
  String tarefa = '';

  _success() {
    return new ListView.builder(
        itemCount: controller.todos.length,
        itemBuilder: (context, index) {
          var todo = controller.todos[index];
          return Card(
            child: ListTile(
              leading: Checkbox(
                value: todo.completed,
                onChanged: (bool? value) {
                  setState(() {
                    if (todo.completed) {
                      controller.todos[index].completed = false;
                      controller.ordenarLista();
                    } else {
                      controller.todos[index].completed = true;
                      controller.ordenarLista();
                    }
                  });
                },
              ),
              title: Text(
                '${todo.title}',
                style: const TextStyle(fontSize: 16.0),
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  IconButton(
                    icon: Icon(
                      Icons.edit,
                      size: 25.0,
                      color: Colors.brown[900],
                    ),
                    onPressed: () {
                      _onEditItemPressed(index);
                    },
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.delete,
                      size: 25.0,
                      color: Colors.brown[900],
                    ),
                    onPressed: () {
                      _onDeleteItemPressed(controller.todos[index]);
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  _error() {
    return Center(
      child: TextButton(
        style: ButtonStyle(
          foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),
        ),
        onPressed: () {
          controller.start();
        },
        child: Text('Tentar novamente'),
      ),
    );
  }

  _loading() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  _start() {
    return Container();
  }

  stateManagement(HomeState state) {
    switch (state) {
      case HomeState.start:
        return _start();
      case HomeState.error:
        return _error();
      case HomeState.loading:
        return _loading();
      case HomeState.success:
        return _success();
      case HomeState.atualized:
        return _success();
      default:
    }
  }

  @override
  void initState() {
    super.initState();
    controller.start();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Tarefas'),
        actions: [
          IconButton(
              onPressed: () {
                controller.start();
              },
              icon: Icon(Icons.refresh_outlined))
        ],
      ),
      body: AnimatedBuilder(
          animation: controller.state,
          builder: (context, child) {
            return stateManagement(controller.state.value);
          }),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          setState(() {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: new Text("Tarefa"),
                    content: TextField(
                      autofocus: true,
                      onChanged: (text) {
                        tarefa = text;
                      },
                      keyboardType: TextInputType.name,
                      decoration: InputDecoration(
                        labelText: 'Digite aqui sua tarefa',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    actions: <Widget>[
                      // define os botões na base do dialogo
                      textButtonCustom(
                        titulo: 'Salvar',
                        onClick: () {
                          Navigator.of(context).pop();
                          controller.todos.add(TodoModel(
                              userId: '0',
                              id: '0',
                              title: tarefa,
                              completed: false));
                          controller.ordenarLista();
                          controller.state.value =
                              controller.state.value != HomeState.atualized
                                  ? HomeState.atualized
                                  : HomeState.success;
                        },
                      ),
                    ],
                  );
                });
          });
        },
      ),
    );
  }

  Widget textButtonCustom({String? titulo, Function()? onClick}) {
    return TextButton(
      style: TextButton.styleFrom(
        primary: Colors.blue,
      ),
      onPressed: onClick,
      child: Text(titulo ?? ''),
    );
  }

  _onEditItemPressed(index) {
    _textFieldController.text = controller.todos[index].title;
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: new Text("Tarefa"),
            content: TextField(
              controller: _textFieldController,
              onChanged: (text) {
                tarefa = text;
              },
              keyboardType: TextInputType.name,
              decoration: InputDecoration(
                labelText: 'Digite aqui sua tarefa',
                border: OutlineInputBorder(),
              ),
            ),
            actions: <Widget>[
              // define os botões na base do dialogo
              textButtonCustom(
                titulo: 'Salvar',
                onClick: () {
                  Navigator.of(context).pop();
                  controller.todos[index].title = tarefa;
                  controller.state.value =
                      controller.state.value != HomeState.atualized
                          ? HomeState.atualized
                          : HomeState.success;
                },
              ),
            ],
          );
        });
  }

  _onDeleteItemPressed(todo) {
    controller.todos.remove(todo);
    controller.state.value = controller.state.value != HomeState.atualized
        ? HomeState.atualized
        : HomeState.success;
  }
}
