///学习对列表JSON的解析
/*
{
  "city": "大连",
  "temp": "17℃",
  "index": [
    {
      "iname": "空调指数",
      "ivalue": "较少开启",
    },
    {
      "iname": "运动指数",
      "ivalue": "较不宜",
    },
    {
      "iname": "紫外线指数",
      "ivalue": "最弱",
    },
  ],
}
 */
void main() {

}

///创建一个对应列表节点的类
/*
 {
    "iname": "空调指数",
    "ivalue": "较少开启",
 }
 */
class Index {
  String iname;
  String ivalue;

  Index({this.iname,this.ivalue});

  factory Index.fromJson(Map<String,dynamic> json) {
    return Index(
        iname: json['iname'],
        ivalue: json['ivalue']
    );
  }
}

///创建JSON类
class WeatherBean {
  String city;
  String temp;
  //对于列表节点，用List进行表示
  List<Index> indexes;

  WeatherBean({this.city,this.temp,this.indexes});

  factory WeatherBean.fromJson(Map<String,dynamic> json) {
    //获取列表节点
    var tempIndex = json['index'] as List;
    //对列表节点进行解析转换为实体类
    List<Index> indexList = tempIndex.map((i) => Index.fromJson(i)).toList();

    return WeatherBean(
        city: json['city'],
        temp: json['temp'],
        indexes: indexList
    );
  }
}

