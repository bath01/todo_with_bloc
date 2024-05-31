import 'package:equatable/equatable.dart';
import 'package:todo_app/models/todo.dart';

// Définition de la classe abstraite ToDoState
abstract class ToDoState extends Equatable {
  const ToDoState(); // Constructeur par défaut de la classe abstraite

  @override
  List<Object> get props =>
      []; // Implémentation de la méthode props qui retourne une liste vide par défaut
}

// Classe représentant l'état initial de l'application To-Do
class ToDoInitial extends ToDoState {}

// Classe représentant l'état où les tâches ont été chargées avec succès
class ToDoLoadSuccess extends ToDoState {
  final List<ToDo> todos; // Liste des tâches chargées

  // Constructeur prenant une liste de tâches en paramètre
  const ToDoLoadSuccess([this.todos = const []]);

  @override
  List<Object> get props => [
        todos
      ]; // Implémentation de la méthode props qui retourne la liste des tâches comme propriété
}
