import 'dart:async';

import 'package:ecitykiosk/data/repo/cart_repo.dart';
import 'package:ecitykiosk/myRoutes.dart';
import 'package:ecitykiosk/screens/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:provider/provider.dart';

import 'utils/app_colors.dart';

final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Timer? _timer;

  @override
  initState() {
    FlutterNativeSplash.remove();
    startTimer();
    super.initState();
  }

  void startTimer() {
    _timer?.cancel();
    _timer = Timer(const Duration(minutes: 5), () async {
      if (_navigatorKey.currentContext != null) {
        print("Called Function");
        await CartRepo().emptyCart();
        Navigator.pushNamedAndRemoveUntil(_navigatorKey.currentContext!,
            HomeScreen.routeName, (route) => false);
      }
      _timer?.cancel();
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () => startTimer(),
      onPanDown: (sa) => startTimer(),
      onPanUpdate: (sa) => startTimer(),
      child: MaterialApp(
        navigatorKey: _navigatorKey,
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
      ),
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
