part of 'sync_bloc.dart';
abstract class SyncEvent extends Equatable {
  const SyncEvent();
  @override
  List<Object?> get props => [];
}
class LoadSyncStatus extends SyncEvent {}
class TriggerSync extends SyncEvent {}
