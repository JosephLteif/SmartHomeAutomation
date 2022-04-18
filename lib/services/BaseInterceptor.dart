import 'dart:convert';

import 'package:dio/dio.dart';

class BaseInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    String username = "pass";
    String password = "pass";
    var auth = 'Basic '+base64Encode(utf8.encode('$username:$password'));
    options.headers.addAll(
      {
        "X-OPENHAB-TOKEN": "pass",
        'authorization': auth
      }
    );
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