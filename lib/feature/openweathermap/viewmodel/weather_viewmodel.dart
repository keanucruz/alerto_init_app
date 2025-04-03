import 'package:app/feature/openweathermap/model/weather_model.dart';
import 'package:app/feature/openweathermap/repository/weather_repository.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:fpdart/fpdart.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'weather_viewmodel.g.dart';

@riverpod
class WeatherViewmodel extends _$WeatherViewmodel {
  late WeatherRepository _weatherRepository;
  @override
  AsyncValue<WeatherResponse>? build() {
    _weatherRepository = ref.watch(weatherRepositoryProvider);
    return null;
  }

  Future<WeatherResponse?> getWeatherDetails({
    required String latitude,
    required String longtitude,
  }) async {
    state = const AsyncLoading();

    final apiKey = dotenv.env['OPENWEATHERMAP_API_KEY'];

    if (apiKey == null) {
      state = const AsyncError('API key not found', StackTrace.empty);
      return null;
    }
    final response = await _weatherRepository.getWeatherDetails(
      latitude: latitude,
      longtitude: longtitude,
      apiKey: apiKey,
    );

    switch (response) {
      case Left(value: final failure):
        state = AsyncError(failure.message, StackTrace.current);
        return null;
      case Right(value: final success):
        state = AsyncData(success!);
        return success;
    }
  }
}
