class CityInfo {
  List<CityLocation>? location;

  CityInfo({this.location});

  CityInfo.fromJson(Map<String, dynamic> json) {
    if (json["location"] is List) {
      location = json["location"] == null
          ? null
          : (json["location"] as List)
              .map((e) => CityLocation.fromJson(e))
              .toList();
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    if (location != null) {
      _data["location"] = location?.map((e) => e.toJson()).toList();
    }
    return _data;
  }
}

class CityLocation {
  String? name;
  String? id;
  String? lat;
  String? lon;
  String? adm2;
  String? adm1;
  String? country;
  String? tz;
  String? utcOffset;
  String? isDst;
  String? type;
  String? rank;
  String? fxLink;

  CityLocation(
      {this.name,
      this.id,
      this.lat,
      this.lon,
      this.adm2,
      this.adm1,
      this.country,
      this.tz,
      this.utcOffset,
      this.isDst,
      this.type,
      this.rank,
      this.fxLink});

  CityLocation.fromJson(Map<String, dynamic> json) {
    if (json["name"] is String) {
      name = json["name"];
    }
    if (json["id"] is String) {
      id = json["id"];
    }
    if (json["lat"] is String) {
      lat = json["lat"];
    }
    if (json["lon"] is String) {
      lon = json["lon"];
    }
    if (json["adm2"] is String) {
      adm2 = json["adm2"];
    }
    if (json["adm1"] is String) {
      adm1 = json["adm1"];
    }
    if (json["country"] is String) {
      country = json["country"];
    }
    if (json["tz"] is String) {
      tz = json["tz"];
    }
    if (json["utcOffset"] is String) {
      utcOffset = json["utcOffset"];
    }
    if (json["isDst"] is String) {
      isDst = json["isDst"];
    }
    if (json["type"] is String) {
      type = json["type"];
    }
    if (json["rank"] is String) {
      rank = json["rank"];
    }
    if (json["fxLink"] is String) {
      fxLink = json["fxLink"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["name"] = name;
    _data["id"] = id;
    _data["lat"] = lat;
    _data["lon"] = lon;
    _data["adm2"] = adm2;
    _data["adm1"] = adm1;
    _data["country"] = country;
    _data["tz"] = tz;
    _data["utcOffset"] = utcOffset;
    _data["isDst"] = isDst;
    _data["type"] = type;
    _data["rank"] = rank;
    _data["fxLink"] = fxLink;
    return _data;
  }
}
