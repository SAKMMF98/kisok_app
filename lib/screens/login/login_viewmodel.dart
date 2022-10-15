import 'dart:convert';

import 'package:ecitykiosk/data/local/shared_pref_helper.dart';
import 'package:ecitykiosk/data/remote/end_points.dart';
import 'package:ecitykiosk/data/remote/http_access.dart';
import 'package:ecitykiosk/screens/view_model.dart';
import 'package:ecitykiosk/utils/common_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_udid/flutter_udid.dart';
import 'package:location/location.dart';

class LoginViewModel extends ViewModel {
  String? kioskId, password;

  VoidCallback? onSuccess;

  void performLogin(BuildContext context) async {
    hideKeyBoard();
    Location location = Location.instance;
    PermissionStatus _locationStatus = await location.hasPermission();
    if (_locationStatus == PermissionStatus.granted) {
      _login();
    } else {
      PermissionStatus locationStatus = await location.requestPermission();
      if (locationStatus == PermissionStatus.granted) {
        _login();
      } else {
        snackBarText = "For Login Access Required Location Permission";
      }
    }
  }

  Future<void> _login() async {
    Location location = Location.instance;
    if (!isLoading) {
      callApi(() async {
        LocationData _locationData = await location.getLocation();
        String deviceId = await FlutterUdid.udid;
        Map<String, String> bodyData = {
          "kiosk_name": kioskId ?? "",
          "password": password ?? "",
          "device_name": deviceId,
          "latitude": _locationData.latitude.toString(),
          "longitude": _locationData.longitude.toString(),
        };
        final response = await Networking.instance
            .post(EndPoints.kLoginUrl, jsonEncode(bodyData));
        var data = jsonDecode(response);
        if (data["status"] == "200") {
          SharedPrefHelper.userId = data["record"]["id"];
          SharedPrefHelper.authToken = data["record"]["authtoken"];
          SharedPrefHelper.stayLoggedIn = true;
          onSuccess?.call();
        } else {
          snackBarText = data["message"];
          onError?.call();
        }
      });
    }
  }
}
