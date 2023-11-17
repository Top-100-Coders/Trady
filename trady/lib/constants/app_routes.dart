
import 'package:flutter/material.dart';
import 'package:trady/screens/auth/login_screen.dart';

import '../screens/home/home_screen.dart';
import '../screens/main.dart';
const String mainRoute = "/mainRoute";
const String homeRoute = "/homeRoute";
const String loginRoute = "/login";



Map<String, Widget Function(BuildContext)> routes = {
  mainRoute: (context) => const MainScreen(),
  homeRoute: (context) => const HomeScreen(),
  loginRoute: (context) => const Login(),


};
