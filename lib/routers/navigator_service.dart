import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
    
final GetIt locator = GetIt.instance;

class NavigationService {
  final GlobalKey<NavigatorState> navigatorKey =
      new GlobalKey<NavigatorState>();
      
  Future<dynamic> navigateTo(String routeName, String filter) {
    return navigatorKey.currentState!.pushNamed(routeName, arguments: filter);
  }

  void setupLocator() {
    locator.registerLazySingleton(() => NavigationService());
  }
}