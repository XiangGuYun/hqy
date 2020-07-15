class MeData {
    String address;
    int certStatus;
    String dueTime;
    int dueTimeDay;
    String gender;
    String headPicture;
    int id;
    String idNumber;
    bool isChange;
    int messageNotReadNum;
    String name;
    String nickname;
    String phone;
    String state;
    int throneCardNotUseNum;
    String totalMoney;
    String totalScore;
    int type;
    int welfareCardNotUseNum;

    MeData({this.address, this.certStatus, this.dueTime, this.dueTimeDay, this.gender, this.headPicture, this.id, this.idNumber, this.isChange, this.messageNotReadNum, this.name, this.nickname, this.phone, this.state, this.throneCardNotUseNum, this.totalMoney, this.totalScore, this.type, this.welfareCardNotUseNum});

    factory MeData.fromJson(Map<String, dynamic> json) {
        return MeData(
            address: json['address'],
            certStatus: json['certStatus'],
            dueTime: json['dueTime'],
            dueTimeDay: json['dueTimeDay'],
            gender: json['gender'],
            headPicture: json['headPicture'],
            id: json['id'],
            idNumber: json['idNumber'],
            isChange: json['isChange'],
            messageNotReadNum: json['messageNotReadNum'],
            name: json['name'],
            nickname: json['nickname'],
            phone: json['phone'],
            state: json['state'],
            throneCardNotUseNum: json['throneCardNotUseNum'],
            totalMoney: json['totalMoney'],
            totalScore: json['totalScore'],
            type: json['type'],
            welfareCardNotUseNum: json['welfareCardNotUseNum'],
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['address'] = this.address;
        data['certStatus'] = this.certStatus;
        data['dueTime'] = this.dueTime;
        data['dueTimeDay'] = this.dueTimeDay;
        data['gender'] = this.gender;
        data['headPicture'] = this.headPicture;
        data['id'] = this.id;
        data['idNumber'] = this.idNumber;
        data['isChange'] = this.isChange;
        data['messageNotReadNum'] = this.messageNotReadNum;
        data['name'] = this.name;
        data['nickname'] = this.nickname;
        data['phone'] = this.phone;
        data['state'] = this.state;
        data['throneCardNotUseNum'] = this.throneCardNotUseNum;
        data['totalMoney'] = this.totalMoney;
        data['totalScore'] = this.totalScore;
        data['type'] = this.type;
        data['welfareCardNotUseNum'] = this.welfareCardNotUseNum;
        return data;
    }
}