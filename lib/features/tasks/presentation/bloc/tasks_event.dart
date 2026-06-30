part of 'tasks_bloc.dart';

abstract class TasksEvent extends Equatable {
  const TasksEvent();
  @override
  List<Object?> get props => [];
}
class LoadTasks extends TasksEvent {}
class ToggleTaskCompletion extends TasksEvent {
  final String taskId;
  const ToggleTaskCompletion(this.taskId);
  @override
  List<Object?> get props => [taskId];
}
class FilterTasks extends TasksEvent {
  final String filter; // 'All', 'Pending', 'Completed'
  const FilterTasks(this.filter);
  @override
  List<Object?> get props => [filter];
}
