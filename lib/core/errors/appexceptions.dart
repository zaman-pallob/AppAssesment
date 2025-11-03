import 'package:dio/dio.dart';

class AppExceptions {
  static getExceptions(Response res) {
    switch (res.statusCode) {
      case 400:
        return Exception(
          'Invalid syntax in the request, please check and try again,status code 400',
        );
      case 401:
        return Exception('Unauthorized need to login again ,status code 401');
      case 403:
        return Exception(
          'You do not have permission to access this resource,status code 403',
        );
      case 404:
        return Exception(
          'The requested resource was not found on the server,status code 404',
        );
      case 500:
        return Exception(
          'Internal Server Error occurred on the server,status code 500',
        );
      default:
        return Exception('Unknown Error: ${res.statusCode}');
    }
  }
}
