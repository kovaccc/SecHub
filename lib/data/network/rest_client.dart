import 'dart:io';

import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart' hide Headers;
import 'package:dio_logging_interceptor/dio_logging_interceptor.dart';
import 'package:sechub/config/constants.dart';

part 'rest_client.g.dart';

/// \brief Client for communicating with backend.
/// \details
///
/// @author  Matej Kovacevic
/// @version 1.0
/// \date 26/01/2022
/// \copyright
///     This code and information is provided "as is" without warranty of
///     any kind, either expressed or implied, including but not limited to
///     the implied warranties of merchantability and/or fitness for a
///     particular purpose.
///
@singleton
@RestApi()
abstract class RestClient {
  factory RestClient(Dio dio, {String baseUrl}) = _RestClient;

  /// Creates instance of [RestClient] with powerful Http client [Dio].
  @factoryMethod
  static RestClient create() {
    final Dio dio = Dio(BaseOptions(
        baseUrl: Constants.baseUrl,
        connectTimeout: 200000,
        receiveTimeout: 200000,
        sendTimeout: 200000));
    dio.interceptors
        .add(DioLoggingInterceptor(level: Level.body, compact: false));
    return RestClient(dio);
  }

  /// Uploads video file [file].
  @POST("/upload")
  @Headers(<String, dynamic>{
    "Content-Type": "multipart/form-data",
  })
  Future<void> sendVideo(@Part() File file);
}
