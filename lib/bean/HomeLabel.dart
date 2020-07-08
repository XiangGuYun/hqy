class HomeLabel {
  int code;
  List<Data> data;
  String msg;
  bool success;

  HomeLabel({this.code, this.data, this.msg, this.success});

  HomeLabel.map(dynamic obj) {
    code = obj["code"];
    if (obj["data"] != null) {
      data = [];
      obj["data"].forEach((v) {
        data.add(Data.map(v));
      });
    }
    msg = obj["msg"];
    success = obj["success"];
  }

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{};
    map["code"] = code;
    if (data != null) {
      map["data"] = data.map((v) => v.toMap()).toList();
    }
    map["msg"] = msg;
    map["success"] = success;
    return map;
  }

}

class Data {
  int id;
  String name;
  PageVO pageVO;

  Data({this.id, this.name, this.pageVO});

  Data.map(dynamic obj) {
    id = obj["id"];
    name = obj["name"];
    pageVO = obj["pageVO"] != null ? PageVO.map(obj["pageVO"]) : null;
  }

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{};
    map["id"] = id;
    map["name"] = name;
    if (pageVO != null) {
      map["pageVO"] = pageVO.toMap();
    }
    return map;
  }

}

class PageVO {
  bool isEnd;
  int pageNum;
  int pageSize;
  List<Results> results;
  int totalCount;
  int totalPageNum;

  PageVO({this.isEnd, this.pageNum, this.pageSize, this.results, this.totalCount, this.totalPageNum});

  PageVO.map(dynamic obj) {
    isEnd = obj["isEnd"];
    pageNum = obj["pageNum"];
    pageSize = obj["pageSize"];
    if (obj["results"] != null) {
      results = [];
      obj["results"].forEach((v) {
        results.add(Results.map(v));
      });
    }
    totalCount = obj["totalCount"];
    totalPageNum = obj["totalPageNum"];
  }

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{};
    map["isEnd"] = isEnd;
    map["pageNum"] = pageNum;
    map["pageSize"] = pageSize;
    if (results != null) {
      map["results"] = results.map((v) => v.toMap()).toList();
    }
    map["totalCount"] = totalCount;
    map["totalPageNum"] = totalPageNum;
    return map;
  }

}

class Results {
  String distance;
  int id;
  String logo;
  String name;
  int payWay;
  double price;
  int tag;
  String vipId;
  String vipName;
  double vipPrice;
  int vipType;

  Results({this.distance, this.id, this.logo, this.name, this.payWay, this.price, this.tag, this.vipId, this.vipName, this.vipPrice, this.vipType});

  Results.map(dynamic obj) {
    distance = obj["distance"];
    id = obj["id"];
    logo = obj["logo"];
    name = obj["name"];
    payWay = obj["payWay"];
    price = obj["price"];
    tag = obj["tag"];
    vipId = obj["vipId"];
    vipName = obj["vipName"];
    vipPrice = obj["vipPrice"];
    vipType = obj["vipType"];
  }

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{};
    map["distance"] = distance;
    map["id"] = id;
    map["logo"] = logo;
    map["name"] = name;
    map["payWay"] = payWay;
    map["price"] = price;
    map["tag"] = tag;
    map["vipId"] = vipId;
    map["vipName"] = vipName;
    map["vipPrice"] = vipPrice;
    map["vipType"] = vipType;
    return map;
  }

}