import 'package:flutter/material.dart';
import 'package:todo_app/presentation/screens/home_layout.dart';
import 'package:todo_app/core/screens.dart' as screens;
class AppRouter {
  late Widget startScreen;

  Route? onGenerateRoute(RouteSettings settings){
    startScreen =  const HomeLayout();

    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => startScreen);
      case screens.homeLayout:
        return MaterialPageRoute(builder: (_) => const HomeLayout());
      // case screens.mapScreen:
      //   return MaterialPageRoute(builder: (_) => const MapScreen());

      default:
        return null;
    }
  }
}