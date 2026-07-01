import 'package:field_track/core/failures/failure.dart';
import 'package:field_track/core/usecase/usecase.dart';
import 'package:field_track/features/locations/domain/repositories/location_repository.dart';
import 'package:fpdart/fpdart.dart';

class DeleteLocationUsecase implements Usecase<void, DeleteLocationUsecaseParams> {
  final LocationRepository locationRepository;
  DeleteLocationUsecase({required this.locationRepository});
  @override
  Future<Either<Failure, void>> call(DeleteLocationUsecaseParams params) {
    return locationRepository.deleteLocation(params.id);
  }
}

class DeleteLocationUsecaseParams {
  final String id;
  DeleteLocationUsecaseParams({required this.id});
}