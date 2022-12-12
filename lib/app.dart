import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:ecitykiosk/data/local/shared_pref_helper.dart';
import 'package:ecitykiosk/data/repo/cart_repo.dart';
import 'package:ecitykiosk/myRoutes.dart';
import 'package:ecitykiosk/screens/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:provider/provider.dart';

import 'utils/app_colors.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

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
    _startTimer();
    super.initState();
  }

  void _startTimer() {
    Duration _duration = const Duration(minutes: 5);
    _timer?.cancel();
    _timer = Timer(_duration, () async {
      if (navigatorKey.currentContext != null &&
          SharedPrefHelper.stayLoggedIn) {
        await CartRepo().emptyCart();
        Navigator.pushNamedAndRemoveUntil(
          navigatorKey.currentContext!,
          HomeScreen.routeName,
          (route) => false,
        );
      }
      _timer?.cancel();
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () => _startTimer(),
      onPanDown: (_) => _startTimer(),
      onPanUpdate: (_) => _startTimer(),
      child: MaterialApp(
        navigatorKey: navigatorKey,
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        restorationScopeId: 'app',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: AppColors.appColor,
          bottomSheetTheme: const BottomSheetThemeData(
              backgroundColor: Colors.transparent, elevation: 0.0),
        ),
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
