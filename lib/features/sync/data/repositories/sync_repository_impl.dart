import 'package:field_track/core/errors/exceptions.dart';
import 'package:field_track/core/failures/failure.dart';
import 'package:field_track/features/sync/data/datasources/sync_remote_datasource.dart';
import 'package:field_track/features/sync/domain/repositories/sync_repository.dart';
import 'package:fpdart/fpdart.dart';

class SyncRepositoryImpl extends SyncRepository {
  final SyncRemoteDatasource syncRemoteDatasource;

  SyncRepositoryImpl({required this.syncRemoteDatasource});
  @override
  Future<Either<Failure, void>> syncAll() async {
    try {
      final response = await syncRemoteDatasource.syncAll();
      return Right(response);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return const Left(ServerFailure('Failed to connect to the network.'));
    }
  }

}