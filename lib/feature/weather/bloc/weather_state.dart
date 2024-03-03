part of 'weather_bloc.dart';

sealed class WeatherState extends Equatable {
  const WeatherState();

  @override
  List<Object> get props => [];
}

final class WeatherInitial extends WeatherState {}

final class WeatherLoading extends WeatherState {}

final class WeatherFetched extends WeatherState {
  final Weather weather;

  const WeatherFetched({required this.weather});
}

final class WeatherError extends WeatherState {
  final String error;

  const WeatherError({required this.error});
}
