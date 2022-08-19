import 'dart:convert';
import 'package:ecitykiosk/data/local/shared_pref_helper.dart';
import 'package:ecitykiosk/data/remote/http_access.dart';
import 'package:ecitykiosk/data/remote/response.dart';
import 'package:http/http.dart' as http;
import '../remote/end_points.dart';

class PaymentRepo {
  Future<Response> paymentWithWallet(Map<String, dynamic> body) async {
    final response = await Networking.instance
        .post(EndPoints.kWalletOrderUrl, jsonEncode(body));
    final responseJson = jsonDecode(response);
    print("Url $EndPoints.kWalletOrderUrl $Response Data Checking $responseJson");
    print(responseJson);
    bool isSuccess = responseJson["status"] == "200";
    String message = responseJson.containsKey("message")
        ? responseJson["message"]
        : isSuccess
            ? "Payment Successfully!!"
            : "Something Went Wrong!";
    return Response(isSuccess, message,isSuccess?responseJson["record"]:" ");
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

  Future<Response> invoiceCall(Map<String, dynamic> body) async {
    final http.Response res = await http.post(
      Uri.parse(EndPoints.kInvoicePageUrl),
      body: jsonEncode(body),
      headers: {
        'authtoken':SharedPrefHelper.authToken,
        'Content-Type': 'application/json'
      },
    );
    bool isSuccess = res.statusCode==200;
    String message = isSuccess?"Your Order Successfully":"Invoice Error";
    return Response(isSuccess, message, res.body);
  }
}
