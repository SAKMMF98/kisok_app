import 'dart:convert';

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
            ? "Order Placed Successfully!!"
            : "Something Went Wrong!";
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
            ? "Payment Done Successfully!!"
            : "Something Went Wrong!";
    return Response(isSuccess, message, "");
  }
}
