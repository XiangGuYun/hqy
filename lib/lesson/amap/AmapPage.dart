import 'package:amap_location/amap_location.dart';
import 'package:flutter/material.dart';

class AmapPage extends StatefulWidget {
  @override
  _AmapPageState createState() => _AmapPageState();
}

class _AmapPageState extends State<AmapPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this._getLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('地理位置显示'),
      ),
      body: Text('获取定位'),
    );
  }

  _getLocation() async {
    await AMapLocationClient.startup(AMapLocationOption(
        desiredAccuracy: CLLocationAccuracy.kCLLocationAccuracyHundredMeters));
    var location = await AMapLocationClient.getLocation(true);
    print(location.accuracy);
    print(location.longitude);
  }
}
