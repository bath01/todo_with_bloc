import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/todo_bloc.dart';
import '../blocs/todo_event.dart';
import '../blocs/todo_state.dart';
import '../models/todo.dart';

class ToDoScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ToDoView();
  }
}

class ToDoView extends StatefulWidget {
  @override
  _ToDoViewState createState() => _ToDoViewState();
}

class _ToDoViewState extends State<ToDoView> {
  final TextEditingController _addController = TextEditingController();
  final TextEditingController _editController = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<ToDoBloc>().add(LoadToDos());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ToDo List'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListTile(
              title: const Text('Ajouter une nouvelle tâche'),
              trailing: IconButton(
                icon: const Icon(Icons.add),
                onPressed: () {
                  _showAddDialog(context);
                },
              ),
            ),
          ),
          Expanded(
            child: BlocBuilder<ToDoBloc, ToDoState>(
              builder: (context, state) {
                if (state is ToDoLoadSuccess) {
                  return ListView.builder(
                    itemCount: state.todos.length,
                    itemBuilder: (context, index) {
                      final todo = state.todos[index];
                      return ListTile(
                        title: Text(todo.title),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.edit),
                              onPressed: () {
                                _showEditDialog(context, index, todo.title);
                              },
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete),
                              onPressed: () {
                                context.read<ToDoBloc>().add(DeleteToDo(index));
                              },
                            ),
                          ],
                        ),
                      );
                    },
                  );
                } else if (state is ToDoInitial) {
                  return const Center(child: CircularProgressIndicator());
                } else {
                  return const Center(child: Text('Failed to load tasks'));
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  void _showAddDialog(BuildContext context) {
    _addController.clear();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Ajouter une nouvelle tâche'),
          content: TextField(
            controller: _addController,
            decoration: const InputDecoration(
              labelText: 'Titre de la tâche',
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Annuler'),
            ),
            ElevatedButton(
              onPressed: () {
                final title = _addController.text;
                if (title.isNotEmpty) {
                  context.read<ToDoBloc>().add(AddToDo(title));
                  Navigator.of(context).pop();
                }
              },
              child: const Text('Ajouter'),
            ),
          ],
        );
      },
    );
  }

  void _showEditDialog(BuildContext context, int index, String currentTitle) {
    _editController.text = currentTitle;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Modifier la tâche'),
          content: TextField(
            controller: _editController,
            decoration: const InputDecoration(
              labelText: 'Titre de la tâche',
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Annuler'),
            ),
            ElevatedButton(
              onPressed: () {
                final newTitle = _editController.text;
                if (newTitle.isNotEmpty) {
                  context.read<ToDoBloc>().add(UpdateToDo(index, newTitle));
                  Navigator.of(context).pop();
                }
              },
              child: const Text('Valider'),
            ),
          ],
        );
      },
    );
  }
}
