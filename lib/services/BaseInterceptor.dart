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
        "X-OPENHAB-TOKEN": "eyJraWQiOm51bGwsImFsZyI6IlJTMjU2In0.eyJpc3MiOiJvcGVuaGFiIiwiYXVkIjoib3BlbmhhYiIsImV4cCI6MTY1MDE0MTcyMCwianRpIjoianF6ZjI2RmxndEVHeDVMYXdkM0tXUSIsImlhdCI6MTY1MDEzODEyMCwibmJmIjoxNjUwMTM4MDAwLCJzdWIiOiJhZG1pbiIsImNsaWVudF9pZCI6Imh0dHBzOi8vaG9tZS5teW9wZW5oYWIub3JnIiwic2NvcGUiOiJhZG1pbiIsInJvbGUiOlsiYWRtaW5pc3RyYXRvciJdfQ.VF62JhW7kj3w83ZjO36w7oJsINhOKomcQTRUBd54ZixrJjFhGAzNa7zxlKHci05MdrwXIYy8DJiauSH7rJXPeum0XW8NfQWuS6aAgGmKjuT1OIAd4sHJMKTG-L1ToyT11MLBc4sX9YKhyohieOG25Bovw55RHSnKN9RN8leJR7KVrpWQKrc0Ve7bfH0VNBIKMVHyKFqKz3YxRO3DeZw1eaftNvzwHDOBXLKXdzTwiiSZngMbraSF5IWuBv06RYENLIjn22lOfYPd89bExAu2NiYKkGcGeq7Jo2yk2xp_1LqHZDg4JB1j6rqTzTo5nXu9IN-RByAbDkluNgLqz0XdDw",
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
  
}