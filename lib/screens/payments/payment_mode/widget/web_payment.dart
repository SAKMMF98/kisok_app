import 'dart:collection';

import 'package:ecitykiosk/screens/home/home_screen.dart';
import 'package:ecitykiosk/screens/payments/payment_mode/payment_mode_view_model.dart';
import 'package:ecitykiosk/screens/payments/payment_mode/widget/show_invoice.dart';
import 'package:ecitykiosk/utils/app_colors.dart';
import 'package:ecitykiosk/utils/common_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
// import 'package:webview_flutter/webview_flutter.dart';

class PaymentWeb extends StatefulWidget {
  const PaymentWeb({Key? key}) : super(key: key);
  static const String routeName = "/paymentPage";

  @override
  State<PaymentWeb> createState() => _PaymentWebState();
}

class _PaymentWebState extends State<PaymentWeb> {
  final String returnUr =
      "https://alphaxtech.net/ecityMerchantWeb/index.html#/home/success";

  static bool onceDone = false;

  // final String invoiceUrl =
  //     "https://alphaxtech.net/ecity/index.php/web/verify/invoice";
  static ValueNotifier<int> progress = ValueNotifier(0);
  static ValueNotifier<String?> error = ValueNotifier(null);
  static final GlobalKey webViewKey = GlobalKey();
  late InAppWebViewController webViewController;
  static String? currentUrl;
  InAppWebViewGroupOptions options = InAppWebViewGroupOptions(
      crossPlatform: InAppWebViewOptions(
        useShouldOverrideUrlLoading: true,
        mediaPlaybackRequiresUserGesture: false,
      ),
      android: AndroidInAppWebViewOptions(
        useHybridComposition: true,
      ),
      ios: IOSInAppWebViewOptions(
        allowsInlineMediaPlayback: true,
      ));

  @override
  initState() {
    getViewModel<PaymentModeViewModel>(context, (viewModel) {
      onceDone = false;
      if (mounted) setState(() {});
      viewModel.checkPaymentDone = (orderId) {
        webViewController.clearCache();
        Navigator.pushNamed(context, InvoicePage.routeName, arguments: orderId);
      };
      viewModel.checkPaymentFailed = () {
        errorToast(msg: viewModel.snackBarText!);
        webViewController.clearCache();
        Navigator.pop(context);
      };
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Map<String, String> paymentData =
        ModalRoute.of(context)?.settings.arguments as Map<String, String>;
    return WillPopScope(
      onWillPop: () async {
        if (currentUrl != null) {
          if (currentUrl!.contains(
                  "https://secure.cinetpay.com/notifypay?csrf_token") &&
              onceDone) {
            Navigator.pushNamedAndRemoveUntil(
                context, HomeScreen.routeName, (route) => false);
          } else {
            Navigator.pop(context);
          }
        } else {
          Navigator.pop(context);
        }
        return Future.value(false);
      },
      child: SafeArea(
        child: Scaffold(
            body: Stack(
          children: [
            InAppWebView(
              key: webViewKey,
              initialUrlRequest:
                  URLRequest(url: Uri.parse(paymentData["initialUrl"]!)),
              initialUserScripts: UnmodifiableListView<UserScript>([]),
              initialOptions: options,
              onWebViewCreated: (controller) {
                webViewController = controller;
              },
              onLoadStart: (controller, url) {
                currentUrl = url.toString();
                progress.value = 0;
                error.value = null;
                if (url.toString() == returnUr) {
                  errorToast(msg: "Payment Failed!!");
                  Navigator.pushNamedAndRemoveUntil(
                      context, HomeScreen.routeName, (route) => false);
                }
              },
              androidOnPermissionRequest:
                  (controller, origin, resources) async {
                return PermissionRequestResponse(
                    resources: resources,
                    action: PermissionRequestResponseAction.GRANT);
              },
              shouldOverrideUrlLoading: (controller, navigationAction) async {
                var uri = navigationAction.request.url;
                if (![
                  "http",
                  "https",
                  "file",
                  "chrome",
                  "data",
                  "javascript",
                  "about"
                ].contains(uri!.scheme)) {
                  if (await canLaunchUrl(uri)) {
                    await launchUrl(uri);
                    return NavigationActionPolicy.CANCEL;
                  }
                }
                return NavigationActionPolicy.ALLOW;
              },
              onLoadStop: (controller, url) async {
                if (url.toString().contains(
                        "https://secure.cinetpay.com/notifypay?csrf_token") &&
                    onceDone) {
                  context.read<PaymentModeViewModel>().checkPayment(
                      txId: paymentData["txId"]!,
                      orderId: paymentData["orderId"]!);
                } else if (url.toString().contains(
                    "https://secure.cinetpay.com/notifypay?csrf_token")) {
                  onceDone = true;
                  if (mounted) setState(() {});
                }
                // if (url.toString() == returnUr) {
                //   webViewController.loadUrl(
                //       urlRequest: URLRequest(url: Uri.parse(invoiceSuccess)));
                //   context
                //       .read<PaymentModeViewModel>()
                //       .checkPayment(txId: paymentData["txId"]!);
                // }
                // else if (url.toString() == invoiceUrl) {
                //   Future.delayed(const Duration(seconds: 3), () {
                //     showToast(msg: "Order Done Successfully!!");
                //     Navigator.pushNamedAndRemoveUntil(
                //         context, HomeScreen.routeName, (route) => false);
                //   });
                // }
              },
              onLoadError: (controller, url, code, message) {
                error.value = message;
              },
              onProgressChanged: (controller, data) {
                progress.value = data;
              },
              onUpdateVisitedHistory: (controller, url, androidIsReload) {},
              onConsoleMessage: (controller, consoleMessage) {},
            ),
            ValueListenableBuilder(
                valueListenable: progress,
                builder: (context, value, child) {
                  return value != 100
                      ? Container(
                          alignment: Alignment.center,
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(8),
                          ), // Dialog background
                          child: const CircularProgressIndicator(
                            color: AppColors.appColor,
                          ),
                        )
                      : const SizedBox.shrink();
                }),
            ValueListenableBuilder<String?>(
                valueListenable: error,
                builder: (context, showError, child) {
                  return showError != null
                      ? Container(
                          alignment: Alignment.center,
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(8),
                          ), // Dialog background
                          child: Text(
                            showError,
                            style: const TextStyle(fontSize: 18),
                          ))
                      : const SizedBox.shrink();
                }),
          ],
        )),
      ),
    );
  }
}
