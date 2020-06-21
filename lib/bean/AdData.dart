class AdData {
    int id;
    String imageUrl;
    bool isHave;
    int jumpType;
    String jumpUrl;

    AdData({this.id, this.imageUrl, this.isHave, this.jumpType, this.jumpUrl});

    factory AdData.fromJson(Map<String, dynamic> json) {
        return AdData(
            id: json['id'],
            imageUrl: json['imageUrl'],
            isHave: json['isHave'],
            jumpType: json['jumpType'],
            jumpUrl: json['jumpUrl'],
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['id'] = this.id;
        data['imageUrl'] = this.imageUrl;
        data['isHave'] = this.isHave;
        data['jumpType'] = this.jumpType;
        data['jumpUrl'] = this.jumpUrl;
        return data;
    }
}