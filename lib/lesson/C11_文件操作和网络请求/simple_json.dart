///学习对简单JSON的解析
/*
{
    "city": "大连",
    "weather": "多云",
    "temp": "17",
}

 */
void main() {
  var json = {
    "city": "大连",
    "weather": "多云",
    "temp": "17℃",
  };

  WeatherBean _weatherBean = WeatherBean.fromJson(json);

  print("city:" + _weatherBean.city);
  print("weather:" + _weatherBean.weather);
  print("temp:" + _weatherBean.temp);
}

class WeatherBean {
  //声明参数
  String city;
  String weather;
  String temp;

  //构造函数1
  WeatherBean({this.city,this.weather,this.temp});

  //构造函数2
  //factory关键字是用来实现方法重载的
  factory WeatherBean.fromJson(Map<String,dynamic> json) {
    //本质是对构造函数1的包装，将json解析的流程封装到构造函数2中
    return WeatherBean(
      city: json['city'],
      weather: json['weather'],
      temp: json['temp'],
    );
  }
}
