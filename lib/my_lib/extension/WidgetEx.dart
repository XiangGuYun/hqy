part of base_extension;

///组件扩展
extension WidgetEx on Widget {
  ///设置可见性，相当于Android中的Visible和Invisible
  /// visible 是否可见
  /// millis 淡入淡出时间，单位毫秒
  Widget setVisible1(bool visible, {int millis = 0}) {
    return AnimatedOpacity(
      duration: Duration(milliseconds: millis),
      opacity: visible ? 1.0 : 0.0,
      child: this,
    );
  }

  ///设置可见性，相当于Android中的Visible和Gone
  Widget setVisible2(bool visible) {
    return Offstage(
      offstage: !visible,
      child: this,
    );
  }

  ///设置组件尺寸
  Widget setSize(double width, double height) {
    return SizedBox(
      child: this,
      width: width.toDouble(),
      height: height.toDouble(),
    );
  }

  Widget setSizedBox({double width, double height}) {
    if (width == null) {
      return SizedBox(
        child: this,
        height: height.toDouble(),
      );
    } else if (height == null) {
      return SizedBox(
        child: this,
        width: width.toDouble(),
      );
    } else {
      return SizedBox(
        child: this,
        width: width.toDouble(),
        height: height.toDouble(),
      );
    }
  }

  ///设置最大宽高
  Widget setLimitedBox({maxWidth = -1, maxHeight = -1}) {
    return LimitedBox(
      child: this,
      maxHeight: maxHeight == -1 ? double.infinity : maxHeight,
      maxWidth: maxWidth == -1 ? double.infinity : maxWidth,
    );
  }

  ///设置约束盒子
  Widget setConstrainedBox({maxWidth = -1, maxHeight = -1, minWidth=0, minHeight=0}){
    return ConstrainedBox(
      constraints: BoxConstraints(
        maxHeight: maxHeight == -1 ? double.infinity : maxHeight,
        maxWidth: maxWidth == -1 ? double.infinity : maxWidth,
        minWidth: minWidth,
        minHeight: minHeight,
      ),
      child: this,
    );
  }

  ///根据父容器宽高的百分比来设置子组件宽高 Fractionally(分数，微小的)
  Widget setFractionallySizedBox(widthFactor, heightFactor, {alignment = Alignment.center}){
    return FractionallySizedBox(
      child: this,
      widthFactor: widthFactor,
      heightFactor: heightFactor,
      alignment: alignment,
    );
  }

  ///设置宽高比
  Widget setAspectRatio(double aspectRatio) {
    return AspectRatio(
      aspectRatio: aspectRatio,
      child: this,
    );
  }

  ///设置内边距
  Widget setPadding(double padding) {
    return Padding(
      padding: EdgeInsets.all(padding),
      child: this,
    );
  }

  ///设置内边距
  Widget setPadding1(
      {double left = 0.0,
      double top = 0.0,
      double right = 0.0,
      double bottom = 0.0}) {
    return Padding(
      padding: EdgeInsets.fromLTRB(left, top, right, bottom),
      child: this,
    );
  }

  ///设置外边距
  Widget setMargin(double margin) {
    return Container(
      child: this,
      margin: EdgeInsets.all(margin),
    );
  }

  ///设置外边距
  Widget setMargin1(
      {double left = 0.0,
      double top = 0.0,
      double right = 0.0,
      double bottom = 0.0}) {
    return Container(
      child: this,
      margin: EdgeInsets.fromLTRB(left, top, right, bottom),
    );
  }

  ///设置在父容器中的位置
  Widget setAlign(Alignment alignment) {
    return Align(child: this, alignment: alignment);
  }

  ///设置在父容器中的位置
  Widget setAlign1(double widthFactor, double heightFactor) {
    return Align(
      child: this,
      widthFactor: widthFactor,
      heightFactor: heightFactor,
    );
  }

  ///设置居中于父容器，可以调节位置
  Widget setCenter({double widthFactor, double heightFactor}) {
    return Center(
      child: this,
      widthFactor: widthFactor,
      heightFactor: heightFactor,
    );
  }

  ///设置在Stack中的位置，注意必须在Stack直接节点下，否则会报错
  Widget setPositioned(
      {double left,
      double top,
      double right,
      double bottom,
      double width,
      double height}) {
    return Positioned(
      left: left,
      top: top,
      right: right,
      bottom: bottom,
      width: width,
      height: height,
      child: this,
    );
  }

  Widget setColor(Color color) {
    return Container(
      color: color,
      child: this,
    );
  }

  ///设置组件装饰
  Widget setDecoration(
      {Color color,
      BoxBorder border,
      BorderRadiusGeometry borderRadius,
      List<BoxShadow> boxShadow,
      Gradient gradient,
      BlendMode backgroundBlendMode,
      BoxShape shape = BoxShape.rectangle}) {
    var decoration = BoxDecoration(
        color: color,
        border: border,
        borderRadius: borderRadius,
        boxShadow: boxShadow,
        gradient: gradient,
        backgroundBlendMode: backgroundBlendMode,
        shape: shape);
    return Container(
      child: this,
      decoration: decoration,
    );
  }

  ///设置权重
  Widget setExpanded(int flex) {
    return Expanded(
      flex: flex,
      child: this,
    );
  }

  ///设置裁剪(子组件为正方形时剪裁为内贴圆形，为矩形时，剪裁为内贴椭圆)
  Widget setClipOval() {
    return ClipOval(
      child: this,
    );
  }

  ///设置裁剪(将子组件剪裁为圆角矩形)
  Widget setClipRRect(double radius) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(radius),
      child: this,
    );
  }

  ///设置裁剪(剪裁子组件到实际占用的矩形大小（溢出部分剪裁）)
  Widget setClipRect() {
    return ClipRect(
      child: this,
    );
  }

  ///设置卡片
  Widget setCard({
    Color color,
    double elevation,
    ShapeBorder shape,
    bool borderOnForeground = true,
    Clip clipBehavior,
    EdgeInsetsGeometry margin,
    bool semanticContainer = true,
    Widget child,
  }) {
    return Card(
      child: this,
      color: color,
      elevation: elevation,
      shape: shape,
      borderOnForeground: borderOnForeground,
      clipBehavior: clipBehavior,
      margin: margin,
      semanticContainer: semanticContainer,
    );
  }

  ///设置墨水池
  Widget setInkWell({onTap, onDoubleTap, onLongPress}) {
    return InkWell(
      child: this,
      onTap: onTap,
      onDoubleTap: onDoubleTap,
      onLongPress: onLongPress,
    );
  }

  ///设置变换效果
  Widget setTransform(transform) {
    return Transform(
      transform: transform,
      child: this,
    );
  }

  ///设置手势探测
  Widget setGestureDetector(
      {onTap, onDoubleTap, onLongPress, onTapUp, onTapDown}) {
    return GestureDetector(
      child: this,
      //单击事件，相比于InkWell的onTap，没有水波纹效果
      onTap: onTap,
      onDoubleTap: onDoubleTap,
      onLongPress: onLongPress,
      onTapUp: onTapUp,
      onTapDown: onTapDown,
    );
  }

  ///设置小片
  Widget setChip(
      {avatar,
      label,
      labelStyle,
      labelPadding,
      deleteIcon,
      onDeleted,
      deleteIconColor,
      deleteButtonTooltipMessage,
      shape,
      clipBehavior = Clip.none,
      focusNode,
      autofocus = false,
      backgroundColor,
      padding,
      materialTapTargetSize,
      elevation,
      shadowColor}) {
    return Chip(
        label: this,
        avatar: avatar,
        labelStyle: labelStyle,
        labelPadding: labelPadding,
        deleteIcon: deleteIcon,
        onDeleted: onDeleted,
        deleteIconColor: deleteIconColor,
        deleteButtonTooltipMessage: deleteButtonTooltipMessage,
        shape: shape,
        clipBehavior: clipBehavior,
        focusNode: focusNode,
        autofocus: autofocus,
        backgroundColor: backgroundColor,
        padding: padding,
        materialTapTargetSize: materialTapTargetSize,
        elevation: elevation,
        shadowColor: shadowColor);
  }
}
