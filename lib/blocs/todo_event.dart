import 'package:equatable/equatable.dart';

// Définition de la classe abstraite ToDoEvent
abstract class ToDoEvent {}

// Classe d'événement pour ajouter une nouvelle tâche
class AddToDo extends ToDoEvent {
  final String title; // Titre de la nouvelle tâche à ajouter

  // Constructeur prenant le titre de la tâche comme paramètre
  AddToDo(this.title);
}

// Classe d'événement pour mettre à jour une tâche existante
class UpdateToDo extends ToDoEvent {
  final int index; // Index de la tâche à mettre à jour
  final String newTitle; // Nouveau titre de la tâche

  // Constructeur prenant l'index et le nouveau titre comme paramètres
  UpdateToDo(this.index, this.newTitle);
}

// Classe d'événement pour supprimer une tâche
class DeleteToDo extends ToDoEvent {
  final int index; // Index de la tâche à supprimer

  // Constructeur prenant l'index de la tâche à supprimer comme paramètre
  DeleteToDo(this.index);
}

// Classe d'événement pour charger les tâches initiales
class LoadToDos extends ToDoEvent {}
