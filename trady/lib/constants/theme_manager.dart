import 'package:flutter/material.dart';
import 'package:trady/constants/style_manager.dart';
import 'package:trady/constants/values_manger.dart';
import 'color_manger.dart';
import 'font_manager.dart';

ThemeData getApplicationTheme( bool isDark) {
  if(isDark){
    return ThemeData.dark(useMaterial3: true).copyWith(
        textTheme: TextTheme(
          headline1: getSemiBoldStyle(
              color: ColorManager.black, fontSize: FontSize.s60),
          headline2: getRegularStyle(
              color: ColorManager.black, fontSize: FontSize.s36),
          headline3:
          getBoldStyle(color: ColorManager.black, fontSize: FontSize.s30),
          headline4: getBoldStyle(
              color: ColorManager.black, fontSize: FontSize.s24),
          headline5:getRegularStyle(
              color: ColorManager.black, fontSize: FontSize.s14),
          headline6: getBoldStyle(
              color: ColorManager.black, fontSize: FontSize.s20),
          subtitle1: getBoldStyle(
              color: ColorManager.black, fontSize: FontSize.s18),
          subtitle2: getRegularStyle(
              color: ColorManager.black, fontSize: FontSize.s16),
        ),
        colorScheme: ColorScheme(
          brightness: Brightness.dark,
          primary: ColorManager.primary,
          onPrimary:  ColorManager.error,
          secondary: ColorManager.secondary,
          onSecondary: ColorManager.onSecondary,
          error: ColorManager.error,
          onError: ColorManager.onError,
          background: ColorManager.background,
          onBackground:ColorManager.onBackground,
          surface: ColorManager.surface,
          onSurface: ColorManager.white,

        ));
  }else{
   return ThemeData.light(useMaterial3: true).copyWith(
       textTheme: TextTheme(
         headline1: getSemiBoldStyle(
             color: ColorManager.black, fontSize: FontSize.s60),
         headline2: getRegularStyle(
             color: ColorManager.black, fontSize: FontSize.s36),
         headline3:
         getBoldStyle(color: ColorManager.black, fontSize: FontSize.s30),
         headline4: getBoldStyle(
             color: ColorManager.black, fontSize: FontSize.s24),
         headline5:getRegularStyle(
             color: ColorManager.black, fontSize: FontSize.s14),
         headline6: getBoldStyle(
             color: ColorManager.black, fontSize: FontSize.s20),
         subtitle1: getBoldStyle(
             color: ColorManager.black, fontSize: FontSize.s18),
         subtitle2: getRegularStyle(
             color: ColorManager.black, fontSize: FontSize.s16),
       ),
        colorScheme: ColorScheme(
            brightness: Brightness.light,
            primary: ColorManager.primaryLight,
            onPrimary:   ColorManager.onPrimaryLight,
            secondary: ColorManager.secondary,
            onSecondary: ColorManager.onSecondary,
            error: ColorManager.error,
            onError: ColorManager.onError,
            background: ColorManager.background,
            onBackground:ColorManager.onBackground,
            surface: ColorManager.surfaceLight,
            onSurface: ColorManager.white));
  }

}
