import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smarthomeautomation/utils/labels.dart';

class BaseInterceptor extends Interceptor {
  @override
  Future<void> onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String username = await prefs.getString(prefs_email).toString();
    String password = await prefs.getString(prefs_password).toString();
    var auth = 'Basic ' + base64Encode(utf8.encode('$username:$password'));
    options.headers.addAll({
      "X-OPENHAB-TOKEN": prefs.getString(prefs_X_OPENHAB_TOKEN).toString(),
      'authorization': auth
    });
    return super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    print(
      'RESPONSE[${response.statusCode}] => PATH: ${response.requestOptions.path}',
    );
    return super.onResponse(response, handler);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    // TODO: implement onError
    print(
      'RESPONSE[${err.response}] => PATH: ${err.requestOptions.path}',
    );
    super.onError(err, handler);
  }
}
