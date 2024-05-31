import 'package:bloc/bloc.dart';
import 'package:hive/hive.dart';
import '../models/todo.dart';
import 'todo_event.dart';
import 'todo_state.dart';

// Classe ToDoBloc qui étend la classe Bloc avec des événements ToDoEvent et des états ToDoState
class ToDoBloc extends Bloc<ToDoEvent, ToDoState> {
  final Box<ToDo> todoBox; // Instance de la boîte Hive pour stocker les tâches

  // Constructeur prenant la boîte de tâches comme paramètre
  ToDoBloc(this.todoBox) : super(ToDoInitial()) {
    // Définition des actions à effectuer en fonction des différents événements
    on<AddToDo>(
        _onAddToDo); // Action lorsqu'une nouvelle tâche doit être ajoutée
    on<UpdateToDo>(
        _onUpdateToDo); // Action lorsqu'une tâche existante doit être mise à jour
    on<DeleteToDo>(
        _onDeleteToDo); // Action lorsqu'une tâche doit être supprimée
    on<LoadToDos>(
        _onLoadToDos); // Action lorsqu'il est nécessaire de charger les tâches

    // Déclenchement de l'événement LoadToDos lors de la création du bloc
    add(LoadToDos());
  }

  // Méthode pour ajouter une nouvelle tâche
  void _onAddToDo(
    AddToDo event,
    Emitter<ToDoState> emit,
  ) {
    final newToDo = ToDo(
      title: event.title,
    );
    todoBox.add(newToDo); // Ajout de la nouvelle tâche à la boîte de tâches
    _loadToDos(emit); // Rechargement des tâches pour mettre à jour l'état
  }

  // Méthode pour mettre à jour une tâche existante
  void _onUpdateToDo(
    UpdateToDo event,
    Emitter<ToDoState> emit,
  ) {
    final updatedToDo = ToDo(
      title: event.newTitle,
      isDone: todoBox.getAt(event.index)!.isDone,
    );
    todoBox.putAt(event.index,
        updatedToDo); // Mise à jour de la tâche dans la boîte de tâches
    _loadToDos(emit); // Rechargement des tâches pour mettre à jour l'état
  }

  // Méthode pour supprimer une tâche
  void _onDeleteToDo(
    DeleteToDo event,
    Emitter<ToDoState> emit,
  ) {
    todoBox
        .deleteAt(event.index); // Suppression de la tâche de la boîte de tâches
    _loadToDos(emit); // Rechargement des tâches pour mettre à jour l'état
  }

  // Méthode pour charger les tâches
  void _onLoadToDos(
    LoadToDos event,
    Emitter<ToDoState> emit,
  ) {
    _loadToDos(emit); // Appel de la méthode pour charger les tâches
  }

  // Méthode privée pour charger les tâches à partir de la boîte de tâches et émettre l'état correspondant
  void _loadToDos(Emitter<ToDoState> emit) {
    final todos = todoBox.values
        .toList(); // Récupération des tâches de la boîte de tâches
    emit(ToDoLoadSuccess(
        todos)); // Émission de l'état avec la liste des tâches chargées
  }
}
