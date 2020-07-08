class HomeIconData {
  String iconImg;
  int resourceId;
  int type;
  String unusableTip;
  bool usable;
  String name;

  HomeIconData(
      {this.iconImg,
      this.resourceId,
      this.type,
      this.unusableTip,
      this.usable,
      this.name});

  factory HomeIconData.fromJson(Map<String, dynamic> json) {
    return HomeIconData(
      iconImg: json['iconImg'],
      resourceId: json['resourceId'],
      type: json['type'],
      unusableTip: json['unusableTip'],
      usable: json['usable'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['iconImg'] = this.iconImg;
    data['resourceId'] = this.resourceId;
    data['type'] = this.type;
    data['unusableTip'] = this.unusableTip;
    data['usable'] = this.usable;
    data['name'] = this.name;
    return data;
  }
}
