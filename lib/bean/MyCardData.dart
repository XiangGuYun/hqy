class MyCardData {
    bool isEnd;
    int pageNum;
    int pageSize;
    List<Result> results;
    int totalCount;
    int totalPageNum;

    MyCardData({this.isEnd, this.pageNum, this.pageSize, this.results, this.totalCount, this.totalPageNum});

    factory MyCardData.fromJson(Map<String, dynamic> json) {
        return MyCardData(
            isEnd: json['isEnd'],
            pageNum: json['pageNum'],
            pageSize: json['pageSize'],
            results: json['results'] != null ? (json['results'] as List).map((i) => Result.fromJson(i)).toList() : null,
            totalCount: json['totalCount'],
            totalPageNum: json['totalPageNum'],
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['isEnd'] = this.isEnd;
        data['pageNum'] = this.pageNum;
        data['pageSize'] = this.pageSize;
        data['totalCount'] = this.totalCount;
        data['totalPageNum'] = this.totalPageNum;
        if (this.results != null) {
            data['results'] = this.results.map((v) => v.toJson()).toList();
        }
        return data;
    }
}

class Result {
    int exchangEndTime;
    int id;
    String itemName;
    String logo;

    Result({this.exchangEndTime, this.id, this.itemName, this.logo});

    factory Result.fromJson(Map<String, dynamic> json) {
        return Result(
            exchangEndTime: json['exchangEndTime'],
            id: json['id'],
            itemName: json['itemName'],
            logo: json['logo'],
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['exchangEndTime'] = this.exchangEndTime;
        data['id'] = this.id;
        data['itemName'] = this.itemName;
        data['logo'] = this.logo;
        return data;
    }
}