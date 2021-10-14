import 'package:flutter/material.dart';
import 'package:weather_app/Pages/Home/home_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather APP',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.lightBlue[200],
        accentColor: Colors.blue[800],
      ),
      home: HomePage(),
    );
  }
}
