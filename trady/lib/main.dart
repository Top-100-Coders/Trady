import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'package:trady/constants/color_manger.dart';
import 'package:trady/constants/theme_manager.dart';
// import 'package:lm_pay/screens/intro/splash_screen.dart';
// import 'package:provider/provider.dart';
import 'package:trady/constants/app_routes.dart';
import 'package:trady/provider/providers.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trady/constants/theme_manager.dart';
import 'package:trady/provider/theme_notifier.dart';
import 'package:trady/screens/home/home_screen.dart';

import 'constants/string_manager.dart';
import 'core/service/shared_preferance_service.dart';




//delete this whenever you got context idea
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
final GlobalKey<ScaffoldMessengerState> snackbarKey = GlobalKey<ScaffoldMessengerState>();

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: "lib/.env" );
  CacheService cashService = CacheService();
  cashService.writeCache(key: AppStrings.token2, value: dotenv.env["OPENAIAPIKEY"] ?? "");

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: providers,
      child: Builder(builder: (context) {
        return ScreenUtilInit(
          designSize: const Size(360, 640),
          minTextAdapt: true,
          splitScreenMode: true,
          builder: (_,k) => MaterialApp(

            navigatorKey: navigatorKey,
            scaffoldMessengerKey: snackbarKey,
            theme: Provider.of<ThemeNotifier>(context).getTheme(),
            debugShowCheckedModeBanner: false,
            routes: routes,
            initialRoute: loginRoute,
            // initialRoute: loginRoute,

          ),
        );
      }),
    );
  }
}


