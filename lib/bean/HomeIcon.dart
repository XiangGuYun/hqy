import 'package:wobei/bean/home_icon_data.dart';

class HomeIcon {
  List<HomeIconData> data;
  int code;
  String msg;
  bool success;

  HomeIcon({this.data, this.code, this.msg, this.success});

  factory HomeIcon.fromJson(var json) {
    return HomeIcon(
      data: json['data'] != null ? (json['data'] as List).map((i) => HomeIconData.fromJson(i)).toList() : null,
      code: json['code'],
      msg: json['msg'],
      success: json['success'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['msg'] = this.msg;
    data['success'] = this.success;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}


