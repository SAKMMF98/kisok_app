import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:provider/provider.dart';

import 'app.dart';
import 'data/local/shared_pref_helper.dart';
import 'myRoutes.dart';

void main() async {
  final widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await SharedPrefHelper.init();
  runApp(EasyLocalization(
    useOnlyLangCode: true,
    supportedLocales: const [
      Locale('en'),
      Locale('fr'),
    ],
    fallbackLocale: const Locale('en'),
    path: 'assets/locale',
    saveLocale: true,
    startLocale: const Locale('fr'),
    assetLoader: const RootBundleAssetLoader(),
    child: Provider(
      create: (_) => RouteHelper(),
      child: const MyApp(),
    ),
  ));
}
