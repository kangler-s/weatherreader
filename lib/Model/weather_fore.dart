
class WeatherFore {
  List<Daily>? daily;

  WeatherFore({this.daily});

  WeatherFore.fromJson(Map<String, dynamic> json) {
    if(json["daily"] is List) {
      daily = json["daily"] == null ? null : (json["daily"] as List).map((e) => Daily.fromJson(e)).toList();
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    if(daily != null) {
      _data["daily"] = daily?.map((e) => e.toJson()).toList();
    }
    return _data;
  }
}

class Daily {
  String? fxDate;
  String? sunrise;
  String? sunset;
  String? moonrise;
  String? moonset;
  String? moonPhase;
  String? moonPhaseIcon;
  String? tempMax;
  String? tempMin;
  String? iconDay;
  String? textDay;
  String? iconNight;
  String? textNight;
  String? wind360Day;
  String? windDirDay;
  String? windScaleDay;
  String? windSpeedDay;
  String? wind360Night;
  String? windDirNight;
  String? windScaleNight;
  String? windSpeedNight;
  String? humidity;
  String? precip;
  String? pressure;
  String? vis;
  String? cloud;
  String? uvIndex;

  Daily({this.fxDate, this.sunrise, this.sunset, this.moonrise, this.moonset, this.moonPhase, this.moonPhaseIcon, this.tempMax, this.tempMin, this.iconDay, this.textDay, this.iconNight, this.textNight, this.wind360Day, this.windDirDay, this.windScaleDay, this.windSpeedDay, this.wind360Night, this.windDirNight, this.windScaleNight, this.windSpeedNight, this.humidity, this.precip, this.pressure, this.vis, this.cloud, this.uvIndex});

  Daily.fromJson(Map<String, dynamic> json) {
    if(json["fxDate"] is String) {
      fxDate = json["fxDate"];
    }
    if(json["sunrise"] is String) {
      sunrise = json["sunrise"];
    }
    if(json["sunset"] is String) {
      sunset = json["sunset"];
    }
    if(json["moonrise"] is String) {
      moonrise = json["moonrise"];
    }
    if(json["moonset"] is String) {
      moonset = json["moonset"];
    }
    if(json["moonPhase"] is String) {
      moonPhase = json["moonPhase"];
    }
    if(json["moonPhaseIcon"] is String) {
      moonPhaseIcon = json["moonPhaseIcon"];
    }
    if(json["tempMax"] is String) {
      tempMax = json["tempMax"];
    }
    if(json["tempMin"] is String) {
      tempMin = json["tempMin"];
    }
    if(json["iconDay"] is String) {
      iconDay = json["iconDay"];
    }
    if(json["textDay"] is String) {
      textDay = json["textDay"];
    }
    if(json["iconNight"] is String) {
      iconNight = json["iconNight"];
    }
    if(json["textNight"] is String) {
      textNight = json["textNight"];
    }
    if(json["wind360Day"] is String) {
      wind360Day = json["wind360Day"];
    }
    if(json["windDirDay"] is String) {
      windDirDay = json["windDirDay"];
    }
    if(json["windScaleDay"] is String) {
      windScaleDay = json["windScaleDay"];
    }
    if(json["windSpeedDay"] is String) {
      windSpeedDay = json["windSpeedDay"];
    }
    if(json["wind360Night"] is String) {
      wind360Night = json["wind360Night"];
    }
    if(json["windDirNight"] is String) {
      windDirNight = json["windDirNight"];
    }
    if(json["windScaleNight"] is String) {
      windScaleNight = json["windScaleNight"];
    }
    if(json["windSpeedNight"] is String) {
      windSpeedNight = json["windSpeedNight"];
    }
    if(json["humidity"] is String) {
      humidity = json["humidity"];
    }
    if(json["precip"] is String) {
      precip = json["precip"];
    }
    if(json["pressure"] is String) {
      pressure = json["pressure"];
    }
    if(json["vis"] is String) {
      vis = json["vis"];
    }
    if(json["cloud"] is String) {
      cloud = json["cloud"];
    }
    if(json["uvIndex"] is String) {
      uvIndex = json["uvIndex"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["fxDate"] = fxDate;
    _data["sunrise"] = sunrise;
    _data["sunset"] = sunset;
    _data["moonrise"] = moonrise;
    _data["moonset"] = moonset;
    _data["moonPhase"] = moonPhase;
    _data["moonPhaseIcon"] = moonPhaseIcon;
    _data["tempMax"] = tempMax;
    _data["tempMin"] = tempMin;
    _data["iconDay"] = iconDay;
    _data["textDay"] = textDay;
    _data["iconNight"] = iconNight;
    _data["textNight"] = textNight;
    _data["wind360Day"] = wind360Day;
    _data["windDirDay"] = windDirDay;
    _data["windScaleDay"] = windScaleDay;
    _data["windSpeedDay"] = windSpeedDay;
    _data["wind360Night"] = wind360Night;
    _data["windDirNight"] = windDirNight;
    _data["windScaleNight"] = windScaleNight;
    _data["windSpeedNight"] = windSpeedNight;
    _data["humidity"] = humidity;
    _data["precip"] = precip;
    _data["pressure"] = pressure;
    _data["vis"] = vis;
    _data["cloud"] = cloud;
    _data["uvIndex"] = uvIndex;
    return _data;
  }
}