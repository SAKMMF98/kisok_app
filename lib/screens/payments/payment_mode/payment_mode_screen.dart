import 'package:ecitykiosk/models/cart_model.dart';
import 'package:ecitykiosk/screens/common/common_appBar.dart';
import 'package:ecitykiosk/screens/home/home_screen.dart';
import 'package:ecitykiosk/screens/payments/payment_mode/payment_mode_view_model.dart';
import 'package:ecitykiosk/screens/payments/payment_mode/widget/expansion_panel.dart';
import 'package:ecitykiosk/screens/payments/payment_mode/widget/pay_button.dart';
import 'package:ecitykiosk/screens/payments/payment_mode/widget/web_payment.dart';
import 'package:ecitykiosk/utils/common_widgets.dart';
import 'package:ecitykiosk/utils/loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import 'widget/otpCheck.dart';

class PaymentModeScreen extends StatefulWidget {
  const PaymentModeScreen({Key? key}) : super(key: key);
  static const routeName = "/paymentMode";

  @override
  State<PaymentModeScreen> createState() => _PaymentModeScreenState();
}

class _PaymentModeScreenState extends State<PaymentModeScreen> {
  bool orderSuccess = false;

  @override
  void initState() {
    super.initState();
    getViewModel<PaymentModeViewModel>(context, (viewModel) {
      viewModel.emailController.clear();
      viewModel.passwordController.clear();
      viewModel.nameController.clear();
      viewModel.openWebView =
          ({required String url, required String txId}) async {
        Navigator.pushNamed(context, PaymentWeb.routeName,
            arguments: {"initialUrl": url, "txId": txId});
      };
      viewModel.userFoundOnECity =
          ({required CartData cartData, required String userId}) async {
        final data = await Navigator.pushNamed(context, OtpScreen.routeName,
            arguments: userId);
        if (data != null && data.runtimeType == String && data != "") {
          viewModel.confirmWithWalletOrder(cartData: cartData, userId: userId);
        }
      };
      viewModel.confirmWithWalletSuccess = (value) {
        orderSuccess = true;
        if (mounted) setState(() {});
        viewModel.emptyCart();
        showToast(msg: "Order Done Successfully");
        launchUrl(Uri.parse(value),
            mode: LaunchMode.inAppWebView, webOnlyWindowName: "Invoice Page");
      };
      viewModel.orderSuccess =
          ({required CartData cartData, required String txId}) async {
        viewModel.paymentByCNetWallet(cartData: cartData, txId: txId);
      };
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (orderSuccess) {
          Navigator.pushNamedAndRemoveUntil(
              context, HomeScreen.routeName, (route) => false);
        }
        return false;
      },
      child: Stack(
        children: [
          Scaffold(
            backgroundColor: Colors.white,
            appBar: commonAppBar(
                title: const Text(
                  "Select Payment Mode",
                  style: TextStyle(
                      fontFamily: "Josefin_Sans",
                      fontWeight: FontWeight.w700,
                      fontSize: 22,
                      color: Colors.black),
                ),
                leading: backButton(context),
                isCenter: true),
            bottomNavigationBar: const PayButton(),
            body: Selector<PaymentModeViewModel, int?>(
              selector: (context, provider) => provider.selectedIndex,
              builder: (context, index, child) {
                return Theme(
                  data: ThemeData(
                    dividerColor: Colors.transparent,
                    expansionTileTheme: const ExpansionTileThemeData(
                      collapsedIconColor: Colors.black,
                      iconColor: Colors.black,
                      textColor: Colors.black,
                      collapsedTextColor: Colors.black,
                    ),
                  ),
                  child: ListView(
                    children: [
                      ExpansionPanelList(
                          animationDuration: const Duration(milliseconds: 800),
                          elevation: 0.0,
                          expandedHeaderPadding: EdgeInsets.zero,
                          dividerColor: Colors.transparent,
                          expansionCallback: (ad, a) {
                            final provider =
                                context.read<PaymentModeViewModel>();
                            if (provider.selectedIndex != ad) {
                              provider.passwordController.clear();
                              provider.emailController.clear();
                            }
                            provider.updateExpansionClick = ad;
                          },
                          children: [
                            CustomExpansion(
                                text: "Ecity Wallet or AFS",
                                isExpand: index == 0,
                                context: context,
                                index: 0,
                                image: 'assets/images/Wallet.png'),
                            CustomExpansion(
                                context: context,
                                isExpand: index == 1,
                                index: 1,
                                text: "Mobile Wallet or Card",
                                image: 'assets/images/mobileWallet.png'),
                            CustomExpansion(
                                context: context,
                                isExpand: index == 2,
                                index: 2,
                                text: "NFC or QR Code",
                                image: 'assets/images/scan.png'),
                            CustomExpansion(
                                context: context,
                                index: 3,
                                isExpand: index == 3,
                                text: "Pay Cash at pick-up",
                                image: 'assets/images/coin.png'),
                          ]),
                    ],
                  ),
                );
              },
            ),
          ),
          const LoadingIndicatorConsumer<PaymentModeViewModel>()
        ],
      ),
    );
  }
}