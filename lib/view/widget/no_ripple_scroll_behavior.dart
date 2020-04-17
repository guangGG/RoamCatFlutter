import 'package:flutter/material.dart';

/// 不显示列表两端水波纹效果
class NoRippleScrollBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    switch (getPlatform(context)) {
      case TargetPlatform.android:
      case TargetPlatform.fuchsia:
        return GlowingOverscrollIndicator(
          child: child,
          //不显示头部水波纹
          showLeading: false,
          //不显示尾部水波纹
          showTrailing: false,
          axisDirection: axisDirection,
          color: Theme.of(context).accentColor,
        );
      default:
        return child;
    }
  }
}

Widget buildNoRippleScrollWidget(Widget widget) {
  return ScrollConfiguration(
    behavior: NoRippleScrollBehavior(),
    child: widget,
  );
}
