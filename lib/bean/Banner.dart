import 'BannerData.dart';

class HbBanner {
    List<BannerData> data;
    int code;
    String msg;
    bool success;

    HbBanner({this.data, this.code, this.msg, this.success});

    factory HbBanner.fromJson(var json) {
        return HbBanner(
            data: json['data'] != null ? (json['data'] as List).map((i) => BannerData.fromJson(i)).toList() : null,
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