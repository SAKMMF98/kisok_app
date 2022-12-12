import 'package:easy_localization/easy_localization.dart';
import 'package:ecitykiosk/data/local/shared_pref_helper.dart';
import 'package:ecitykiosk/screens/home/home_screen.dart';
import 'package:ecitykiosk/screens/login/login_screen.dart';
import 'package:ecitykiosk/utils/app_colors.dart';
import 'package:flutter/material.dart';

class ButtonView extends StatelessWidget {
  final String name, title;
  final bool? isNavigateToHome;

  const ButtonView({
    Key? key,
    this.isNavigateToHome,
    required this.name,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        SharedPrefHelper.languageSelected = true;
        context.setLocale(Locale(name));
        if (isNavigateToHome == null) {
          Navigator.pushNamed(context, LoginScreen.routeName);
        } else {
          Navigator.pushNamedAndRemoveUntil(
              context, HomeScreen.routeName, (route) => false);
        }
      },
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(AppColors.appColor),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
      ),
      child: Text(
        title,
        style: const TextStyle(
            fontFamily: "Josefin_Sans",
            fontWeight: FontWeight.w600,
            fontSize: 16),
      ),
    );
  }
}
