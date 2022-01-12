import 'dart:io';

import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart' hide Headers;
import 'package:dio_logging_interceptor/dio_logging_interceptor.dart';
import 'package:sechub/config/constants.dart';

part 'rest_client.g.dart';

@singleton
@RestApi()
abstract class RestClient {
  factory RestClient(Dio dio, {String baseUrl}) = _RestClient;

  @factoryMethod
  static RestClient create() {
    final Dio dio = Dio(BaseOptions(
        baseUrl: Constants.baseUrl,
        connectTimeout: 30000, //30s
        receiveTimeout: 30000,
        sendTimeout: 30000));
    dio.interceptors
        .add(DioLoggingInterceptor(level: Level.body, compact: false));
    return RestClient(dio);
  }

  @POST("/upload")
  @Headers(<String, dynamic>{
    "Content-Type": "multipart/form-data",
  })
  Future<void> sendVideo(@Part() File file);
}
