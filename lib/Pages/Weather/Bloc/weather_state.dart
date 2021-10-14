import 'package:equatable/equatable.dart';

abstract class WeatherState extends Equatable {
  WeatherState([List props = const []]) : super();

  @override
  List<Object> get props => [];
}

class WeatherEmpty extends WeatherState {}

class WeatherLoading extends WeatherState {}

class WeatherIsLoaded extends WeatherState {
  final String weatherStatus;
  final int humidity;
  final num temperature;
  final num windSpeed;
  final String weatherIcon;

  WeatherIsLoaded({
    required this.humidity,
    required this.weatherStatus,
    required this.weatherIcon,
    required this.temperature,
    required this.windSpeed,
  }) : super();
}

class WeatherIsNotLoaded extends WeatherState {}
