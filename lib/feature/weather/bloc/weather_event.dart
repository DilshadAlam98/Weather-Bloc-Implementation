part of 'weather_bloc.dart';

sealed class WeatherEvent extends Equatable {
  const WeatherEvent();

  @override
  List<Object> get props => [];
}

final class WeatherFetchingEvent extends WeatherEvent {
  final double lat;
  final double long;

  const WeatherFetchingEvent(this.lat, this.long);
}
