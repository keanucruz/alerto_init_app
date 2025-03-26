import 'package:app/feature/dashboard/repository/location_service_repository.dart';
import 'package:fpdart/fpdart.dart';
import 'package:geolocator/geolocator.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'location_service_viewmodel.g.dart';

@riverpod
class LocationServiceViewModel extends _$LocationServiceViewModel {
  late LocationServiceRepository _locationServiceRepository;
  @override
  AsyncValue<Position>? build() {
    _locationServiceRepository = ref.watch(locationServiceRepositoryProvider);
    return null;
  }

  Future<Position?> determinePosition() async {
    state = const AsyncLoading();

    final result = await _locationServiceRepository.determinePosition();

    switch (result) {
      case Left(value: final failure):
        state = AsyncError(failure.message, StackTrace.current);
        return null;
      case Right(value: final success):
        state = AsyncData(success);
        return success;
    }
  }

  Future<Position?> getLastKnownPosition() async {
    state = const AsyncLoading();

    final result = await _locationServiceRepository.getLastKnownPosition();

    switch (result) {
      case Left(value: final failure):
        state = AsyncError(failure.message, StackTrace.current);
        return null;
      case Right(value: final success):
        state = AsyncData(success!);
        return success;
    }
  }
}
