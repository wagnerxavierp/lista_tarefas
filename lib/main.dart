import 'package:flutter/material.dart';
import 'package:lista_tarefas/src/views/home_page.dart';

/*
* Criacao de uma feature
*/

/*
* Criando uma release
*/

/*
* Stash e pop
* testando outra vez
*/

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.red),
      home: HomePage(),
    );
  }
}
