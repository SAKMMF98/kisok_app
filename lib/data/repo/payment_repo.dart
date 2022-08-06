import 'dart:convert';

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
            ? "Order Added Successfully!!"
            : "Something Went Wrong!";
    return Response(isSuccess, message,
        "https://alphaxtech.net/ecity/index.php/web/notify/return1");
  }

  Future<Response> checkUserOnECity(Map<String, dynamic> body) async {
    final response =
        await Networking.instance.post(EndPoints.kCheckUser, jsonEncode(body));
    final responseJson = jsonDecode(response);
    bool isSuccess = responseJson["status"] == "200";
    String message = responseJson.containsKey("message")
        ? responseJson["message"]
        : isSuccess
            ? "User Found Successfully!!"
            : "Something Went Wrong!";
    String userId =
        responseJson.containsKey("record") ? responseJson["record"]["id"] : "";
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
            ? "Pin Matched Successfully!!"
            : "Something Went Wrong!";
    String userId =
        responseJson.containsKey("record") ? responseJson["record"]["id"] : "";
    return Response(isSuccess, message, userId);
  }
}
