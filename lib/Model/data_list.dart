import 'package:weather_app/Model/clouds.dart';
import 'package:weather_app/Model/main.dart';
import 'package:weather_app/Model/sys.dart';
import 'package:weather_app/Model/weather.dart';
import 'package:weather_app/Model/wind.dart';
import 'dart:core' ;

class DataList {
  late int dt;
  late Main main;
  late List<Weather> weather;
  late Clouds clouds;
  late Wind wind;
  late int visibility;
  late num pop;
  late Sys sys;
  late String dtTxt;

  DataList(
      {required this.dt,
        required this.main,
        required this.weather,
        required this.clouds,
        required this.wind,
        required this.visibility,
        required this.pop,
        required this.sys,
        required this.dtTxt});

  DataList.fromJson(Map<String, dynamic> json) {
    dt = json['dt'];
    main = (json['main'] != null ? new Main.fromJson(json['main']) : null)!;
    if (json['weather'] != null) {
      weather = new List<Weather>.empty(growable: true);
      json['weather'].forEach((v) {
        weather.add(new Weather.fromJson(v));
      });
    }
    clouds =
    (json['clouds'] != null ? new Clouds.fromJson(json['clouds']) : null)!;
    wind = (json['wind'] != null ? new Wind.fromJson(json['wind']) : null)!;
    visibility = json['visibility'];
    pop = json['pop'];
    sys = (json['sys'] != null ? new Sys.fromJson(json['sys']) : null)!;
    dtTxt = json['dt_txt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['dt'] = this.dt;
    data['main'] = this.main.toJson();
    data['weather'] = this.weather.map((v) => v.toJson()).toList();
    data['clouds'] = this.clouds.toJson();
    data['wind'] = this.wind.toJson();
    data['visibility'] = this.visibility;
    data['pop'] = this.pop;
    data['sys'] = this.sys.toJson();
    data['dt_txt'] = this.dtTxt;
    return data;
  }
}