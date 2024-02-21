class WeatherNow {
  Now? now;

  WeatherNow({this.now});

  WeatherNow.fromJson(Map<String, dynamic> json) {
    if (json["now"] is Map) {
      now = json["now"] == null ? null : Now.fromJson(json["now"]);
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    if (now != null) {
      _data["now"] = now?.toJson();
    }
    return _data;
  }
}

class Now {
  String? obsTime;
  String? temp;
  String? feelsLike;
  String? icon;
  String? text;
  String? wind360;
  String? windDir;
  String? windScale;
  String? windSpeed;
  String? humidity;
  String? precip;
  String? pressure;
  String? vis;
  String? cloud;
  String? dew;

  Now(
      {this.obsTime,
      this.temp,
      this.feelsLike,
      this.icon,
      this.text,
      this.wind360,
      this.windDir,
      this.windScale,
      this.windSpeed,
      this.humidity,
      this.precip,
      this.pressure,
      this.vis,
      this.cloud,
      this.dew});

  Now.fromJson(Map<String, dynamic> json) {
    if (json["obsTime"] is String) {
      obsTime = json["obsTime"];
    }
    if (json["temp"] is String) {
      temp = json["temp"];
    }
    if (json["feelsLike"] is String) {
      feelsLike = json["feelsLike"];
    }
    if (json["icon"] is String) {
      icon = json["icon"];
    }
    if (json["text"] is String) {
      text = json["text"];
    }
    if (json["wind360"] is String) {
      wind360 = json["wind360"];
    }
    if (json["windDir"] is String) {
      windDir = json["windDir"];
    }
    if (json["windScale"] is String) {
      windScale = json["windScale"];
    }
    if (json["windSpeed"] is String) {
      windSpeed = json["windSpeed"];
    }
    if (json["humidity"] is String) {
      humidity = json["humidity"];
    }
    if (json["precip"] is String) {
      precip = json["precip"];
    }
    if (json["pressure"] is String) {
      pressure = json["pressure"];
    }
    if (json["vis"] is String) {
      vis = json["vis"];
    }
    if (json["cloud"] is String) {
      cloud = json["cloud"];
    }
    if (json["dew"] is String) {
      dew = json["dew"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["obsTime"] = obsTime;
    _data["temp"] = temp;
    _data["feelsLike"] = feelsLike;
    _data["icon"] = icon;
    _data["text"] = text;
    _data["wind360"] = wind360;
    _data["windDir"] = windDir;
    _data["windScale"] = windScale;
    _data["windSpeed"] = windSpeed;
    _data["humidity"] = humidity;
    _data["precip"] = precip;
    _data["pressure"] = pressure;
    _data["vis"] = vis;
    _data["cloud"] = cloud;
    _data["dew"] = dew;
    return _data;
  }
}
