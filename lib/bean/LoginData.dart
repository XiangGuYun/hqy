///登录数据
class LoginData {
    String token;
    int type;

    LoginData({this.token, this.type});

    factory LoginData.fromJson(Map<String, dynamic> json) {
        return LoginData(
            token: json['token'],
            type: json['type'],
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['token'] = this.token;
        data['type'] = this.type;
        return data;
    }
}