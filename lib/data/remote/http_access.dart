import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:ecitykiosk/app.dart';
import 'package:ecitykiosk/data/local/shared_pref_helper.dart';
import 'package:ecitykiosk/data/remote/end_points.dart';
import 'package:http/http.dart' as http;

class Networking {
  Networking._privateConstructor();

  static final Networking instance = Networking._privateConstructor();

  Future<String> post(String url, String body) async {
    Map<String, String> header = {
      'authtoken': url == EndPoints.kLoginUrl
          ? 'development'
          : SharedPrefHelper.authToken,
      'Accept-Language': navigatorKey.currentContext!.locale.languageCode,
      'Content-Type': 'application/json'
    };
    final http.Response res = await http.post(
      Uri.parse(url),
      body: body,
      headers: header,
    );
    log(header.toString());
    log(url.toString());
    log(body.toString());
    log(res.body.toString());
    return res.body;
  }

  Future<String> get(String url) async {
    Map<String, String> header = url != EndPoints.kGetCartUrl ||
            url != EndPoints.kRemoveFromCartUrl
        ? {
            'authtoken': SharedPrefHelper.authToken,
            'Accept-Language': navigatorKey.currentContext!.locale.languageCode
          }
        : {
            'authtoken': SharedPrefHelper.authToken,
            'Content-Type': 'application/json',
            'Accept-Language': navigatorKey.currentContext!.locale.languageCode
          };
    http.Response res = await http.get(Uri.parse(url), headers: header);
    log(header.toString());
    log(url);
    log(res.body);
    return res.body;
  }
}
