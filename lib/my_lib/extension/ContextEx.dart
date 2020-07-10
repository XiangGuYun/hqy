part of base_extension;

///*****************************************************************************
///BuildContext类扩展
///*****************************************************************************
extension ContextEx on BuildContext {
  ///---------------------------------------------------------------------------
  /// 获取屏幕相对宽度像素值
  /// 注意这里要使用状态组件的BuildContext
  ///---------------------------------------------------------------------------
  double getSrnW() {
    return MediaQuery.of(this).size.width;
  }

  ///---------------------------------------------------------------------------
  /// 获取屏幕相对高度像素值
  /// 注意这里要使用状态组件的BuildContext
  ///---------------------------------------------------------------------------
  double getSrnH() {
    return MediaQuery.of(this).size.height;
  }

  ///---------------------------------------------------------------------------
  /// 获取屏幕绝对宽度像素值
  ///---------------------------------------------------------------------------
  double getSrnWPx() {
    return MediaQuery.of(this).size.height *
        MediaQuery.of(this).devicePixelRatio;
  }

  ///---------------------------------------------------------------------------
  /// 获取屏幕绝对高度像素值
  ///---------------------------------------------------------------------------
  double getSrnHPx() {
    return MediaQuery.of(this).size.height *
        MediaQuery.of(this).devicePixelRatio;
  }

  ///---------------------------------------------------------------------------
  /// 切换界面
  ///---------------------------------------------------------------------------
  void push(Widget widget) {
    Navigator.push(this, MaterialPageRoute(builder: (context) => widget));
  }

  ///---------------------------------------------------------------------------
  /// 退出界面
  ///---------------------------------------------------------------------------
  void pop() {
    Navigator.pop(this);
  }

  ///---------------------------------------------------------------------------
  /// 获取状态栏高度
  ///---------------------------------------------------------------------------
  double getStatusBarHeight() {
    return MediaQuery.of(this).padding.top;
  }

  ///---------------------------------------------------------------------------
  /// 显示SnackBar
  ///---------------------------------------------------------------------------
  void showSnackBar(content,
      {backgroundColor,
      elevation,
      shape,
      behavior,
      action,
      duration = const Duration(milliseconds: 4000),
      animation,
      onVisible}) {
    Scaffold.of(this).showSnackBar(SnackBar(
      content: content,
      backgroundColor: backgroundColor,
      elevation: elevation,
      shape: shape,
      behavior: behavior,
      action: action,
      duration: duration,
      animation: animation,
      onVisible: onVisible,
    ));
  }
}
