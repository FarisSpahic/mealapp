import 'package:flutter/material.dart';

 ThemeData _darkTheme = ThemeData(
  colorScheme: const ColorScheme(
    background: Colors.black45,
    brightness: Brightness.dark,
    error: Colors.pinkAccent,
    onBackground: Colors.pink,
    onError: Colors.pink,
    onPrimary: Colors.white,
    primary: Colors.white,
    secondary: Colors.black,
    surface: Colors.grey,
    onSurface: Colors.transparent,
    onSecondary: Colors.transparent
  )
);
ThemeData darkThemeConfig() => _darkTheme;
class ThemePallete extends ChangeNotifier{
  static bool _isDark = true;
  bool getIsDarkValue() => _isDark;
  ThemeMode currentTheme(){
    return _isDark ? ThemeMode.dark : ThemeMode.light;
  }
  void switchTheme(){
    _isDark = !_isDark;
    notifyListeners();
  }
}