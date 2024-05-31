import 'package:hive/hive.dart';

part 'todo.g.dart';

@HiveType(typeId: 0)
class ToDo {
  @HiveField(0)
  final String title;

  @HiveField(1)
  final bool isDone;

  ToDo({
    required this.title,
    this.isDone = false,
  });
}
