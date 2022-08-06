import 'package:ecitykiosk/myRoutes.dart';
import 'package:ecitykiosk/screens/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:provider/provider.dart';
import 'utils/app_colors.dart';

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  initState() {
    FlutterNativeSplash.remove();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      restorationScopeId: 'app',
      debugShowCheckedModeBanner: false,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en', ''),
      ],
      theme: ThemeData(
          primaryColor: AppColors.appColor,
          bottomSheetTheme: const BottomSheetThemeData(
              backgroundColor: Colors.transparent, elevation: 0.0)),
      darkTheme: ThemeData(primaryColor: AppColors.appColor),
      initialRoute: context.read<RouteHelper>().initialRoute(),
      routes: context.read<RouteHelper>().createRoutes(),
    );
  }
}
