import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';
import 'package:ecitykiosk/data/remote/http_access.dart';
import 'package:ecitykiosk/data/remote/response.dart';

import '../remote/end_points.dart';

class PaymentRepo {
  Future<Response> paymentWithWallet(Map<String, dynamic> body) async {
    final response = await Networking.instance
        .post(EndPoints.kWalletOrderUrl, jsonEncode(body));
    final responseJson = jsonDecode(response);
    bool isSuccess = responseJson["status"] == "200";
    String message = responseJson.containsKey("message")
        ? responseJson["message"]
        : isSuccess
            ? "payment_success".tr()
            : "something_went_wrong".tr();
    return Response(
        isSuccess, message, isSuccess ? responseJson["record"] : " ");
  }

  Future<Response> checkUserOnECity(Map<String, dynamic> body) async {
    final response =
        await Networking.instance.post(EndPoints.kCheckUser, jsonEncode(body));
    final responseJson = jsonDecode(response);
    bool isSuccess = responseJson["status"] == "200";
    String message = responseJson.containsKey("message")
        ? responseJson["message"]
        : isSuccess
            ? "user_found_successfully".tr()
            : responseJson["record"].first.toString();
    String userId = isSuccess ? responseJson["record"]["id"] : "";
    return Response(isSuccess, message, userId);
  }

  Future<Response> userPinMatch(Map<String, dynamic> body) async {
    final response = await Networking.instance
        .post(EndPoints.kUserPinMatchUrl, jsonEncode(body));
    final responseJson = jsonDecode(response);
    bool isSuccess = responseJson["status"] == "200";
    String message = responseJson.containsKey("message")
        ? responseJson["message"]
        : isSuccess
            ? "pin_matched_successfully".tr()
            : "something_went_wrong".tr();
    String userId =
        responseJson.containsKey("record") ? responseJson["record"]["id"] : "";
    return Response(isSuccess, message, userId);
  }
}
