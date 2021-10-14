import 'package:equatable/equatable.dart';

abstract class WeatherEvent extends Equatable{
  WeatherEvent([List props = const []]) : super();
  @override
  List<Object?> get props => [];
}
class WeatherFetchEvent extends WeatherEvent{
  WeatherFetchEvent();
}

class RequestToday extends WeatherEvent{
  RequestToday();
}


class RequestTomorrow extends WeatherEvent{
  RequestTomorrow();
}


class RequestAfter2Days extends WeatherEvent{
  RequestAfter2Days();
}