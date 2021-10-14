import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/Utils/app_text_style.dart';
import '../../Utils/enums.dart';
import '../Weather/weather_card.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Theme.of(context).primaryColor,
                    Theme.of(context).accentColor,
                  ],
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft
                ),
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(65),
                  bottomLeft: Radius.circular(65),
                ),
              ),
              child: Center(
                child: Text('Weather App',style: AppTextStyle.h1,),
              ),
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.25,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                WeatherCard(title: '${DateFormat('yyyy-MM-dd').format(DateTime.now())}',day: Days.Today ,),
                WeatherCard(title: '${DateFormat('yyyy-MM-dd').format(DateTime.now().add(Duration(days: 1)))}',day: Days.Tomorrow,),
                WeatherCard(title: '${DateFormat('yyyy-MM-dd').format(DateTime.now().add(Duration(days:2)))}',day: Days.After2Days ,),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
