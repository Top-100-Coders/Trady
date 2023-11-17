

import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:trady/core/notifier/auth/auth_notifier.dart';

import 'package:trady/provider/theme_notifier.dart';

import '../core/notifier/analysis/analysis.notifier.dart';
import '../core/notifier/auth/logout_notifier.dart';
import '../core/notifier/trade/trade_notifier.dart';


List<SingleChildWidget> providers = [...remoteProvider];

//independent providers
List<SingleChildWidget> remoteProvider = [
  ChangeNotifierProvider(create: (_) => LoginNotifier()),
  ChangeNotifierProvider(create: (_) => ThemeNotifier()),
  ChangeNotifierProvider(create: (_) => LogoutNotifier()),
  ChangeNotifierProvider(create: (_) => TradeNotifier()),
  ChangeNotifierProvider(create: (_) => AnalysisNotifier()),

];