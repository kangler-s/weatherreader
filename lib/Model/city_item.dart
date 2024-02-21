
class CityItem {
  String? locationId;
  String? locationNameEn;
  String? locationNameZh;
  String? iso31661;
  String? countryRegionEn;
  String? countryRegionZh;
  String? adm1NameEn;
  String? adm1NameZh;
  String? adm2NameEn;
  String? adm2NameZh;
  String? timezone;
  String? latitude;
  String? longitude;
  String? adcode;

  CityItem({this.locationId, this.locationNameEn, this.locationNameZh, this.iso31661, this.countryRegionEn, this.countryRegionZh, this.adm1NameEn, this.adm1NameZh, this.adm2NameEn, this.adm2NameZh, this.timezone, this.latitude, this.longitude, this.adcode});

  CityItem.fromJson(Map<String, dynamic> json) {
    if(json["Location_ID"] is String) {
      locationId = json["Location_ID"];
    }
    if(json["Location_Name_EN"] is String) {
      locationNameEn = json["Location_Name_EN"];
    }
    if(json["Location_Name_ZH"] is String) {
      locationNameZh = json["Location_Name_ZH"];
    }
    if(json["ISO_3166_1"] is String) {
      iso31661 = json["ISO_3166_1"];
    }
    if(json["Country_Region_EN"] is String) {
      countryRegionEn = json["Country_Region_EN"];
    }
    if(json["Country_Region_ZH"] is String) {
      countryRegionZh = json["Country_Region_ZH"];
    }
    if(json["Adm1_Name_EN"] is String) {
      adm1NameEn = json["Adm1_Name_EN"];
    }
    if(json["Adm1_Name_ZH"] is String) {
      adm1NameZh = json["Adm1_Name_ZH"];
    }
    if(json["Adm2_Name_EN"] is String) {
      adm2NameEn = json["Adm2_Name_EN"];
    }
    if(json["Adm2_Name_ZH"] is String) {
      adm2NameZh = json["Adm2_Name_ZH"];
    }
    if(json["Timezone"] is String) {
      timezone = json["Timezone"];
    }
    if(json["Latitude"] is String) {
      latitude = json["Latitude"];
    }
    if(json["Longitude"] is String) {
      longitude = json["Longitude"];
    }
    if(json["Adcode"] is String) {
      adcode = json["Adcode"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["Location_ID"] = locationId;
    _data["Location_Name_EN"] = locationNameEn;
    _data["Location_Name_ZH"] = locationNameZh;
    _data["ISO_3166_1"] = iso31661;
    _data["Country_Region_EN"] = countryRegionEn;
    _data["Country_Region_ZH"] = countryRegionZh;
    _data["Adm1_Name_EN"] = adm1NameEn;
    _data["Adm1_Name_ZH"] = adm1NameZh;
    _data["Adm2_Name_EN"] = adm2NameEn;
    _data["Adm2_Name_ZH"] = adm2NameZh;
    _data["Timezone"] = timezone;
    _data["Latitude"] = latitude;
    _data["Longitude"] = longitude;
    _data["Adcode"] = adcode;
    return _data;
  }
}