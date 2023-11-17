import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../constants/color_manger.dart';
import '../../../constants/style_manager.dart';
import '../../../constants/values_manger.dart';
import '../../../provider/theme_notifier.dart';
import '../../api/order/order_api.dart';
import '../../service/shared_preferance_service.dart';


class TradeNotifier extends ChangeNotifier {
  final TradeAPI _tradeApi = TradeAPI();

  bool _isLoading = false;
  String? _orderID;

  bool get getIsLoading => _isLoading;
  String? get getOrderID => _orderID;


  CacheService cashService = CacheService();

  void successCall(BuildContext context){
    final themeNotifier = context.read<ThemeNotifier>();
    AwesomeDialog(
      context: context,
      dialogType: DialogType.success,
      buttonsBorderRadius:
      const BorderRadius.all(
        Radius.circular(2),
      ),
      dismissOnTouchOutside: true,
      dismissOnBackKeyPress: false,
      headerAnimationLoop: false,
      animType: AnimType.bottomSlide,
      title: 'Order Status',
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
      desc: 'Successfully your order placed\nOrder ID:$_orderID',
      // showCloseIcon: true,
      // btnCancelOnPress: () {},
    ).show();
  }


  Future<void> tradeNotifier({
    required BuildContext context,
    required String tradingSymbol,
    required String exchange,
    required String transactionType,
    required String orderType,
    required String quantity,
    required String product,
    required String validity,
  }) async {
    try {
      _isLoading = true;
      notifyListeners();
      if(false){
        final data = await _tradeApi.tradeApi(tradingSymbol: tradingSymbol, exchange: exchange, transactionType: transactionType, orderType: orderType, quantity: quantity, product: product, validity: validity);
        _orderID = data["data"]["order_id"];
        successCall(context);

      }else{
        _orderID = "55633556563";
        notifyListeners();
        successCall(context);

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