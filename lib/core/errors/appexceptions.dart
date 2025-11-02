import 'package:dio/dio.dart';

class AppExceptions {
  static getExceptions(Response res) {
    switch (res.statusCode) {
      case 400:
        return ('Bad Request');
      case 401:
        return Exception('Unauthorized');
      case 403:
        return Exception('Forbidden Access , Returned Status Code: 403');
      case 404:
        return Exception('Not Found');
      case 500:
        return Exception('Internal Server Error');
      default:
        return Exception('Unknown Error: ${res.statusCode}');
    }
  }
}
