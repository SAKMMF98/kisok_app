import 'package:ecitykiosk/data/local/shared_pref_helper.dart';
import 'package:ecitykiosk/screens/common/common_appBar.dart';
import 'package:ecitykiosk/screens/home/home_screen.dart';
import 'package:ecitykiosk/screens/login/widgets/commonButton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

// import 'package:flutter_html/flutter_html.dart';

class InvoicePage extends StatelessWidget {
  const InvoicePage({Key? key}) : super(key: key);
  static const String routeName = "/invoicePage";

  @override
  Widget build(BuildContext context) {
    String orderId = ModalRoute.of(context)?.settings.arguments as String;
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushNamedAndRemoveUntil(
            context, HomeScreen.routeName, (route) => false);
        return Future.value(false);
      },
      child: Scaffold(
        appBar: commonAppBar(
          title: const Text(
            "Invoice",
            style: TextStyle(
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
            child: const Text(
              "Print Invoice",
              style: TextStyle(
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
                "https://alphaxtech.net/ecity/index.php/api/users/kiosk/invoicedetails/$orderId"),
            headers: {
              'authtoken': SharedPrefHelper.authToken,
            },
          ),
        ),
      ),
    );
  }
}
