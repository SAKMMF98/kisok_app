import 'dart:convert';

import 'package:ecitykiosk/data/remote/end_points.dart';
import 'package:ecitykiosk/data/remote/http_access.dart';
import 'package:ecitykiosk/models/cart_model.dart';

import '../remote/response.dart';

class CartRepo {
  Future<Response> addToCart(Map<String, dynamic> body) async {
    final response = await Networking.instance
        .post(EndPoints.kAddToCartUrl, jsonEncode(body));
    final responseJson = jsonDecode(response);
    bool isSuccess = responseJson["status"] == "200";
    String message = responseJson.containsKey("message")
        ? responseJson["message"]
        : isSuccess
            ? "Card Added Successfully!!"
            : "Something Went Wrong!";
    print("Response Check $response");
    return Response(isSuccess, message, "");
  }

  Future<CartData?> getCartDetail() async {
    final response = await Networking.instance.get(EndPoints.kGetCartUrl);
    CartData? cartData;
    final responseJson = jsonDecode(response);
    if (responseJson["status"] == "200") {
      cartData = CartData.fromJson(responseJson["record"]);
    }
    return cartData;
  }

  Future<Response> emptyCart() async {
    final response =
        await Networking.instance.post(EndPoints.kEmptyCartUrl, "{}");
    final responseJson = jsonDecode(response);
    bool isSuccess = responseJson["status"] == "200";
    String message =
        isSuccess ? "Cart Removed Successfully!!" : "Something Went Wrong!!";
    return Response(isSuccess, message, "");
  }

  Future<Response> removeFromCart(String productId) async {
    final response =
        await Networking.instance.get(EndPoints.kRemoveFromCartUrl + productId);
    final responseJson = jsonDecode(response);
    bool isSuccess = responseJson["status"] == "200";
    String message =
        isSuccess ? "Cart Removed Successfully!!" : "Something Went Wrong!!";
    return Response(isSuccess, message, "");
  }
}
