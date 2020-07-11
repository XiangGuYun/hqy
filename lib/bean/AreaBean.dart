class AreaBean {
  List<Area> area;

  AreaBean({
      this.area});

  AreaBean.fromJson(dynamic json) {
    if (json["area"] != null) {
      area = [];
      json["area"].forEach((v) {
        area.add(Area.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    if (area != null) {
      map["area"] = area.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class Area {
  String id;
  String cityId;
  String name;

  Area({
      this.id, 
      this.cityId, 
      this.name});

  Area.fromJson(dynamic json) {
    id = json["id"];
    cityId = json["cityId"];
    name = json["name"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = id;
    map["cityId"] = cityId;
    map["name"] = name;
    return map;
  }

}