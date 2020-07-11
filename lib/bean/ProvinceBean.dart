import 'package:json_annotation/json_annotation.dart';

part 'ProvinceBean.g.dart';

@JsonSerializable(nullable: false)
class ProvinceBean {
  List<String> province;

  ProvinceBean({
      this.province});

  ProvinceBean.fromJson(dynamic json) {
    province = json["province"] != null ? json["province"].cast<String>() : [];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["province"] = province;
    return map;
  }

}