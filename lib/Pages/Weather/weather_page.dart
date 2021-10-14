import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/Pages/Weather/Bloc/weather_bloc.dart';
import 'package:weather_app/Pages/Weather/Bloc/weather_event.dart';
import 'package:weather_app/Pages/Weather/Bloc/weather_state.dart';
import 'package:weather_app/Utils/app_text_style.dart';
import 'package:weather_app/Utils/enums.dart';

class WeatherPage extends StatefulWidget {
  final Days day;

  const WeatherPage({Key? key, required this.day}) : super(key: key);

  @override
  _WeatherPageState createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  @override
  void initState() {
    super.initState();
  }

  WeatherEvent getSuitableWeatherEvent() {
    switch (widget.day) {
      case Days.Today:
        return RequestToday();
      case Days.Tomorrow:
        return RequestTomorrow();
      case Days.After2Days:
        return RequestAfter2Days();
      default:
        return RequestToday();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (builder) => WeatherBloc(WeatherLoading(), getSuitableWeatherEvent()),
      child: BlocBuilder<WeatherBloc, WeatherState>(builder: (context, state) {
        if (state is WeatherLoading) {
          return Center(
            child: CircularProgressIndicator(
              color: Colors.blue,
            ),
          );
        } else if (state is WeatherIsLoaded) {
          return Scaffold(
            body: Container(
              color: state.weatherIcon.startsWith('01') // Sunny weather
                  ? Color(0xffF6B08B)
                  : state.weatherIcon.startsWith('02')  // Cloudy weather
                      ? Color(0xffAED0CF)
                      : Color(0xff94DFC8), // Rainy weather
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.only(top: 40.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30.0),
                        child: Row(
                          children: [
                            Text(
                              '${state.weatherStatus}',
                              style: AppTextStyle.h1.copyWith(fontSize: 30, fontWeight: FontWeight.normal),
                            )
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Image.network(
                              'http://openweathermap.org/img/w/${state.weatherIcon}.png',
                              fit: BoxFit.fitWidth,
                              loadingBuilder: (context, child, loadingProgress) {
                                if (loadingProgress != null)
                                  return Center(
                                      child: CircularProgressIndicator(
                                    color: Colors.white,
                                  ));
                                else
                                  return child;
                              },
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 40.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Dubai',
                              style: AppTextStyle.h1.copyWith(fontSize: 30, fontWeight: FontWeight.normal),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  '${state.temperature.toInt()}\u00B0',
                                  style: AppTextStyle.h1.copyWith(fontSize: 80, fontWeight: FontWeight.normal),
                                ),
                                Container(
                                  color: Colors.white,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 15),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text('Wind',
                                            style: TextStyle(color: Colors.grey[500], fontWeight: FontWeight.normal)),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          '${state.windSpeed}km/h',
                                          style: TextStyle(color: Colors.black, fontWeight: FontWeight.normal),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Container(
                                  color: Colors.white,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text('Humidity',
                                            style: TextStyle(color: Colors.grey[500], fontWeight: FontWeight.normal)),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          '${state.humidity}%',
                                          style: TextStyle(color: Colors.black, fontWeight: FontWeight.normal),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        } else {
          {
            return AlertDialog(
              title: Text('There was an error'),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text('Ok'))
              ],
            );
          }
        }
      }),
    );
  }
}
