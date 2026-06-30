part of 'tasks_bloc.dart';
abstract class TasksState extends Equatable {
  const TasksState();  
  @override

  List<Object?> get props => [];
}
class TasksInitial extends TasksState {}
class TasksLoading extends TasksState {}
class TasksLoaded extends TasksState {
  final List<Task> allTasks;
  final List<Task> filteredTasks;
  final String filter; // 'All', 'Pending', 'Completed'
  final int completedCount;
  final int totalCount;
  const TasksLoaded({
    required this.allTasks,
    required this.filteredTasks,
    required this.filter,
    required this.completedCount,
    required this.totalCount,
  });
  @override
  List<Object?> get props => [allTasks, filteredTasks, filter, completedCount, totalCount];
}