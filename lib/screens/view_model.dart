import 'dart:developer';
import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';

class ViewModel extends ChangeNotifier {
  bool _isLoading = false;

  set isLoading(value) {
    _isLoading = value;
    notifyListeners();
  }

  get isLoading => _isLoading;

  ///error message for showing in snackBar
  String? snackBarText;
  VoidCallback? onError;

  void callApi(AsyncCallback api) {
    isLoading = true;
    notifyListeners();
    api().then((_) {
      isLoading = false;
      notifyListeners();
    }).catchError((th) {
      isLoading = false;
      log(th.runtimeType.toString());
      log(th.toString());
      if (th is SocketException) {
        snackBarText = "check_your_internet_connection".tr();
      } else if (th is FormatException) {
        snackBarText = "format_exception_found".tr();
      } else {
        snackBarText = "something_went_wrong".tr();
      }
      onError?.call();

      notifyListeners();
    });
  }
}
