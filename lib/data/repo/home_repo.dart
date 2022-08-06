import 'dart:convert';

import 'package:ecitykiosk/models/banner_model.dart';
import 'package:ecitykiosk/models/store_model.dart';

import '../remote/end_points.dart';
import '../remote/http_access.dart';

class HomeRepo {
  Future<List<StoreData>> getAllStores() async {
    Map body = {"page_no": "", "search": "", "category": "", "merchant_id": ""};
    final response = await Networking.instance
        .post(EndPoints.kAllStoreUrl, jsonEncode(body));
    final responseJson = jsonDecode(response);
    List<StoreData> data = [];
    if (responseJson["status"] == "200") {
      var checkData = responseJson["record"]["data"];
      data = checkData.map<StoreData>((e) => StoreData.fromJson(e)).toList();
    }
    return data;
  }

  Future<List<BannerModel>> getHomeBanners() async {
    final response = await Networking.instance.get(EndPoints.kHomeBannerUrl);
    final responseJson = jsonDecode(response);
    List<BannerModel> data = [];
    if (responseJson["status"] == "200") {
      var checkData = responseJson["record"];
      data =
          checkData.map<BannerModel>((e) => BannerModel.fromJson(e)).toList();
    }
    return data;
  }

  Future<List<StoreData>> getRecentStores() async {
    Map body = {"page_no": "", "search": "", "category": ""};
    final response = await Networking.instance
        .post(EndPoints.kRecentStoreUrl, jsonEncode(body));
    final responseJson = jsonDecode(response);
    List<StoreData> data = [];
    if (responseJson["status"] == "200") {
      var checkData = responseJson["record"]["data"];
      data = checkData.map<StoreData>((e) => StoreData.fromJson(e)).toList();
    }
    return data;
  }

  Future<List<StoreData>> getTrendsStores() async {
    Map body = {"page_no": "", "search": "", "category": ""};
    final response = await Networking.instance
        .post(EndPoints.kTrendsStoreUrl, jsonEncode(body));
    final responseJson = jsonDecode(response);
    List<StoreData> data = [];
    if (responseJson["status"] == "200") {
      var checkData = responseJson["record"]["data"];
      data = checkData.map<StoreData>((e) => StoreData.fromJson(e)).toList();
    }
    return data;
  }

  Future<void> setRecentView(String id) async {
    await Networking.instance.get(EndPoints.kRecentStoreViewedUrl + id);
  }
}
