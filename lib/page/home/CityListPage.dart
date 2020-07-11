import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wobei/bean/AreaBean.dart';
import 'package:wobei/bean/CityBean.dart';
import 'package:wobei/bean/ProvinceBean.dart';

///*****************************************************************************
///
/// 描述：城市列表
/// 作者：YeXuDong
/// 创建时间：2020/7/10
///
///*****************************************************************************
class CityListPage extends StatefulWidget {
  @override
  _CityListPageState createState() => _CityListPageState();
}

class _CityListPageState extends State<CityListPage> {
  @override
  void initState() {
    super.initState();
    // 解析省JSON文件
    rootBundle.loadString('assets/json/province.json').then((value) {
      String provinceJson = value;
      // 解析市JSON文件
      rootBundle.loadString('assets/json/city.json').then((value) {
        String cityJson = value;
        // 解析区JSON文件
        rootBundle.loadString('assets/json/area.json').then((value) {
          String areaJson = value;
          List<String> provinceList = ProvinceBean.fromJson(provinceJson).province;
          List<City> cityList = CityBean.fromJson(cityJson).city;
          List<Area> areaList = AreaBean.fromJson(areaJson).area;
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[],
            )
          ],
        ),
      ),
    );
  }
}
