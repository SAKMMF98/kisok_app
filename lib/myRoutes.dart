import 'package:ecitykiosk/data/local/shared_pref_helper.dart';
import 'package:ecitykiosk/screens/cart/cart_view_model.dart';
import 'package:ecitykiosk/screens/payments/payment_mode/widget/web_payment.dart';
import 'package:ecitykiosk/screens/products/product_details/product_details_screen.dart';
import 'package:ecitykiosk/screens/stores/recent_store_details/recent_details.dart';
import 'package:ecitykiosk/screens/stores/recent_stores/recent_stores_Screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'screens/cart/cart_screen.dart';
import 'screens/home/home_screen.dart';
import 'screens/home/home_viewmodel.dart';
import 'screens/login/login_screen.dart';
import 'screens/login/login_viewmodel.dart';
import 'screens/payments/payment_mode/payment_mode_screen.dart';
import 'screens/payments/payment_mode/payment_mode_view_model.dart';
import 'screens/payments/payment_mode/widget/otpCheck.dart';
import 'screens/products/product_details/product_details_viewmodel.dart';
import 'screens/stores/recent_store_details/stores_details_viewmodel.dart';

class RouteHelper {
  final _cartViewModel = CartViewModel();
  final _paymentViewModel = PaymentModeViewModel();

  Map<String, WidgetBuilder> createRoutes() {
    return {
      LoginScreen.routeName: (_) => ChangeNotifierProvider(
            create: (_) => LoginViewModel(),
            child: const LoginScreen(),
          ),
      HomeScreen.routeName: (_) => ChangeNotifierProvider(
            create: (_) => HomeViewModel(),
            child: const HomeScreen(),
          ),
      ProductDetailsScreen.routeName: (_) => ChangeNotifierProvider(
            create: (_) => ProductDetailsViewModel(),
            child: const ProductDetailsScreen(),
          ),
      RecentScreen.routeName: (_) => ChangeNotifierProvider(
            create: (_) => HomeViewModel(),
            child: const RecentScreen(),
          ),
      StoresDetails.routeName: (_) => ChangeNotifierProvider(
            create: (_) => StoreDetailsViewModel(),
            child: const StoresDetails(),
          ),
      CartScreen.routeName: (_) => ChangeNotifierProvider.value(
            value: _cartViewModel,
            child: const CartScreen(),
          ),
      PaymentModeScreen.routeName: (_) => MultiProvider(
            providers: [
              ChangeNotifierProvider.value(
                value: _cartViewModel,
              ),
              ChangeNotifierProvider.value(
                value: _paymentViewModel,
              ),
            ],
            child: const PaymentModeScreen(),
          ),
      PaymentWeb.routeName: (_) => ChangeNotifierProvider.value(
            value: _paymentViewModel,
            child: const PaymentWeb(),
          ),
      OtpScreen.routeName: (_) => ChangeNotifierProvider.value(
            value: _paymentViewModel,
            child: const OtpScreen(),
          )
    };
  }

  String initialRoute() {
    if (SharedPrefHelper.stayLoggedIn) {
      return HomeScreen.routeName;
    } else {
      return LoginScreen.routeName;
    }
  }
}
