class Task {
  final String title;
  final String description;
  final bool isCompleted;
  final DateTime dueAt;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String id;
  const Task({
    required this.title,
    required this.description,
    required this.isCompleted,
    required this.dueAt,
    required this.createdAt,
    required this.updatedAt,
    required this.id,
  });
}