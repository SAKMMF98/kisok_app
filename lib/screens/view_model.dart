import 'dart:developer';
import 'dart:io';

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
        snackBarText = "Check Your Internet Connection.";
      } else if (th is FormatException) {
        snackBarText = "Format Exception Caught.";
      } else {
        snackBarText = "Something went wrong, Please try again later";
      }
      onError?.call();

      notifyListeners();
    });
  }
}
