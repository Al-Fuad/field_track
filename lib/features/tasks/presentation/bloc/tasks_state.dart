part of 'tasks_bloc.dart';

abstract class TasksState extends Equatable {
  const TasksState();
  
  @override
  List<Object> get props => [];
}

class TasksInitial extends TasksState {}

class TasksLoading extends TasksState {}

class TasksLoaded extends TasksState {
  final List<Task> allTasks;
  final List<Task> filteredTasks;
  final String filter;

  const TasksLoaded({
    required this.allTasks,
    required this.filteredTasks,
    this.filter = 'All',
  });

  int get totalCount => allTasks.length;
  int get completedCount => allTasks.where((task) => task.isCompleted).length;

  TasksLoaded copyWith({
    List<Task>? allTasks,
    List<Task>? filteredTasks,
    String? filter,
  }) {
    return TasksLoaded(
      allTasks: allTasks ?? this.allTasks,
      filteredTasks: filteredTasks ?? this.filteredTasks,
      filter: filter ?? this.filter,
    );
  }

  @override
  List<Object> get props => [allTasks, filteredTasks, filter];
}

class TasksError extends TasksState {
  final String message;

  const TasksError(this.message);

  @override
  List<Object> get props => [message];
}