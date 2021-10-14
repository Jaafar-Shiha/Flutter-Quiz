import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class WeatherServices {
  static Future<http.Response> getWeatherData() async {
    http.Response response = await http.get(
      Uri.parse(
        'https://api.openweathermap.org/data/2.5/forecast?id=292223&units=metric&appid=abd7c14b6ba48a4e4965ae7e3c3edb22',
      ),
    );
    return response;

  }
}
