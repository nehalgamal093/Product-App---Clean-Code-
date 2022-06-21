import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:new_project_flutter_udemy/app/app_prefs.dart';

import '../presentation/resources/routes_manager.dart';
import '../presentation/resources/theme_manager.dart';
import 'di.dart';

class MyApp extends StatefulWidget {
// named constructor
  const MyApp._internal();

  static const MyApp _instance =
      MyApp._internal(); //singleton or single instance

  factory MyApp() => _instance; // factory

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  final AppPrefrences _appPrefrences = instance<AppPrefrences>();
  @override
  void didChangeDependencies() {
    _appPrefrences.getLocal().then((local) => {
      context.setLocale(local)
    });
    super.didChangeDependencies();
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      debugShowCheckedModeBanner: false,
      onGenerateRoute: RouteGenerator.getRoute,
      initialRoute: Routes.splashRoute,
      theme: getApplicationTheme(),
    );
  }
}
