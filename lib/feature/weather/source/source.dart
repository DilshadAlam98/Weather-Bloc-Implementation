import 'package:weather/weather.dart';

abstract class Source {
  final WeatherFactory wf;

  Source({required this.wf});

  Future<Weather> getTodayWeather({required double lat, required double log}) async {
    final weather = await wf.currentWeatherByLocation(lat, log);
    return weather;
  }
}
