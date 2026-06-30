import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../domain/models/task_model.dart';
part 'tasks_event.dart';
part 'tasks_state.dart';
class TasksBloc extends Bloc<TasksEvent, TasksState> {
  // Initial mock tasks matching the screenshots
  final List<Task> _tasks = [
    const Task(
      id: '1',
      title: 'Take inventory count',
      description: 'Count shelf stock and storage stock',
      time: 'Done 9:30 AM',
      isCompleted: true,
    ),
    const Task(
      id: '2',
      title: 'Visit branch manager',
      description: 'Collect signed documents',
      time: 'Due 10:00 AM',
      isCompleted: false,
    ),
    const Task(
      id: '3',
      title: 'Verify delivery shipment',
      description: 'Check items against the manifest',
      time: 'Due 11:30 AM',
      isCompleted: false,
    ),
    const Task(
      id: '4',
      title: 'Update store display',
      description: 'Arrange promotional materials',
      time: 'Due 2:00 PM',
      isCompleted: false,
    ),
    const Task(
      id: '5',
      title: 'Submit daily report',
      description: 'Log visit summary and photos',
      time: 'Due 5:00 PM',
      isCompleted: false,
    ),
  ];
  TasksBloc() : super(TasksLoading()) {
    on<LoadTasks>((event, emit) {
      _emitTasks(emit, 'All');
    });
    on<ToggleTaskCompletion>((event, emit) {
      final index = _tasks.indexWhere((task) => task.id == event.taskId);
      if (index != -1) {
        final task = _tasks[index];
        final newIsCompleted = !task.isCompleted;
        
        String newTime;
        if (newIsCompleted) {
          // Format current hour/minute or use mock
          newTime = 'Done 9:30 AM'; // Keep it simple and matching the design
        } else {
          // Revert to original due time
          switch (task.id) {
            case '1': newTime = 'Due 9:30 AM'; break;
            case '2': newTime = 'Due 10:00 AM'; break;
            case '3': newTime = 'Due 11:30 AM'; break;
            case '4': newTime = 'Due 2:00 PM'; break;
            case '5': newTime = 'Due 5:00 PM'; break;
            default: newTime = 'Due';
          }
        }
        _tasks[index] = task.copyWith(
          isCompleted: newIsCompleted,
          time: newTime,
        );
        String currentFilter = 'All';
        if (state is TasksLoaded) {
          currentFilter = (state as TasksLoaded).filter;
        }
        _emitTasks(emit, currentFilter);
      }
    });
    on<FilterTasks>((event, emit) {
      _emitTasks(emit, event.filter);
    });
  }
  void _emitTasks(Emitter<TasksState> emit, String filter) {
    List<Task> filtered;
    if (filter == 'Pending') {
      filtered = _tasks.where((task) => !task.isCompleted).toList();
    } else if (filter == 'Completed') {
      filtered = _tasks.where((task) => task.isCompleted).toList();
    } else {
      filtered = List.from(_tasks);
    }
    final completed = _tasks.where((task) => task.isCompleted).length;
    emit(TasksLoaded(
      allTasks: List.from(_tasks),
      filteredTasks: filtered,
      filter: filter,
      completedCount: completed,
      totalCount: _tasks.length,
    ));
  }
}
