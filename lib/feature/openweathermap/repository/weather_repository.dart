import 'dart:convert';

import 'package:app/core/constant/base_url.dart';
import 'package:app/core/failure/app_failure.dart';
import 'package:app/feature/openweathermap/model/weather_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:http/http.dart' as http;
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'weather_repository.g.dart';

@riverpod
WeatherRepository weatherRepository(Ref ref) {
  return WeatherRepository();
}

class WeatherRepository {
  Future<Either<AppFailure, WeatherResponse?>> getWeatherDetails({
    required String latitude,
    required String longtitude,
    required String apiKey,
  }) async {
    try {
      final response = await http.get(
        Uri.parse(
            "${BaseUrl.address}/weather?lat=$latitude&lon=$longtitude&appid=$apiKey&units=metric"),
      );

      if (response.statusCode != 200) {
        return Left(AppFailure(message: "Error detected!"));
      }

      final resBodyMap = jsonDecode(response.body);
      final weatherResponse = WeatherResponse.fromJson(resBodyMap);
      return Right(weatherResponse);
    } catch (e) {
      print(e.toString());
      return Left(AppFailure(message: e.toString()));
    }
  }
}
