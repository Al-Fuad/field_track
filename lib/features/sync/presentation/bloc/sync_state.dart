part of 'sync_bloc.dart';

abstract class SyncState extends Equatable {
  const SyncState();  
  @override
  List<Object?> get props => [];
}

class SyncInitial extends SyncState {
  final bool isOffline;
  final int pendingCount;
  final List<Map<String, String>> pendingChanges;
  const SyncInitial({
    required this.isOffline,
    required this.pendingCount,
    required this.pendingChanges,
  });
  @override
  List<Object?> get props => [isOffline, pendingCount, pendingChanges];
}
class Syncing extends SyncState {
  final bool isOffline;
  final int pendingCount;
  final List<Map<String, String>> pendingChanges;
  const Syncing({
    required this.isOffline,
    required this.pendingCount,
    required this.pendingChanges,
  });
  @override
  List<Object?> get props => [isOffline, pendingCount, pendingChanges];
}
class SyncSuccess extends SyncState {
  final bool isOffline;
  final int pendingCount;
  final List<Map<String, String>> pendingChanges;
  const SyncSuccess({
    this.isOffline = false,
    this.pendingCount = 0,
    this.pendingChanges = const [],
  });
  @override
  List<Object?> get props => [isOffline, pendingCount, pendingChanges];
}
class SyncFailure extends SyncState {
  final String error;
  final bool isOffline;
  final int pendingCount;
  final List<Map<String, String>> pendingChanges;
  const SyncFailure({
    required this.error,
    required this.isOffline,
    required this.pendingCount,
    required this.pendingChanges,
  });
  @override
  List<Object?> get props => [error, isOffline, pendingCount, pendingChanges];
}
