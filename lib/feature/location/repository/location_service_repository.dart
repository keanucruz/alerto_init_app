import 'package:app/core/failure/app_failure.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:geolocator/geolocator.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'location_service_repository.g.dart';

@riverpod
LocationServiceRepository locationServiceRepository(Ref ref) {
  return LocationServiceRepository();
}

class LocationServiceRepository {
  final LocationSettings locationSettings = const LocationSettings(
    accuracy: LocationAccuracy.high,
    distanceFilter: 100,
  );
  Future<Either<AppFailure, Position>> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Left(AppFailure(message: 'Location services are disabled.'));
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Left(AppFailure(message: 'Location permissions are denied'));
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Left(AppFailure(
          message:
              'Location permissions are permanently denied, we cannot request permissions.'));
    }

    try {
      final position = await Geolocator.getCurrentPosition(
          locationSettings: locationSettings);
      return Right(position);
    } catch (e) {
      return Left(AppFailure(
          message: 'Failed to get current position: ${e.toString()}'));
    }
  }

  Future<Either<AppFailure, Position?>> getLastKnownPosition() async {
    Position? position = await Geolocator.getLastKnownPosition();

    if (position == null) {
      return Left(AppFailure(message: 'Cannot retrieve last position'));
    }

    return Right(position);
  }
}
