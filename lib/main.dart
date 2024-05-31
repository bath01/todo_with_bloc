import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo_app/blocs/todo_bloc.dart';
import 'package:todo_app/screens/todo_list_screen.dart';
import 'models/todo.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(ToDoAdapter());
  final todoBox = await Hive.openBox<ToDo>('todos');

  runApp(MyApp(todoBox: todoBox));
}

class MyApp extends StatelessWidget {
  final Box<ToDo> todoBox;

  MyApp({required this.todoBox});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ToDoBloc(todoBox), // Pass the Hive box to ToDoBloc
      child: MaterialApp(
        title: 'Flutter ToDo BLoC Hive',
        home: ToDoScreen(),
      ),
    );
  }
}
