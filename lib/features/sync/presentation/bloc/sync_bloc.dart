import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
part 'sync_event.dart';
part 'sync_state.dart';
class SyncBloc extends Bloc<SyncEvent, SyncState> {
  bool _isOffline = true;
  int _pendingCount = 3;
  List<Map<String, String>> _pendingChanges = [
    {
      'title': 'Take inventory count',
      'subtitle': 'Marked done · 10:15 AM',
      'type': 'task'
    },
    {
      'title': 'Visit branch manager',
      'subtitle': 'Marked done · 10:18 AM',
      'type': 'task'
    },
    {
      'title': 'Update store display',
      'subtitle': 'Marked done · 10:24 AM',
      'type': 'task'
    },
  ];
  SyncBloc()
      : super(const SyncInitial(
          isOffline: true,
          pendingCount: 3,
          pendingChanges: [],
        )) {
    on<LoadSyncStatus>((event, emit) {
      emit(SyncInitial(
        isOffline: _isOffline,
        pendingCount: _pendingCount,
        pendingChanges: List.from(_pendingChanges),
      ));
    });
    on<TriggerSync>((event, emit) async {
      emit(Syncing(
        isOffline: _isOffline,
        pendingCount: _pendingCount,
        pendingChanges: List.from(_pendingChanges),
      ));
      // Simulate network sync
      await Future.delayed(const Duration(seconds: 2));
      _isOffline = false;
      _pendingCount = 0;
      _pendingChanges = [];
      emit(SyncSuccess(
        isOffline: _isOffline,
        pendingCount: _pendingCount,
        pendingChanges: List.from(_pendingChanges),
      ));
    });
  }
}
