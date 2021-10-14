import 'package:weather_app/Model/data_list.dart';

class ForeCast {
  late String cod;
  late num message;
  late int cnt;
  late List<DataList> list;

  ForeCast({required this.cod, required this.message, required this.cnt, required this.list,});

  ForeCast.fromJson(Map<String, dynamic> json) {
    cod = json['cod'];
    message = json['message'];
    cnt = json['cnt'];
    if (json['list'] != null) {
      list = new List<DataList>.empty(growable: true);
      json['list'].forEach((v) {
        list.add(new DataList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cod'] = this.cod;
    data['message'] = this.message;
    data['cnt'] = this.cnt;
      data['list'] = this.list.map((v) => v.toJson()).toList();
    return data;
  }
}