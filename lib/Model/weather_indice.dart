/*
 * @Author: kangler liukang0120@163.com
 * @Date: 2024-02-08 19:48:21
 * @LastEditors: kangler liukang0120@163.com
 * @LastEditTime: 2024-02-10 16:52:20
 * @FilePath: /weatherreader/lib/Model/weather_indice.dart
 * @Description: 这是默认设置,请设置`customMade`, 打开koroFileHeader查看配置 进行设置: https://github.com/OBKoro1/koro1FileHeader/wiki/%E9%85%8D%E7%BD%AE
 */
class WeatherIndice {
  List<IDaily>? daily;

  WeatherIndice({this.daily});

  WeatherIndice.fromJson(Map<String, dynamic> json) {
    if (json["daily"] is List) {
      daily = json["daily"] == null
          ? null
          : (json["daily"] as List).map((e) => IDaily.fromJson(e)).toList();
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    if (daily != null) {
      _data["daily"] = daily?.map((e) => e.toJson()).toList();
    }
    return _data;
  }
}

class IDaily {
  String? date;
  String? type;
  String? name;
  String? level;
  String? category;
  String? text;

  IDaily(
      {this.date, this.type, this.name, this.level, this.category, this.text});

  IDaily.fromJson(Map<String, dynamic> json) {
    if (json["date"] is String) {
      date = json["date"];
    }
    if (json["type"] is String) {
      type = json["type"];
    }
    if (json["name"] is String) {
      name = json["name"];
    }
    if (json["level"] is String) {
      level = json["level"];
    }
    if (json["category"] is String) {
      category = json["category"];
    }
    if (json["text"] is String) {
      text = json["text"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["date"] = date;
    _data["type"] = type;
    _data["name"] = name;
    _data["level"] = level;
    _data["category"] = category;
    _data["text"] = text;
    return _data;
  }
}
