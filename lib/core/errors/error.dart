import 'package:dio/dio.dart';

abstract class Failures {
  Failures(this.errMsg);
  final String errMsg;
}

class ServerFailure extends Failures {
  ServerFailure(super.errMsg);

  factory ServerFailure.fromDioException(DioException err) {
    if (err.response != null) {
      return ServerFailure.fromResponse(
        err.response!.statusCode ?? 500, // Default to 500 if null
        err.response!.data,
      );
    }

    switch (err.type) {
      case DioExceptionType.badCertificate:
        return ServerFailure('Bad Certificate');
      case DioExceptionType.badResponse:
        return ServerFailure('Bad Response from Server');
      case DioExceptionType.cancel:
        return ServerFailure('Request Canceled');
      case DioExceptionType.connectionError:
        return ServerFailure('Connection Error');
      case DioExceptionType.connectionTimeout:
        return ServerFailure('Connection Timeout');
      case DioExceptionType.sendTimeout:
        return ServerFailure('Send Timeout');
      case DioExceptionType.receiveTimeout:
        return ServerFailure('Receive Timeout');
      case DioExceptionType.unknown:
        return ServerFailure('Unknown Error: ${err.message}');
    }
  }

  factory ServerFailure.fromResponse(int statusCode, dynamic response) {
    try {
      if (statusCode == 400 || statusCode == 401 || statusCode == 403) {
        final errorMessage =
            response?['error']?['message'] ?? 'Authentication Error';
        return ServerFailure(errorMessage);
      } else if (statusCode == 404) {
        return ServerFailure('Your request was not found');
      } else {
        return ServerFailure('Oops! There was an error. Please try again.');
      }
    } catch (e) {
      return ServerFailure('Error parsing server response');
    }
  }
}
