import 'package:dio/dio.dart';
import 'package:smarthomeautomation/utils/endpoint.dart';

import 'BaseInterceptor.dart';
import 'LoggingInterceptor.dart';

class OpenHabDio {
  final Dio _dio = Dio(
          BaseOptions(
      baseUrl: host,
      connectTimeout: 5000,
      receiveTimeout: 3000,
    ),
    )..interceptors.addAll([LoggingInterceptor(), BaseInterceptor()]);

    Dio get dio => _dio;

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