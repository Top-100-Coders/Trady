
import 'dart:developer';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trady/constants/constants.dart';
import 'package:trady/constants/font_manager.dart';
import 'package:trady/constants/string_manager.dart';
import 'package:trady/core/api/analysis/analysis_api.dart';
import '../../../constants/color_manger.dart';
import '../../../constants/style_manager.dart';
import '../../../constants/values_manger.dart';
import '../../../provider/theme_notifier.dart';
import '../../api/order/order_api.dart';
import '../../service/shared_preferance_service.dart';


class AnalysisNotifier extends ChangeNotifier {
  final AnalysisApi _analysisAPI = AnalysisApi();

  bool _isLoading = false;

  bool get getIsLoading => _isLoading;





  Future<void> analysisNotifier({
    required BuildContext context,
    required String base64Image,

  }) async {
    final themeNotifier = context.read<ThemeNotifier>();
    try {
      _isLoading = true;
      notifyListeners();
        Map data = await _analysisAPI.analysisApi(base64Image: base64Image);
      if (!data.containsKey("error")){
        showModalBottomSheet(
          context: context,
          builder: (BuildContext context) {
            return Container(
              padding: EdgeInsets.symmetric(horizontal: AppPadding.p16,vertical: AppPadding.p12),
              decoration: BoxDecoration(
                color:  !themeNotifier.getIsLight
                    ? ColorManager.black
                    : ColorManager.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12.0),
                  topRight: Radius.circular(12.0),
                ),
              ),
              child: SingleChildScrollView(
                child: Column(
                  // mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text("My Analysis Acoording to the provided data",style: getBoldStyle(color:  themeNotifier.getIsLight
                        ? ColorManager.black
                        : ColorManager.white,fontSize: FontSize.s16),),
            kSizedBox12,
            Text(data["choices"][0]["message"]["content"],style: getRegularStyle(color:  themeNotifier.getIsLight
            ? ColorManager.black
                  : ColorManager.white,fontSize: FontSize.s14),),
                  ],
                ),
              ),
            );
          },
        );
      }else{
        AwesomeDialog(
          context: context,
          dialogType: DialogType.warning,
          buttonsBorderRadius:
          const BorderRadius.all(
            Radius.circular(2),
          ),
          dismissOnTouchOutside: true,
          dismissOnBackKeyPress: false,
          headerAnimationLoop: false,
          animType: AnimType.bottomSlide,
          title: 'Warning',
          titleTextStyle: getBoldStyle(
              color: themeNotifier.getIsLight
                  ? ColorManager.primaryLight
                  : ColorManager.primary,
              fontSize: AppSize.s18),
          descTextStyle: getSemiBoldStyle(
              color: themeNotifier.getIsLight
                  ? ColorManager.black
                  : ColorManager.white,
              fontSize: AppSize.s16),
          desc: 'Please try again, we could not analyse the graph now.',
          showCloseIcon: true,
        ).show();

      }



        _isLoading = false;
      notifyListeners();
    } catch(error){
      _isLoading = false;
      notifyListeners();
      rethrow;
    }
  }

}