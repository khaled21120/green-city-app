import 'package:dio/dio.dart';

abstract class Failures {
  Failures(this.errMsg);
  final String errMsg;
}

class ServerFailure extends Failures {
  ServerFailure(super.errMsg);

  factory ServerFailure.fromDioException(DioException error) {
    try {
      // Handle response errors first
      if (error.response != null) {
        return ServerFailure.fromResponse(
          error.response!.statusCode ?? 500,
          error.response?.data ?? 'Internal Server Error',
        );
      }

      switch (error.type) {
        case DioExceptionType.connectionTimeout:
          return ServerFailure(
            'Connection timeout. Please check your internet connection.',
          );
        case DioExceptionType.sendTimeout:
          return ServerFailure('Request timeout. Please try again.');
        case DioExceptionType.receiveTimeout:
          return ServerFailure(
            'Response timeout. Server is taking too long to respond.',
          );
        case DioExceptionType.badCertificate:
          return ServerFailure(
            'Security certificate error. Please contact support.',
          );
        case DioExceptionType.badResponse:
          return ServerFailure('Invalid server response.');
        case DioExceptionType.cancel:
          return ServerFailure('Request was cancelled.');
        case DioExceptionType.connectionError:
          return ServerFailure(
            'Connection error. Please check your internet connection.',
          );
        case DioExceptionType.unknown:
          if (error.message?.contains('SocketException') ?? false) {
            return ServerFailure('No internet connection available.');
          }
          return ServerFailure(
            'An unexpected error occurred: ${error.message}',
          );
      }
    } catch (e) {
      return ServerFailure('An unknown error occurred');
    }
  }

  factory ServerFailure.fromResponse(int statusCode, String data) {
    String message = 'An error occurred';
    try {
      message = data;
      switch (statusCode) {
        case 307:
          message = 'Session expired. Please login again.';
        case 400:
          message =
              message.contains('is already taken')
                  ? 'Username is already taken'
                  : message;
        case 401:
          message = 'Authentication failed. Please login again.';
        case 403:
          message = 'You are not authorized to perform this action.';
        case 404:
          message = 'The requested resource was not found.';
        case 405:
          message = 'Method Not Allowed';
        case 409:
          message = 'Conflict occurred: $message';
        case 500:
          message = 'Internal server error. Please try again later.';
        case 503:
          message = 'Service unavailable. Please try again later.';
        default:
          message = 'Error $statusCode: $message';
      }
    } catch (e) {
      message = 'Failed to parse error response';
    }

    return ServerFailure(message);
  }
}
