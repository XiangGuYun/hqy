part of base_extension;

///*****************************************************************************
///对象扩展
///*****************************************************************************
extension ObjectEx on Object {
  ///---------------------------------------------------------------------------
  /// 打印输出
  ///---------------------------------------------------------------------------
  void pln() {
    print(this);
  }
}

///*****************************************************************************
///字符串扩展
///*****************************************************************************
extension StringEx on String {
  ///---------------------------------------------------------------------------
  /// 设置字符串的最大长度，超出则用...表示
  ///---------------------------------------------------------------------------
  String maxLength(int length){
    if(this.length <= length){
      return this;
    } else {
      return '${this.substring(0, 10)}...';
    }
  }

  ///---------------------------------------------------------------------------
  /// 将"#FFFFFF"或"#FFFFFFFF"格式的颜色字符串转为Color对象
  ///---------------------------------------------------------------------------
  Color color(){
    if(this.length==7){
      var red = BaseUtils.hexToInt(this.substring(1, 3));
      var green = BaseUtils.hexToInt(this.substring(3, 5));
      var blue = BaseUtils.hexToInt(this.substring(5, 7));
      print('$red $green $blue');
      return Color.fromARGB(255, red, green, blue);
    } else {
      var alpha = BaseUtils.hexToInt(this.substring(1, 3));
      var red = BaseUtils.hexToInt(this.substring(3, 5));
      var green = BaseUtils.hexToInt(this.substring(5, 7));
      var blue = BaseUtils.hexToInt(this.substring(7, 9));
      return Color.fromARGB(alpha, red, green, blue);
    }
  }

  ///---------------------------------------------------------------------------
  /// 弹出Toast
  ///---------------------------------------------------------------------------
  void toast(
      {toastLength = Toast.LENGTH_SHORT,
      gravity = ToastGravity.BOTTOM,
      color = const Color(0xee666666),
      fontSize = 16.0}) {
    Fluttertoast.showToast(
        msg: this,
        toastLength: toastLength,
        gravity: gravity,
        timeInSecForIos: 1,
        backgroundColor: color,
        textColor: Colors.white,
        fontSize: fontSize);
  }
}

///*****************************************************************************
///整型扩展
///*****************************************************************************
extension IntEx on int {
  ///---------------------------------------------------------------------------
  /// 将数字转为秒数
  ///---------------------------------------------------------------------------
  Duration seconds() {
    return Duration(seconds: this);
  }

  ///---------------------------------------------------------------------------
  /// 将数字转为边距
  ///---------------------------------------------------------------------------
  EdgeInsets ei() {
    return EdgeInsets.all(toDouble());
  }
}

extension ImaegEx on ImageProvider {
  ///设置圆形头像
  Widget setCircleAvatar() {
    return CircleAvatar(
      backgroundImage: this,
    );
  }
}

///文本扩展
extension TextEx on Text {
  AppBar getAppBar() {
    return AppBar(
      title: this,
    );
  }
}
