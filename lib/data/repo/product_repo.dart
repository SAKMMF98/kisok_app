import 'dart:convert';

import 'package:ecitykiosk/data/remote/end_points.dart';
import 'package:ecitykiosk/data/remote/http_access.dart';
import 'package:ecitykiosk/models/product_details_model.dart';
import 'package:ecitykiosk/models/product_model.dart';

class ProductsRepo {
  Future<List<ProductData>> getProductListByStore(
      {required String storeId, required int page}) async {
    Map body = {"page_no": "$page"};
    final response = await Networking.instance
        .post(EndPoints.kStoreProductUrl + storeId, jsonEncode(body));
    final responseJson = jsonDecode(response);
    List<ProductData> data = [];
    if (responseJson["status"] == "200") {
      var checkData = responseJson["record"]["data"];
      data =
          checkData.map<ProductData>((e) => ProductData.fromJson(e)).toList();
    }
    return data;
  }

  Future<ProductDetailsModel?> getDetails({required String storeId}) async {
    final response = await Networking.instance
        .get(EndPoints.kStoreProductDetailsUrl + storeId);
    final responseJson = jsonDecode(response);
    ProductDetailsModel? data;
    if (responseJson["status"] == "200") {
      data = ProductDetailsModel.fromJson(responseJson["record"]);
    }
    return data;
  }
}
