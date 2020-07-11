class CityBean {
  List<City> city;

  CityBean({
      this.city});

  CityBean.fromJson(dynamic json) {
    if (json["city"] != null) {
      city = [];
      json["city"].forEach((v) {
        city.add(City.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    if (city != null) {
      map["city"] = city.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class City {
  String provinceId;
  String pname;
  String cityId;
  String cname;
  String firstCode;

  City({
      this.provinceId, 
      this.pname, 
      this.cityId, 
      this.cname, 
      this.firstCode});

  City.fromJson(dynamic json) {
    provinceId = json["provinceId"];
    pname = json["pname"];
    cityId = json["cityId"];
    cname = json["cname"];
    firstCode = json["firstCode"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["provinceId"] = provinceId;
    map["pname"] = pname;
    map["cityId"] = cityId;
    map["cname"] = cname;
    map["firstCode"] = firstCode;
    return map;
  }

}