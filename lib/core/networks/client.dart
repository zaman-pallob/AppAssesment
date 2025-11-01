import 'package:app_assesment/core/constants/app_constant.dart';
import 'package:app_assesment/core/utils/logger.dart';
import 'package:dio/dio.dart';

class Client {
  static Dio createClient() {
    Dio dio = Dio();
    dio.options.baseUrl = AppConstant.baseUrl;
    dio.options.sendTimeout = Duration(seconds: 120);
    dio.options.receiveTimeout = Duration(seconds: 120);
    dio.options.connectTimeout = Duration(seconds: 120);
    dio.options.headers["accept"] = 'application/json';
    dio.options.headers["Content-Type"] = 'application/json';
    dio.options.contentType = Headers.jsonContentType;
    dio.options.responseType = ResponseType.json;
    dio.options.followRedirects = true;
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          var map = {
            "Category": "New Request",
            "Method": options.method,
            "Url": (options.uri.origin) + (options.uri.path),
            "Headers": options.headers,
            "query params": options.queryParameters,
            "body data": options.data,
          };
          logger.d(map);
          handler.next(options);
        },
        onResponse: (response, handler) {
          logger.i(response);
          handler.next(response);
        },
        onError: (err, handler) async {
          var map = {
            "Category": "Error",
            "Method": err.response?.requestOptions.method,
            "Url":
                (err.response?.requestOptions.uri.origin ?? "") +
                (err.response?.requestOptions.uri.path ?? ""),
            "Headers": err.response?.requestOptions.headers,
            "query params": err.response?.requestOptions.queryParameters,
            "body data": err.response?.requestOptions.data,
            "ErrorStatusCode": err.response?.statusCode,
            "Error": err,
          };

          logger.e(map);
          handler.next(err);
        },
      ),
    );
    return dio;
  }
}
