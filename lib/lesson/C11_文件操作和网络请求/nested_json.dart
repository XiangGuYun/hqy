///学习对嵌套JSON的解析
/*
{
  "resultcode": "200",
  "reason": "successed!",
  "today": {
    "temp": "14℃~19℃",
    "weather": "小雨转多云",
  }
}

 */
void main() {
  var json = {
    "resultcode": 200,
    "reason": "successed",
    "today": {
      "temp": "14℃~19℃",
      "weather": "小雨转多云",
    },
  };

  WeatherBean _weatherBean = WeatherBean.fromJson(json);

  print("resultcode:" + _weatherBean.resultcode);
  print("weather:" + _weatherBean.today.weather);
  print("temp:" + _weatherBean.today.temp);
}

class WeatherBean {
  String resultcode;
  String reason;
  Today today;

  WeatherBean({this.resultcode,this.reason,this.today});

  factory WeatherBean.fromJson(Map<String,dynamic> json) {
    return WeatherBean(
        resultcode: json['resultcode'],
        reason: json['reason'],
        //对于嵌套结构一定要做判空处理
        today: json['today'] == null ? null : Today.fromJson(json['today'])
    );
  }
}

///将内部嵌套的结构从抽离出来
class Today {
  String weather;
  String temp;

  Today({this.weather,this.temp});

  factory Today.fromJson(Map<String,dynamic> json) {
    return Today(
      weather: json['weather'],
      temp: json['temp'],
    );
  }
}
