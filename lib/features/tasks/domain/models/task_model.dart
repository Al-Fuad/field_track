import 'package:equatable/equatable.dart';
class Task extends Equatable {
  final String id;
  final String title;
  final String description;
  final String time;
  final bool isCompleted;
  const Task({
    required this.id,
    required this.title,
    required this.description,
    required this.time,
    this.isCompleted = false,
  });
  Task copyWith({
    String? id,
    String? title,
    String? description,
    String? time,
    bool? isCompleted,
  }) {
    return Task(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      time: time ?? this.time,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }
  @override
  List<Object?> get props => [id, title, description, time, isCompleted];
}
