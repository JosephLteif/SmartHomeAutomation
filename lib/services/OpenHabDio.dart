import 'package:dio/dio.dart';
import 'package:smarthomeautomation/utils/endpoint.dart';

import 'BaseInterceptor.dart';
import 'LoggingInterceptor.dart';

class OpenHabDio {
  static final OpenHabDio _instance = OpenHabDio._internal();

  var _dio;

    Dio get dio => _dio;

  factory OpenHabDio() {
    return _instance;
  }

  OpenHabDio._internal() {
    // initialization logic 
    _dio = Dio(
          BaseOptions(
      baseUrl: host,
      connectTimeout: 5000,
      receiveTimeout: 3000,
    ),
    )..interceptors.addAll([LoggingInterceptor(), BaseInterceptor()]);
  }

  // static OpenHabDio _singleton;
  

  // factory OpenHabDio() => _singleton??OpenHabDio._internal();

  // Dio CustomDio(){
  //   return Dio(
  //         BaseOptions(
  //     baseUrl: host,
  //     connectTimeout: 5000,
  //     receiveTimeout: 3000,
  //   ),
  //   )..interceptors.add(Logging());
  // }

  // OpenHabDio._internal(){
  //   _dio = CustomDio();
  // }
}