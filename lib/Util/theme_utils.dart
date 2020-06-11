import 'package:flutter/material.dart';

class ThemeUtils {
  // 默认主题色
  static const MaterialColor defaultColor = Colors.blue;

  // 可选的主题色
  static const List<MaterialColor> supportColors = [
    defaultColor,
    Colors.purple,
    Colors.orange,
    Colors.blue,
    Colors.amber,
    Colors.green,
    Colors.lime,
    Colors.indigo,
    Colors.cyan,
    Colors.teal
  ];

  // 当前的主题色
  static MaterialColor currentColorTheme = defaultColor;

}