import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

const double _kTabHeight = 46.0;
const double _kTextAndIconTabHeight = 72.0;

/// A material design [TabBar] tab.
///
/// If both [icon] and [text] are provided, the text is displayed below
/// the icon.
///
/// See also:
///
///  * [TabBar], which displays a row of tabs.
///  * [TabBarView], which displays a widget for the currently selected tab.
///  * [TabController], which coordinates tab selection between a [TabBar] and a [TabBarView].
///  * <https://material.io/design/components/tabs.html>
class MyTab extends StatelessWidget {
  /// Creates a material design [TabBar] tab.
  ///
  /// At least one of [text], [icon], and [child] must be non-null. The [text]
  /// and [child] arguments must not be used at the same time.
  const MyTab({
    Key key,
    this.text,
    this.icon,
    this.child,
    this.textColor
  }) : assert(text != null || child != null || icon != null),
        assert(!(text != null && null != child)), // TODO(goderbauer): https://github.com/dart-lang/sdk/issues/34180
        super(key: key);

  /// The text to display as the tab's label.
  ///
  /// Must not be used in combination with [child].
  final String text;

  /// The widget to be used as the tab's label.
  ///
  /// Usually a [Text] widget, possibly wrapped in a [Semantics] widget.
  ///
  /// Must not be used in combination with [text].
  final Widget child;

  /// An icon to display as the tab's label.
  final Widget icon;

  final Color textColor;

  Widget _buildLabelText() {
    return child ?? Text(text, softWrap: false, style:TextStyle(color: textColor),overflow: TextOverflow.fade);
  }

  @override
  Widget build(BuildContext context) {
    assert(debugCheckHasMaterial(context));

    double height;
    Widget label;
    if (icon == null) {
      height = _kTabHeight;
      label = _buildLabelText();
    } else if (text == null && child == null) {
      height = _kTabHeight;
      label = icon;
    } else {
      height = _kTextAndIconTabHeight;
      label = Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            child: icon,
            margin: const EdgeInsets.only(bottom: 10.0),
          ),
          _buildLabelText(),
        ],
      );
    }

    return SizedBox(
      height: height,
      child: Center(
        child: label,
        widthFactor: 1.0,
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(StringProperty('text', text, defaultValue: null));
    properties.add(DiagnosticsProperty<Widget>('icon', icon, defaultValue: null));
  }
}

class _TabStyle extends AnimatedWidget {
  const _TabStyle({
    Key key,
    Animation<double> animation,
    this.selected,
    this.labelColor,
    this.unselectedLabelColor,
    this.labelStyle,
    this.unselectedLabelStyle,
    @required this.child,
  }) : super(key: key, listenable: animation);

  final TextStyle labelStyle;
  final TextStyle unselectedLabelStyle;
  final bool selected;
  final Color labelColor;
  final Color unselectedLabelColor;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    final TabBarTheme tabBarTheme = TabBarTheme.of(context);
    final Animation<double> animation = listenable;

    // To enable TextStyle.lerp(style1, style2, value), both styles must have
    // the same value of inherit. Force that to be inherit=true here.
    final TextStyle defaultStyle = (labelStyle
        ?? tabBarTheme.labelStyle
        ?? themeData.primaryTextTheme.body2
    ).copyWith(inherit: true);
    final TextStyle defaultUnselectedStyle = (unselectedLabelStyle
        ?? tabBarTheme.unselectedLabelStyle
        ?? labelStyle
        ?? themeData.primaryTextTheme.body2
    ).copyWith(inherit: true);
    final TextStyle textStyle = selected
        ? TextStyle.lerp(defaultStyle, defaultUnselectedStyle, animation.value)
        : TextStyle.lerp(defaultUnselectedStyle, defaultStyle, animation.value);

    final Color selectedColor = labelColor
        ?? tabBarTheme.labelColor
        ?? themeData.primaryTextTheme.body2.color;
    final Color unselectedColor = unselectedLabelColor
        ?? tabBarTheme.unselectedLabelColor
        ?? selectedColor.withAlpha(0xB2); // 70% alpha
    final Color color = selected
        ? Color.lerp(selectedColor, unselectedColor, animation.value)
        : Color.lerp(unselectedColor, selectedColor, animation.value);

    return DefaultTextStyle(
      style: textStyle.copyWith(color: color),
      child: IconTheme.merge(
        data: IconThemeData(
          size: 24.0,
          color: color,
        ),
        child: child,
      ),
    );
  }
}

typedef _LayoutCallback = void Function(List<double> xOffsets, TextDirection textDirection, double width);

class _TabLabelBarRenderer extends RenderFlex {
  _TabLabelBarRenderer({
    List<RenderBox> children,
    @required Axis direction,
    @required MainAxisSize mainAxisSize,
    @required MainAxisAlignment mainAxisAlignment,
    @required CrossAxisAlignment crossAxisAlignment,
    @required TextDirection textDirection,
    @required VerticalDirection verticalDirection,
    @required this.onPerformLayout,
  }) : assert(onPerformLayout != null),
        assert(textDirection != null),
        super(
        children: children,
        direction: direction,
        mainAxisSize: mainAxisSize,
        mainAxisAlignment: mainAxisAlignment,
        crossAxisAlignment: crossAxisAlignment,
        textDirection: textDirection,
        verticalDirection: verticalDirection,
      );

  _LayoutCallback onPerformLayout;

  @override
  void performLayout() {
    super.performLayout();
    // xOffsets will contain childCount+1 values, giving the offsets of the
    // leading edge of the first tab as the first value, of the leading edge of
    // the each subsequent tab as each subsequent value, and of the trailing
    // edge of the last tab as the last value.
    RenderBox child = firstChild;
    final List<double> xOffsets = <double>[];
    while (child != null) {
      final FlexParentData childParentData = child.parentData;
      xOffsets.add(childParentData.offset.dx);
      assert(child.parentData == childParentData);
      child = childParentData.nextSibling;
    }
    assert(textDirection != null);
    switch (textDirection) {
      case TextDirection.rtl:
        xOffsets.insert(0, size.width);
        break;
      case TextDirection.ltr:
        xOffsets.add(size.width);
        break;
    }
    onPerformLayout(xOffsets, textDirection, size.width);
  }
}

// This class and its renderer class only exist to report the widths of the tabs
// upon layout. The tab widths are only used at paint time (see _IndicatorPainter)
// or in response to input.
class _TabLabelBar extends Flex {
  _TabLabelBar({
    Key key,
    List<Widget> children = const <Widget>[],
    this.onPerformLayout,
  }) : super(
    key: key,
    children: children,
    direction: Axis.horizontal,
    mainAxisSize: MainAxisSize.max,
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.center,
    verticalDirection: VerticalDirection.down,
  );

  final _LayoutCallback onPerformLayout;

  @override
  RenderFlex createRenderObject(BuildContext context) {
    return _TabLabelBarRenderer(
      direction: direction,
      mainAxisAlignment: mainAxisAlignment,
      mainAxisSize: mainAxisSize,
      crossAxisAlignment: crossAxisAlignment,
      textDirection: getEffectiveTextDirection(context),
      verticalDirection: verticalDirection,
      onPerformLayout: onPerformLayout,
    );
  }

  @override
  void updateRenderObject(BuildContext context, _TabLabelBarRenderer renderObject) {
    super.updateRenderObject(context, renderObject);
    renderObject.onPerformLayout = onPerformLayout;
  }
}