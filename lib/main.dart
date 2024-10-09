import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rest_apis_flutter/provider.dart';
import 'package:rest_apis_flutter/todo_screen.dart';

void main() {
  runApp(ChangeNotifierProvider(
      create: (BuildContext context) => TodoProvider(),
      child: const MainApp()));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: TodoScreen(),
    );
  }
}
// todo list screen.
// create todo screen.
// provider