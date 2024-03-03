import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc_demo/feature/weather/repository/repository.dart';
import 'package:flutter_bloc_demo/feature/weather/repository/repository_provider.dart';
import 'package:weather/weather.dart';

part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final RepoProvider repo;
  WeatherBloc(this.repo) : super(WeatherInitial()) {
    on<WeatherFetchingEvent>(onWeatherFetching);
  }

  Future<FutureOr<void>> onWeatherFetching(
      WeatherFetchingEvent event, Emitter emit) async {
    try {
      emit(WeatherLoading());
      final weather = await repo.getWeather(lat: event.lat, log: event.long);
      emit(WeatherFetched(weather: weather));
    } catch (e) {
      emit(WeatherError(error: e.toString()));
    }
  }
}
