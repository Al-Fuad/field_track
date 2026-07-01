import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:field_track/core/usecase/usecase.dart';
import 'package:field_track/features/tasks/domain/entities/task.dart';
// Adjust these imports based on your exact file structure
import 'package:field_track/features/tasks/domain/usecases/get_all_tasks_usecase.dart';
import 'package:field_track/features/tasks/domain/usecases/update_task_usecase.dart';

part 'tasks_event.dart';
part 'tasks_state.dart';

class TasksBloc extends Bloc<TasksEvent, TasksState> {
  final GetAllTasksUsecase getAllTasksUsecase;
  final UpdateTaskUsecase updateTaskUsecase;

  TasksBloc({required this.getAllTasksUsecase, required this.updateTaskUsecase})
    : super(TasksInitial()) {
    on<LoadTasks>(_onLoadTasks);
    on<FilterTasks>(_onFilterTasks);
    on<ToggleTaskCompletion>(_onToggleTaskCompletion);
  }

  Future<void> _onLoadTasks(LoadTasks event, Emitter<TasksState> emit) async {
    emit(TasksLoading());
    final result = await getAllTasksUsecase(NoParams());

    result.fold(
      (failure) => emit(TasksError(failure.message)),
      (tasks) => emit(
        TasksLoaded(
          allTasks: tasks,
          filteredTasks: tasks, // Initially, filtered tasks match all tasks
        ),
      ),
    );
  }

  void _onFilterTasks(FilterTasks event, Emitter<TasksState> emit) {
    if (state is TasksLoaded) {
      final currentState = state as TasksLoaded;
      List<Task> filtered;

      if (event.filter == 'Completed') {
        filtered = currentState.allTasks.where((t) => t.isCompleted).toList();
      } else if (event.filter == 'Pending') {
        filtered = currentState.allTasks.where((t) => !t.isCompleted).toList();
      } else {
        filtered = currentState.allTasks; // 'All'
      }

      emit(
        currentState.copyWith(filteredTasks: filtered, filter: event.filter),
      );
    }
  }

  Future<void> _onToggleTaskCompletion(
    ToggleTaskCompletion event,
    Emitter<TasksState> emit,
  ) async {
    if (state is TasksLoaded) {
      final currentState = state as TasksLoaded;

      // 1. Find the target task to determine its current status
      final taskIndex = currentState.allTasks.indexWhere(
        (t) => t.id == event.taskId,
      );
      if (taskIndex == -1) return;

      final task = currentState.allTasks[taskIndex];
      final newCompletionStatus = !task.isCompleted;

      // 2. Call the UseCase to update the backend
      final result = await updateTaskUsecase(
        UpdateTaskParams(
          taskId: event.taskId,
          isCompleted: newCompletionStatus,
        ),
      );

      result.fold(
        (failure) {
          // If update fails, you could emit an error state here or handle it via a listener for a Snackbar
        },
        (updatedTask) {
          // 3. Update the local lists with the fresh task data from the server
          final updatedAllTasks = List<Task>.from(currentState.allTasks);
          updatedAllTasks[taskIndex] = updatedTask;

          // 4. Re-apply the current filter so the UI updates correctly
          List<Task> newlyFiltered;
          if (currentState.filter == 'Completed') {
            newlyFiltered = updatedAllTasks
                .where((t) => t.isCompleted)
                .toList();
          } else if (currentState.filter == 'Pending') {
            newlyFiltered = updatedAllTasks
                .where((t) => !t.isCompleted)
                .toList();
          } else {
            newlyFiltered = updatedAllTasks;
          }

          // 5. Emit the new state
          emit(
            currentState.copyWith(
              allTasks: updatedAllTasks,
              filteredTasks: newlyFiltered,
            ),
          );
        },
      );
    }
  }
}
