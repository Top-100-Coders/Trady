import 'package:flutter/material.dart';
import 'package:trady/constants/color_manger.dart';
import 'package:trady/constants/string_manager.dart';
import 'package:trady/core/service/shared_preferance_service.dart';import '../constants/font_manager.dart';


import '../constants/style_manager.dart';
import '../constants/theme_manager.dart';

class ThemeNotifier with ChangeNotifier {
  bool _isLight =true;

  bool get getIsLight => _isLight;
  // final darkTheme = getApplicationTheme();
  final darkTheme = getApplicationTheme(true);
// final darkTheme = getApplicationTheme();

  final lightTheme =  getApplicationTheme(false);

  ThemeData? _themeData;
  ThemeData? getTheme() => _themeData;
  CacheService cacheService = CacheService();
  ThemeNotifier() {
    cacheService.readCache(key: AppStrings.themeData).then((value) {
      print('value read from storage: ' + value.toString());
      var themeMode = value ?? 'light';
      if (themeMode == 'light') {
        _isLight = true;
        _themeData = lightTheme;
        notifyListeners();
      } else {
        _isLight = false;
        print('setting dark theme');
        _themeData = darkTheme;
        notifyListeners();
      }
      notifyListeners();
    });
  }

  void setDarkMode() async {
    _isLight = false;
    print("darl");
    _themeData = darkTheme;
    cacheService.writeCache(  key: AppStrings.themeData, value: 'dark' );
    notifyListeners();
  }

  void setLightMode() async {
    _isLight = true;
    _themeData = lightTheme;
    cacheService.writeCache(  key: AppStrings.themeData, value: 'light' );
    notifyListeners();
  }
}
