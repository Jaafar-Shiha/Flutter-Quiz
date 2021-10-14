import 'package:flutter/material.dart';
import 'package:weather_app/Pages/Weather/weather_page.dart';
import 'package:weather_app/Utils/app_text_style.dart';
import 'package:weather_app/Utils/enums.dart';

class WeatherCard extends StatelessWidget {
  final String title;
  final Days day;

  const WeatherCard({Key? key, required this.title, required this.day}) : super(key: key);




  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: (){
          Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => WeatherPage(day: day,)));
        },
        child: Card(
          elevation: 1,
          color: Colors.black,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(25)),
            side: BorderSide.merge(
              BorderSide(width: 1.3, color: Theme.of(context).primaryColor),
              BorderSide(width: 1.3, color: Theme.of(context).primaryColor),
            ),
          ),
          child: Center(
              child: Text(
                title,
                style: AppTextStyle.p1,
                softWrap: true,
                textAlign: TextAlign.center,
              )),
        ),
      ),
    );
  }
}
