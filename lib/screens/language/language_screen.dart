import 'package:easy_localization/easy_localization.dart';
import 'package:ecitykiosk/screens/language/widgets/button_view.dart';
import 'package:flutter/material.dart';

class LanguageSelection extends StatefulWidget {
  static const routeName = '/language_selection';

  const LanguageSelection({Key? key}) : super(key: key);

  @override
  State<LanguageSelection> createState() => _LanguageSelectionState();
}

class _LanguageSelectionState extends State<LanguageSelection> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    bool? isNavigateToHome =
        ModalRoute.of(context)?.settings.arguments as bool?;
    return SafeArea(
      child: Scaffold(
        body: SizedBox(
          height: size.height,
          width: size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Align(
                alignment: Alignment.topCenter,
                child: Padding(
                  padding: EdgeInsets.only(top: 50, bottom: size.height * 0.25),
                  child: Text(
                    "select_app_language".tr(),
                    style: const TextStyle(
                        fontFamily: "Josefin_Sans",
                        fontWeight: FontWeight.w700,
                        fontSize: 16),
                  ),
                ),
              ),
              ButtonView(
                isNavigateToHome: isNavigateToHome,
                name: "fr",
                title: "French",
              ),
              const SizedBox(height: 10),
              ButtonView(
                isNavigateToHome: isNavigateToHome,
                name: "en",
                title: "English",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
