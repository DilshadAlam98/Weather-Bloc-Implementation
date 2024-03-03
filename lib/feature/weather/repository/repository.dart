// ignore_for_file: overridden_fields

import 'package:flutter_bloc_demo/feature/weather/source/source.dart';
import 'package:weather/weather.dart';

abstract class Repository extends Source {
  @override
  final WeatherFactory wf;
  Repository({required this.wf}) : super(wf: wf);

  @override
  Future<Weather> getWeather({required double lat, required double log}) {
    return getTodayWeather(lat: lat, log: log);
  }
}
