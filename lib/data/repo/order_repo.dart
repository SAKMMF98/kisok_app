import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';
import 'package:ecitykiosk/data/remote/end_points.dart';
import 'package:ecitykiosk/data/remote/http_access.dart';
import 'package:ecitykiosk/data/remote/response.dart';

class OrderRepo {
  Future<Response> confirmOrderApi(Map<String, dynamic> body) async {
    final response =
        await Networking.instance.post(EndPoints.kOrderUrl, jsonEncode(body));
    final responseJson = jsonDecode(response);
    bool isSuccess = responseJson["status"] == "200";
    String message = responseJson.containsKey("message")
        ? responseJson["message"]
        : isSuccess
            ? "order_placed_successfully".tr()
            : "something_went_wrong".tr();
    return Response(
      isSuccess,
      message,
      isSuccess
          ? {
              "record": responseJson["record"].toString(),
              "type": responseJson["type"].toString()
            }
          : "",
    );
  }

  Future<Response> cashOrderApi(Map<String, dynamic> body) async {
    final response = await Networking.instance
        .post(EndPoints.kCashOrderApi, jsonEncode(body));
    final responseJson = jsonDecode(response);
    bool isSuccess = responseJson["status"] == "200";
    String message = responseJson.containsKey("message")
        ? responseJson["message"]
        : isSuccess
            ? "order_placed_successfully".tr()
            : "something_went_wrong".tr();
    return Response(
        isSuccess,
        message,
        isSuccess
            ? {
                "record": responseJson["record"].toString(),
                "type": responseJson["type"].toString()
              }
            : "");
  }

  Future<Response> checkPayment(Map<String, dynamic> body) async {
    final response = await Networking.instance
        .post(EndPoints.kCheckPaymentUrl, jsonEncode(body));
    final responseJson = jsonDecode(response);
    bool isSuccess = responseJson["status"] == "200";
    String message = responseJson.containsKey("message")
        ? responseJson["message"]
        : isSuccess
            ? "payment_done_successfully".tr()
            : "something_went_wrong".tr();
    return Response(isSuccess, message, "");
  }
}
