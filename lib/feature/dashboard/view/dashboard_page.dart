import 'package:app/core/util/custom_snackbar.dart';
import 'package:app/feature/dashboard/viewmodel/location_service_viewmodel.dart';
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
                    : Text(_latitudeResult!),
                _longtitudeResult == null
                    ? const Text('')
                    : Text(_longtitudeResult!),
                ElevatedButton(
                  onPressed: () async {
                    final result = await ref
                        .watch(locationServiceViewModelProvider.notifier)
                        .determinePosition();

                    setState(() {
                      _latitudeResult = result?.latitude.toString();
                      _longtitudeResult = result?.longitude.toString();
                    });
                  },
                  child: const Text('Get Location'),
                )
              ],
            ),
    );
  }
}
