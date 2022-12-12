import 'package:easy_localization/easy_localization.dart';
import 'package:ecitykiosk/data/local/shared_pref_helper.dart';
import 'package:ecitykiosk/screens/common/common_appBar.dart';
import 'package:ecitykiosk/screens/home/home_screen.dart';
import 'package:ecitykiosk/screens/login/widgets/commonButton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

import '../../../../app.dart';

// import 'package:flutter_html/flutter_html.dart';

class InvoicePage extends StatelessWidget {
  const InvoicePage({Key? key}) : super(key: key);
  static const String routeName = "/invoicePage";

  @override
  Widget build(BuildContext context) {
    Map data = ModalRoute.of(context)?.settings.arguments as Map;
    String orderId = data["orderId"];
    String userType = data["userType"];
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushNamedAndRemoveUntil(
            context, HomeScreen.routeName, (route) => false);
        return Future.value(false);
      },
      child: Scaffold(
        appBar: commonAppBar(
          title: Text(
            "invoice".tr(),
            style: const TextStyle(
                fontFamily: "Josefin_Sans",
                fontWeight: FontWeight.w700,
                fontSize: 22,
                color: Colors.black),
          ),
          isCenter: true,
          leading: IconButton(
            color: Colors.transparent,
            onPressed: () => Navigator.pushNamedAndRemoveUntil(
                context, HomeScreen.routeName, (route) => false),
            icon: const Icon(
              Icons.arrow_back_ios_sharp,
              color: Colors.black,
            ),
          ),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
          child: CommonButton(
            child: Text(
              "print_invoice".tr(),
              style: const TextStyle(
                  fontFamily: "Josefin Sans Regular",
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                  fontSize: 18),
            ),
            onTap: () {
              Navigator.pushNamedAndRemoveUntil(
                  context, HomeScreen.routeName, (route) => false);
            },
          ),
        ),
        body: InAppWebView(
          initialUrlRequest: URLRequest(
            url: Uri.parse(
                "https://alphaxtech.net/ecity/index.php/api/users/kiosk/invoicedetails/$orderId/$userType"),
            headers: {
              'authtoken': SharedPrefHelper.authToken,
              'Accept-Language':
                  navigatorKey.currentContext!.locale.languageCode
            },
          ),
        ),
      ),
    );
  }
}
