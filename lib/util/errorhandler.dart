import 'package:dio/dio.dart';

/// \brief Helper classes and functions for handling errors when interacting with backend.
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
// error handler
class ErrorHandler {
  /// Accepts [response] from backend and optional [customErrorResolver]
  /// to resolve error.
  static Exception resolveNetworkError<T>(
      {required Response<T> response, ErrorResolver? customErrorResolver}) {
    final ErrorResolver errorResolver =
        customErrorResolver ?? DefaultErrorResolver();
    return errorResolver.resolve(response);
  }

  /// Accepts [error] and returns message.
  static String resolveExceptionMessage(Exception error) {
    if (error is BadRequestError) {
      return "Bad video request error";
    } else {
      return "Unknown error";
    }
  }
}

// error resolvers
abstract class ErrorResolver {
  /// Accepts [response] and returns error based on received http code.
  Exception resolve<T>(Response<T> response);
}

class DefaultErrorResolver implements ErrorResolver {
  @override
  Exception resolve<T>(Response<T> response) {
    final int? statusCode = response.statusCode;
    final String statusMessage = response.statusMessage ?? "";
    if (statusCode != null) {
      if (statusCode == 400) {
        return BadRequestError(statusMessage);
      }
    }
    return Exception(response.statusMessage);
  }
}

// errors
class BadRequestError implements Exception {
  final String message;

  const BadRequestError([this.message = ""]);

  @override
  String toString() => "BadRequestError: $message";
}

// dio errors
class CancelError implements Exception {
  final String message;

  const CancelError([this.message = ""]);

  @override
  String toString() => "CancelError: $message";
}

class ConnectTimeoutError implements Exception {
  final String message;

  const ConnectTimeoutError([this.message = ""]);

  @override
  String toString() => "ConnectTimeoutError: $message";
}

class SendTimeoutError implements Exception {
  final String message;

  const SendTimeoutError([this.message = ""]);

  @override
  String toString() => "SendTimeoutError: $message";
}

class ReceiveTimeoutError implements Exception {
  final String message;

  const ReceiveTimeoutError([this.message = ""]);

  @override
  String toString() => "ReceiveTimeoutError: $message";
}
