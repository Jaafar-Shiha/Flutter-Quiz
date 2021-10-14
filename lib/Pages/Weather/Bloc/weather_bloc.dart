import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_app/Model/data_list.dart';
import 'package:weather_app/Model/forecast.dart';
import 'package:weather_app/Pages/Weather/Bloc/weather_event.dart';
import 'package:weather_app/Pages/Weather/Bloc/weather_state.dart';
import 'package:weather_app/Services/weather_services.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  WeatherBloc(WeatherState initialState, WeatherEvent event) : super(initialState) {
    this.add(event);
  }

  @override
  Stream<WeatherState> mapEventToState(WeatherEvent event) async* {
    if (event is WeatherEvent) yield WeatherLoading();
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String responseBody;
      http.Response response;
      if ((event is RequestToday && prefs.getInt('lastRequestOfTodayWeather') == DateTime.now().day)
      || (event is RequestTomorrow && prefs.getInt('lastRequestOfTomorrowWeather') == DateTime.now().day)
      || (event is RequestAfter2Days && prefs.getInt('lastRequestAfter2DaysWeather') == DateTime.now().day)){
        responseBody = prefs.getString('weatherResponse')!;
      } else {
        response = await WeatherServices.getWeatherData();
        responseBody = response.body;
      }
      ForeCast foreCast = ForeCast.fromJson(jsonDecode(responseBody));
      if (event is RequestToday) {
        DataList weatherOfToday = foreCast.list.firstWhere((element) =>
                element.dtTxt.contains(DateTime.now().toIso8601String().substring(0, 10) //Date of today as: yyyy-mm-dd
                    ));
        prefs.setInt('lastRequestOfTodayWeather', DateTime.now().day);
        prefs.setString('weatherResponse', responseBody);

        yield WeatherIsLoaded(
            weatherStatus: weatherOfToday.weather.last.description,
            humidity: weatherOfToday.main.humidity,
            temperature: weatherOfToday.main.temp,
            windSpeed: weatherOfToday.wind.speed,
            weatherIcon: weatherOfToday.weather.last.icon);
      } else if (event is RequestTomorrow) {
        DataList weatherOfTomorrow = foreCast.list.firstWhere((element) => element.dtTxt.contains(
            DateTime.now().add(Duration(days: 1)).toIso8601String().substring(0, 10) //Date of tomorrow as: yyyy-mm-dd
            ));
        prefs.setString('weatherResponse', responseBody);
        prefs.setInt('lastRequestOfTomorrowWeather', DateTime.now().day);
        yield WeatherIsLoaded(
            weatherStatus: weatherOfTomorrow.weather.last.description,
            humidity: weatherOfTomorrow.main.humidity,
            temperature: weatherOfTomorrow.main.temp,
            windSpeed: weatherOfTomorrow.wind.speed,
            weatherIcon: weatherOfTomorrow.weather.last.icon);
      } else if (event is RequestAfter2Days) {
        DataList weatherAfter2Days = foreCast.list.firstWhere((element) => element.dtTxt.contains(
            DateTime.now().add(Duration(days: 2)).toIso8601String().substring(0, 10) //Date after 2 days as: yyyy-mm-dd
            ));
        prefs.setString('weatherResponse', responseBody);
        prefs.setInt('lastRequestAfter2DaysWeather', DateTime.now().day);
        yield WeatherIsLoaded(
            weatherStatus: weatherAfter2Days.weather.last.description,
            humidity: weatherAfter2Days.main.humidity,
            temperature: weatherAfter2Days.main.temp,
            windSpeed: weatherAfter2Days.wind.speed,
            weatherIcon: weatherAfter2Days.weather.last.icon);
      }
    } catch (e) {
      yield WeatherIsNotLoaded();
      return;
    }
  }
}
