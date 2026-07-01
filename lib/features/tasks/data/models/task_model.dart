import 'package:field_track/features/tasks/domain/entities/task.dart';

class TaskModel extends Task {
  TaskModel({
    required super.title,
    required super.description,
    required super.isCompleted,
    required super.dueAt,
    required super.createdAt,
    required super.updatedAt,
    required super.id,
  });

  factory TaskModel.fromJson(Map<String, dynamic> json) {
    return TaskModel(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      isCompleted: json['is_completed'] as bool,
      dueAt: DateTime.parse(json['due_at'] as String),
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
    );
  }

  static List<TaskModel> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((e) => TaskModel.fromJson(e)).toList();
  }
}
