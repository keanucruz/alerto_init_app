import 'package:app/core/util/custom_snackbar.dart';
import 'package:app/core/util/heat_index_alert_level.dart';
import 'package:app/feature/dashboard/widget/glassmorphic.dart';
import 'package:app/feature/location/viewmodel/location_service_viewmodel.dart';
import 'package:app/feature/openweathermap/viewmodel/weather_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';

class DashboardPage extends ConsumerStatefulWidget {
  const DashboardPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _DashboardPageState();
}

class _DashboardPageState extends ConsumerState<DashboardPage> {
  String? _tempResult;
  String? _location;
  String? _heatIndex;
  String? _weatherMain;
  String? _weatherDescription;
  @override
  Widget build(BuildContext context) {
    ref.listen(locationServiceViewModelProvider, (_, next) {
      next?.when(
          data: (data) {},
          error: (error, st) {
            CustomSnackbar.showSnackBar(error.toString(), true, context);
          },
          loading: () {});
    });
    bool isLoading =
        ref.watch(locationServiceViewModelProvider)?.isLoading == true ||
            ref.watch(locationServiceViewModelProvider) is AsyncLoading;

    bool isNull = ref.watch(locationServiceViewModelProvider) == null ||
        ref.watch(weatherViewmodelProvider) == null;

    final weatherViewModel = ref.watch(weatherViewmodelProvider.notifier);
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(120),
        child: Padding(
          padding: const EdgeInsets.all(36.0),
          child: GestureDetector(
            onTap: () {},
            child: const Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Glassmorphism(
                  blur: 10,
                  opacity: 0.2,
                  radius: 12,
                  width: 50,
                  height: 50,
                  child: Icon(Icons.question_mark, color: Colors.white),
                ),
                Glassmorphism(
                  blur: 10,
                  opacity: 0.2,
                  radius: 12,
                  width: 50,
                  height: 50,
                  child: Icon(Icons.chat_bubble_outline, color: Colors.white),
                ),
              ],
            ),
          ),
        ),
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : isNull
              ? IconButton(
                  onPressed: () async {
                    final result = await ref
                        .watch(locationServiceViewModelProvider.notifier)
                        .determinePosition();

                    final weather = await weatherViewModel.getWeatherDetails(
                        latitude: result!.latitude.toString(),
                        longtitude: result.longitude.toString());

                    setState(() {
                      _tempResult = weather!.main.temp.toString();
                      _heatIndex = weather.main.feelsLike.toString();
                      _location = weather.name.toUpperCase();
                      _weatherMain = weather.weather.first.main;
                      _weatherDescription = weather.weather.first.description;
                    });
                  },
                  icon: const Icon(Icons.search),
                )
              : Padding(
                  padding: const EdgeInsets.all(36),
                  child: Center(
                    child: Column(
                      children: [
                        _tempResult == null
                            ? const Text(
                                "-- C°",
                                style: TextStyle(
                                  fontSize: 55,
                                  fontWeight: FontWeight.w900,
                                ),
                              )
                            : Text(
                                "${_tempResult!} C°",
                                style: const TextStyle(
                                  fontSize: 55,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                        _location == null
                            ? const Text("--")
                            : Text(
                                _location!,
                                style: const TextStyle(
                                  fontSize: 32,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                        _weatherMain == null
                            ? const Text('--')
                            : Text(
                                _weatherMain!,
                                style: const TextStyle(
                                  fontSize: 23,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                        _weatherDescription == null
                            ? const Text('--')
                            : Text(
                                _weatherDescription!,
                                style: const TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w300,
                                ),
                              ),
                        Lottie.asset(
                          'assets/alternate.json',
                        ),
                        _heatIndex == null
                            ? const Text('')
                            : Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    'Feels like: $_heatIndex °',
                                    style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Text(
                                    HeatIndexAlertLevel.getHeatIndexWarning(
                                        double.tryParse(_heatIndex!) ?? 0),
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color:
                                          HeatIndexAlertLevel.getHeatIndexColor(
                                              double.tryParse(_heatIndex!) ??
                                                  0),
                                    ),
                                  ),
                                ],
                              ),
                        IconButton(
                          onPressed: () async {
                            try {
                              final result = await ref
                                  .watch(
                                      locationServiceViewModelProvider.notifier)
                                  .determinePosition();

                              if (result == null) {
                                if (context.mounted) {
                                  CustomSnackbar.showSnackBar(
                                      "Couldn't get your location",
                                      true,
                                      context);
                                }
                                return;
                              }

                              final res =
                                  await weatherViewModel.getWeatherDetails(
                                      latitude: result.latitude.toString(),
                                      longtitude: result.longitude.toString());

                              if (res == null) {
                                if (context.mounted) {
                                  CustomSnackbar.showSnackBar(
                                      "Couldn't get weather data",
                                      true,
                                      context);
                                }
                                return;
                              }

                              setState(() {
                                _tempResult = res.main.temp.toString();
                                _heatIndex = res.main.feelsLike.toString();
                                _location = res.name.toUpperCase();
                                _weatherMain = res.weather.first.main;
                                _weatherDescription =
                                    res.weather.first.description;
                              });
                            } catch (e) {
                              if (context.mounted) {
                                CustomSnackbar.showSnackBar(
                                    e.toString(), true, context);
                              }
                            }
                          },
                          icon: const Icon(Icons.search),
                        ),
                      ],
                    ),
                  ),
                ),
    );
  }
}
