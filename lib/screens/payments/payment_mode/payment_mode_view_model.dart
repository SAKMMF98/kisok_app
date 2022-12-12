import 'package:easy_localization/easy_localization.dart';
import 'package:ecitykiosk/data/local/shared_pref_helper.dart';
import 'package:ecitykiosk/data/remote/response.dart';
import 'package:ecitykiosk/data/repo/cart_repo.dart';
import 'package:ecitykiosk/data/repo/order_repo.dart';
import 'package:ecitykiosk/data/repo/payment_repo.dart';
import 'package:ecitykiosk/models/cart_model.dart';
import 'package:ecitykiosk/utils/common_widgets.dart';
import 'package:ecitykiosk/utils/validations.dart';
import 'package:flutter/material.dart';

import '../../view_model.dart';

class PaymentModeViewModel extends ViewModel with CommonValidations {
  final _orderRepo = OrderRepo();
  final _cartRepo = CartRepo();
  final _paymentRepo = PaymentRepo();
  void Function(
      {required String url,
      required String txId,
      required String orderId,
      required String userType})? openWebView;
  void Function({required CartData cartData, required String userId})?
      userFoundOnECity;
  ValueChanged<String>? pinMatchedSuccess;
  ValueChanged<String>? confirmWithWalletSuccess;
  void Function({required String orderId, required String userType})?
      confirmWithCash;
  void Function(
      {required CartData cartData,
      required String txId,
      required String orderId,
      required String userType})? orderSuccess;
  Function({required String orderId, required String userType})?
      checkPaymentDone;
  VoidCallback? checkPaymentFailed;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController pinController = TextEditingController();
  int? _selectedExpansion;

  int? get selectedIndex => _selectedExpansion;

  bool _visiblePassword = false;

  bool get visible => _visiblePassword;

  set visibleSet(bool value) {
    _visiblePassword = value;
    notifyListeners();
  }

  set updateExpansionClick(int? value) {
    _selectedExpansion = value;
    emailController.clear();
    passwordController.clear();
    addressController.clear();
    nameController.clear();
    notifyListeners();
  }

  void payNow(CartData cartData) {
    hideKeyBoard();
    String? isEmail = isValidEmail(emailController.text);
    if (isEmail != null) {
      snackBarText = isEmail;
      onError?.call();
    } else {
      switch (_selectedExpansion) {
        case 0:
          paymentByECityWallet(cartData);
          break;
        case 1:
          confirmOrder(cartData: cartData);
          break;
        case 2:
          paymentByQrCode();
          break;
        case 3:
          paymentByCash(cartData: cartData);
          break;
      }
    }
  }

  void paymentByECityWallet(CartData cartData) {
    // String? isPassword = isValidPassword(passwordController.text);
    // if (isPassword != null) {
    //   snackBarText = isPassword;
    //   onError?.call();
    // } else {
    callApi(() async {
      Map<String, String> data = {
        "email": emailController.text,
        // "password": passwordController.text.toString(),
      };
      Response response = await _paymentRepo.checkUserOnECity(data);
      if (response.isSuccessFul) {
        userFoundOnECity?.call(cartData: cartData, userId: response.data);
        snackBarText = response.message;
      } else {
        snackBarText = response.message;
        onError?.call();
      }
    });
    // }
  }

  void pinMatch({required String userId, required String pin}) async {
    callApi(() async {
      Map<String, dynamic> body = {"id": userId, "pin": pin};
      Response response = await _paymentRepo.userPinMatch(body);
      if (response.isSuccessFul) {
        snackBarText = response.message;
        pinMatchedSuccess?.call(userId);
      } else {
        snackBarText = response.message;
        onError?.call();
      }
    });
  }

  void confirmWithWalletOrder(
      {required CartData cartData, required String userId}) {
    String cpmId = "ORDER_${DateTime.now().millisecondsSinceEpoch}";
    callApi(() async {
      Map<String, String> data = {
        "group_id": "",
        "clan_userId": "",
        "camp_id": "",
        "cart_total": cartData.cart?.totalDiscountedPrice ?? "",
        "txn_id": cpmId,
        "email": emailController.text
      };
      Response response = await _paymentRepo.paymentWithWallet(data);
      if (response.isSuccessFul) {
        confirmWithWalletSuccess?.call(response.data.toString());
        snackBarText = response.message;
      } else {
        snackBarText = response.message;
        onError?.call();
      }
    });
  }

  void paymentByCNetWallet(
      {required CartData cartData,
      required String txId,
      required String orderId,
      required String userType}) {
    String url;
    try {
      url =
          "https://alphaxtech.net/ecity/index.php/web/Verify/createSignature?user_id=${SharedPrefHelper.userId}&merchant_id=${cartData.storeInfo?.merchantId}&payment_mode=phone&payment_for=2&reference_id=0&order_amount=${cartData.cart?.totalDiscountedPrice}&cpm_trans_id=$txId&store_id=${cartData.storeInfo?.id}";
      openWebView?.call(
          url: url, txId: txId, orderId: orderId, userType: userType);
    } catch (_) {
      snackBarText = "something_went_wrong".tr();
      onError?.call();
    }
  }

  void checkPayment(
      {required String txId,
      required String orderId,
      required String userType}) {
    callApi(() async {
      Map<String, String> body = {"cpm_trans_id": txId};
      Response response = await _orderRepo.checkPayment(body);
      emptyCart();
      if (response.isSuccessFul) {
        snackBarText = response.message;
        checkPaymentDone?.call(orderId: orderId, userType: userType);
      } else {
        snackBarText = response.message;
        checkPaymentFailed?.call();
      }
    });
  }

  void confirmOrder({required CartData cartData}) {
    String cpmId = "ORDER_${DateTime.now().millisecondsSinceEpoch}";
    String totalAmount = cartData.cart!.totalDiscountedPrice.toString();
    callApi(() async {
      Map<String, String> body = {
        "email": emailController.text,
        "camp_id": "",
        "group_id": "",
        "clan_userId": "",
        "tx_id": cpmId,
        "cart_total": totalAmount
      };
      Response response = await _orderRepo.confirmOrderApi(body);
      if (response.isSuccessFul) {
        snackBarText = response.message;
        orderSuccess?.call(
            cartData: cartData,
            txId: cpmId,
            orderId: response.data["record"].toString(),
            userType: response.data["type"].toString());
      } else {
        snackBarText = response.message;
        onError?.call();
      }
    });
  }

  void paymentByQrCode() {}

  void paymentByCash({required CartData cartData}) {
    String? isName = isValidName(nameController.text, "name".tr());
    String? isAddress = isNotEmpty(addressController.text, "address".tr());
    String cpmId = "ORDER_${DateTime.now().millisecondsSinceEpoch}";
    String totalAmount = cartData.cart!.totalDiscountedPrice.toString();
    if (isName != null) {
      snackBarText = isName;
      onError?.call();
    } else if (isAddress != null) {
      snackBarText = isAddress;
      onError?.call();
    } else {
      callApi(() async {
        Map<String, String> body = {
          "name": nameController.text,
          "address": addressController.text,
          "email": emailController.text,
          "tx_id": cpmId,
          "cart_total": totalAmount,
          "payment_mode": "1",
          "group_id": ""
        };
        Response response = await _orderRepo.cashOrderApi(body);
        if (response.isSuccessFul) {
          snackBarText = response.message;
          confirmWithCash?.call(
              orderId: response.data["record"].toString(),
              userType: response.data["type"].toString());
        } else {
          snackBarText = response.message;
          onError?.call();
        }
      });
    }
  }

  void emptyCart() async {
    callApi(() async {
      _cartRepo.emptyCart();
    });
  }

  @override
  void dispose() {
    emailController.dispose();
    addressController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
