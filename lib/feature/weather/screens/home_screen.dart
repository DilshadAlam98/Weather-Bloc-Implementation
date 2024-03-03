import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_demo/feature/weather/bloc/weather_bloc.dart';
import 'package:intl/intl.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    context
        .read<WeatherBloc>()
        .add(const WeatherFetchingEvent(23.014509, 72.591759));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarBrightness: Brightness.dark,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
        child: Stack(
          fit: StackFit.expand,
          children: [
            Align(
              alignment: const AlignmentDirectional(3, -0.3),
              child: Container(
                height: 300,
                width: 300,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.deepPurple,
                ),
              ),
            ),
            Align(
              alignment: const AlignmentDirectional(-3, -0.3),
              child: Container(
                height: 300,
                width: 300,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.deepPurple,
                ),
              ),
            ),
            Align(
              alignment: const AlignmentDirectional(0, -1.2),
              child: Container(
                height: 300,
                width: 5000,
                color: Colors.orangeAccent,
              ),
            ),
            BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 100, sigmaY: 100),
              child: SizedBox(
                height: MediaQuery.sizeOf(context).height,
                width: MediaQuery.sizeOf(context).width,
                child: BlocBuilder<WeatherBloc, WeatherState>(
                  builder: (context, state) {
                    if (state is WeatherLoading) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }

                    if (state is WeatherError) {
                      return Center(
                        child: Text(state.error),
                      );
                    }
                    if (state is WeatherFetched) {
                      final weather = state.weather;
                      return ListView(
                        // mainAxisAlignment: MainAxisAlignment.start,
                        // crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Align(
                            alignment: Alignment.topRight,
                            child: Text(
                              "${weather.areaName}" ?? "",
                              style: const TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          RichText(
                            text: const TextSpan(
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                                fontStyle: FontStyle.italic,
                              ),
                              text: "👋🏻 Hello Dilshad, ",
                              children: [
                                TextSpan(
                                  text: "Good Noon",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 24,
                                    fontWeight: FontWeight.w500,
                                    fontStyle: FontStyle.italic,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 10),
                          RichText(
                            textAlign: TextAlign.center,
                            text: const TextSpan(
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                fontStyle: FontStyle.italic,
                              ),
                              text: "Success requires work, not just words.\n",
                              children: [
                                TextSpan(
                                  text: "~Vidal Sassoon",
                                  style: TextStyle(
                                    color: Colors.black87,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          // const Text(
                          //   "Success requires work, not just words.\ ~Vidal Sassoon",
                          //   textAlign: TextAlign.center,
                          //   style: TextStyle(
                          //     color: Colors.black,
                          //     fontSize: 16,
                          //     fontWeight: FontWeight.bold,
                          //     fontStyle: FontStyle.italic,
                          //   ),
                          // ),
                          Image.asset(
                            getWeatherImagePath(weather.weatherConditionCode!),
                            height: 320,
                          ),
                          Align(
                            alignment: Alignment.center,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "${weather.tempFeelsLike!.celsius!.round()}° C",
                                  style: const TextStyle(
                                    fontSize: 30,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  weather.weatherDescription!.toUpperCase(),
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 24,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                Text(
                                  DateFormat.yMMMMEEEEd().format(weather.date!),
                                  style: const TextStyle(
                                    fontSize: 14,
                                    color: Colors.white,
                                  ),
                                ),
                                const SizedBox(height: 30),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    rowContent(
                                      image: "assets/11.png",
                                      label: "Sunrise",
                                      subLabel: DateFormat("hh:mm a")
                                          .format(weather.sunrise!),
                                    ),
                                    rowContent(
                                        image: "assets/12.png",
                                        label: "SunSet",
                                        subLabel: DateFormat("hh:mm a")
                                            .format(weather.sunset!)),
                                  ],
                                ),
                                // ignore: prefer_const_constructors
                                SizedBox(height: 20),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    rowContent(
                                      image: "assets/13.png",
                                      label: "Temp Max",
                                      subLabel:
                                          "${weather.tempMax!.celsius!.round()}° C",
                                    ),
                                    rowContent(
                                      image: "assets/14.png",
                                      label: "Temp Min",
                                      subLabel:
                                          "${weather.tempMin!.celsius!.round()}° C",
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          )
                        ],
                      );
                    }
                    return const SizedBox();
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String getWeatherImagePath(int code) {
    switch (code) {
      case >= 200 && < 300:
        return 'assets/1.png';
      case >= 300 && < 400:
        return 'assets/2.png';
      case >= 500 && < 600:
        return 'assets/3.png';
      case >= 600 && < 700:
        return 'assets/4.png';
      case >= 700 && < 800:
        return 'assets/5.png';
      case == 800:
        return 'assets/6.png';
      case > 800 && <= 804:
        return 'assets/7.png';
      default:
        return 'assets/7.png';
    }
  }

  Row rowContent({
    required String image,
    required String label,
    required String subLabel,
  }) {
    return Row(
      children: [
        Image.asset(
          image,
          height: 70,
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: const TextStyle(
                color: Colors.white70,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              subLabel,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            )
          ],
        )
      ],
    );
  }
}
