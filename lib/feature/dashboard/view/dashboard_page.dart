import 'package:app/core/theme/app_palette.dart';
import 'package:app/core/util/custom_snackbar.dart';
import 'package:app/feature/dashboard/widget/heat_index_alert_level.dart';
import 'package:app/core/widget/app_loader.dart';
import 'package:app/feature/chatbot/view/chatbot_page.dart';
import 'package:app/core/widget/background_image.dart';
import 'package:app/feature/dashboard/util/display_animation.dart';
import 'package:app/feature/location/viewmodel/location_service_viewmodel.dart';
import 'package:app/feature/openweathermap/viewmodel/weather_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:groq/groq.dart';
import 'package:lottie/lottie.dart';

class DashboardPage extends ConsumerStatefulWidget {
  const DashboardPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _DashboardPageState();
}

class _DashboardPageState extends ConsumerState<DashboardPage> {
  String? tempResult;
  String? location;
  String? heatIndex;
  String? weatherMain;
  String? weatherDescription;
  final groq = Groq(
    apiKey: dotenv.env['GROQ_API_KEY']!,
    model: "llama-3.3-70b-versatile",
  );
  @override
  Widget build(BuildContext context) {
    bool isLoading =
        ref.watch(locationServiceViewModelProvider)?.isLoading == true ||
            ref.watch(locationServiceViewModelProvider) is AsyncLoading;

    bool isNull = ref.watch(locationServiceViewModelProvider) == null ||
        ref.watch(weatherViewmodelProvider) == null;

    final weatherViewModel = ref.watch(weatherViewmodelProvider.notifier);
    return Scaffold(
      body: BackgroundImageFb1(
        child: isLoading
            ? const AppLoader()
            : isNull
                ? _buildInitialDisplay(weatherViewModel)
                : _buildResultDisplay(weatherViewModel, context),
      ),
    );
  }

  Widget _buildInitialDisplay(WeatherViewmodel weatherViewModel) {
    return Padding(
      padding: const EdgeInsets.all(36),
      child: Center(
        child: Stack(fit: StackFit.expand, children: [
          Center(
            child: SizedBox(
              child: Lottie.asset(
                'assets/alternate.json',
                fit: BoxFit.contain,
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Wondering kung gaano kainit today?",
                style: TextStyle(
                  fontSize: 45,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              RichText(
                textAlign: TextAlign.center,
                text: const TextSpan(children: [
                  WidgetSpan(
                    child: Icon(
                      Icons.location_on,
                      size: 18,
                      color: Colors.redAccent,
                    ),
                  ),
                  TextSpan(
                      text: "  Location services will be used.",
                      style: TextStyle(fontSize: 18))
                ]),
              ),
              const SizedBox(
                height: 24,
              ),
              IconButton(
                onPressed: () async {
                  final result = await ref
                      .watch(locationServiceViewModelProvider.notifier)
                      .determinePosition();

                  final weather = await weatherViewModel.getWeatherDetails(
                      latitude: result!.latitude.toString(),
                      longtitude: result.longitude.toString());

                  setState(() {
                    tempResult = weather!.main.temp.toString();
                    heatIndex = weather.main.feelsLike.toString();
                    location = weather.name.toUpperCase();
                    weatherMain = weather.weather.first.main;
                    weatherDescription = weather.weather.first.description;
                  });
                },
                icon: const Icon(
                  Icons.search,
                  color: Colors.white,
                  size: 32,
                ),
              ),
            ],
          ),
        ]),
      ),
    );
  }

  Widget _buildResultDisplay(
      WeatherViewmodel weatherViewModel, BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ChatbotPage(),
                  ),
                );
              },
              icon: const Icon(
                Icons.message_outlined,
                color: AppPalette.whiteColor,
              ))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(36),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              tempResult == null
                  ? const Text(
                      "-- C°",
                      style: TextStyle(
                        fontSize: 55,
                        fontWeight: FontWeight.w900,
                      ),
                    )
                  : Text(
                      "${tempResult!} C°",
                      style: const TextStyle(
                        fontSize: 55,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
              location == null
                  ? const Text("--")
                  : Text(
                      location!,
                      style: const TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
              weatherMain == null
                  ? const Text('--')
                  : Text(
                      weatherMain!,
                      style: const TextStyle(
                        fontSize: 23,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
              weatherDescription == null
                  ? const Text('--')
                  : Text(
                      weatherDescription!,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
              Lottie.asset(
                displayAnimation(weatherMain),
              ),
              heatIndex == null
                  ? const Text('')
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Feels like: $heatIndex °',
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        FutureBuilder<String>(
                          future: HeatIndexAlertLevel.getGroqRecommendation(
                              double.tryParse(heatIndex!) ?? 0, groq),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const AppLoader();
                            }

                            if (snapshot.hasError) {
                              return Text(
                                'Error: ${snapshot.error}',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: AppPalette.errorColor,
                                ),
                                textAlign: TextAlign.center,
                              );
                            }
                            return Text(
                              snapshot.data ?? '',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            );
                          },
                        ),
                      ],
                    ),
              IconButton(
                onPressed: () async {
                  try {
                    final result = await ref
                        .watch(locationServiceViewModelProvider.notifier)
                        .determinePosition();

                    if (result == null) {
                      if (context.mounted) {
                        CustomSnackbar.showSnackBar(
                            "Couldn't get your location", true, context);
                      }
                      return;
                    }

                    final res = await weatherViewModel.getWeatherDetails(
                        latitude: result.latitude.toString(),
                        longtitude: result.longitude.toString());

                    if (res == null) {
                      if (context.mounted) {
                        CustomSnackbar.showSnackBar(
                            "Couldn't get weather data", true, context);
                      }
                      return;
                    }

                    setState(() {
                      tempResult = res.main.temp.toString();
                      heatIndex = res.main.feelsLike.toString();
                      location = res.name.toUpperCase();
                      weatherMain = res.weather.first.main;
                      weatherDescription = res.weather.first.description;
                    });
                  } catch (e) {
                    if (context.mounted) {
                      CustomSnackbar.showSnackBar(e.toString(), true, context);
                    }
                  }
                },
                icon: const Icon(
                  Icons.search,
                  color: AppPalette.whiteColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
