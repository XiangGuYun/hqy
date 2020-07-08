class Location{
  final String lat;
  final String lon;
  final String cityName;
  final String provinceName;

  Location({this.lat, this.lon, this.cityName,this.provinceName});

  @override
  String toString() {
    return 'Location{lat: $lat, lon: $lon, cityName: $cityName, provinceName: $provinceName}';
  }
}