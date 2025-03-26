import 'package:app/core/util/custom_snackbar.dart';
import 'package:app/core/util/heat_index_alert_level.dart';
import 'package:app/feature/location/viewmodel/location_service_viewmodel.dart';
import 'package:app/feature/openweathermap/viewmodel/weather_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DashboardPage extends ConsumerStatefulWidget {
  const DashboardPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _DashboardPageState();
}

class _DashboardPageState extends ConsumerState<DashboardPage> {
  String? _latitudeResult;
  String? _longtitudeResult;
  String? _tempResult;
  String? _heatIndex;
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

    final weatherViewModel = ref.watch(weatherViewmodelProvider.notifier);
    return Scaffold(
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _latitudeResult == null
                    ? const Text('')
                    : Text("Latitude: ${_latitudeResult!}"),
                _longtitudeResult == null
                    ? const Text('')
                    : Text('Longtitude: ${_longtitudeResult!}'),
                _tempResult == null
                    ? const Text('')
                    : Text('Temp: ${_tempResult!}'),
                _heatIndex == null
                    ? const Text('')
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Heat Index: ${_heatIndex!}'),
                          Text(
                            HeatIndexAlertLevel.getHeatIndexWarning(
                                double.tryParse(_heatIndex!) ?? 0),
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: HeatIndexAlertLevel.getHeatIndexColor(
                                  double.tryParse(_heatIndex!) ?? 0),
                            ),
                          ),
                        ],
                      ),
                ElevatedButton(
                  onPressed: () async {
                    final result = await ref
                        .watch(locationServiceViewModelProvider.notifier)
                        .determinePosition();

                    final temp = await weatherViewModel.getWeatherDetails(
                        latitude: result!.latitude.toString(),
                        longtitude: result.longitude.toString());

                    setState(() {
                      _latitudeResult = result.latitude.toString();
                      _longtitudeResult = result.longitude.toString();
                      _tempResult = temp!.main.temp.toString();
                      _heatIndex = temp.main.feelsLike.toString();
                    });
                  },
                  child: const Text('Get Location'),
                ),
                ElevatedButton(
                  onPressed: () async {},
                  child: const Text('Get Weather'),
                )
              ],
            ),
    );
  }
}
