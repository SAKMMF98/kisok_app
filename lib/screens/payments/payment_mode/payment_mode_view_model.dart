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
  ValueChanged<String>? invoiceShow;
  void Function({required String url, required String txId})? openWebView;
  void Function({required CartData cartData, required String userId})?
      userFoundOnECity;
  ValueChanged<String>? pinMatchedSuccess;
  ValueChanged<String>? confirmWithWalletSuccess;
  void Function({required CartData cartData, required String txId})?
      orderSuccess;
  VoidCallback? checkPaymentDone;
  VoidCallback? checkPaymentFailed;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController pinController = TextEditingController();
  int? _selectedExpansion;

  int? get selectedIndex => _selectedExpansion;

  bool _visiblePassword = false;

  bool get visible => _visiblePassword;

  set visibleSet(bool value) {
    _visiblePassword = value;
    notifyListeners();
  }

  set updateExpansionClick(int value) {
    _selectedExpansion = value;
    emailController.clear();
    passwordController.clear();
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
          paymentByCash();
          break;
      }
    }
  }

  void invoicePage(String id) {
    callApi(() async {
      Map<String, dynamic> body = {"invoice_id": id};
      Response response = await _paymentRepo.invoiceCall(body);
      if (response.isSuccessFul) {
        invoiceShow?.call(response.data.toString());
      } else {
        snackBarText="Something Went Wrong With Invoice.";
        onError?.call();
      }
    });
  }

  void paymentByECityWallet(CartData cartData) {
    String? isPassword = isValidPassword(passwordController.text);
    if (isPassword != null) {
      snackBarText = isPassword;
      onError?.call();
    } else {
      callApi(() async {
        Map<String, String> data = {
          "email": emailController.text,
          "password": passwordController.text,
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
    }
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
        "id": userId
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

  void paymentByCNetWallet({required CartData cartData, required String txId}) {
    String url;
    try {
      url =
          "https://alphaxtech.net/ecity/index.php/web/Verify/createSignature?user_id=${SharedPrefHelper.userId}&merchant_id=${cartData.storeInfo?.merchantId}&payment_mode=phone&payment_for=2&reference_id=0&order_amount=${cartData.cart?.totalDiscountedPrice}&cpm_trans_id=$txId&store_id=${cartData.storeInfo?.id}";
      openWebView?.call(url: url, txId: txId);
    } catch (_) {
      snackBarText = "Something Went Wrong";
      onError?.call();
    }
  }

  void checkPayment({required String txId}) {
    callApi(() async {
      Map<String, String> body = {"cpm_trans_id": txId};
      Response response = await _orderRepo.checkPayment(body);
      emptyCart();
      if (response.isSuccessFul) {
        snackBarText = response.message;
        checkPaymentDone?.call();
      } else {
        snackBarText = response.message;
        checkPaymentFailed?.call();
        onError?.call();
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
        orderSuccess?.call(cartData: cartData, txId: cpmId);
      } else {
        snackBarText = response.message;
        onError?.call();
      }
    });
  }

  void paymentByQrCode() {}

  void paymentByCash() {}

  void emptyCart() async {
    callApi(() async {
      _cartRepo.emptyCart();
    });
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
