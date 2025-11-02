import 'package:dio/dio.dart';

class Exceptions {
  static getExceptions(Response res) {
    switch (res.statusCode) {
      case 400:
        return Exception('Bad Request');
      case 401:
        return Exception('Unauthorized');
      case 403:
        return DioException(
          requestOptions: res.requestOptions,
          response: Response(
            requestOptions: res.requestOptions,
            statusCode: res.statusCode,
          ),
        );
      case 404:
        return Exception('Not Found');
      case 500:
        return Exception('Internal Server Error');
      default:
        return Exception('Unknown Error: ${res.statusCode}');
    }
  }
}
