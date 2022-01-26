import 'package:dio/dio.dart';
import 'package:sechub/util/errorhandler.dart';

/// \brief Base service class for interacting with backend.
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
class BaseService {
  /// Starts request to backend with [apiCall]. Returns data [T] when
  /// request is successful, otherwise throws error given by [ErrorHandler].
  Future<T> apiRequest<T>({required apiCall}) async {
    try {
      return await apiCall;
    } catch (error) {
      try {
        if (error is DioError) {
          switch (error.type) {
            case DioErrorType.cancel:
              throw CancelError(error.message);
            case DioErrorType.connectTimeout:
              throw ConnectTimeoutError(error.message);
            case DioErrorType.sendTimeout:
              throw SendTimeoutError(error.message);
            case DioErrorType.receiveTimeout:
              throw ReceiveTimeoutError(error.message);
            case DioErrorType.other:
              throw Exception(error.message);
            case DioErrorType.response:
              throw ErrorHandler.resolveNetworkError(response: error.response!);
            default:
              throw Exception(error.message);
          }
        }
      } catch (e) {
        rethrow;
      }
      throw Exception();
    }
  }
}
