import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';

class HttpManager {
  static String baseUrl = "http://192.168.1.15:9000";
  static final Dio _dio = Dio();

  static const int timeout = 1500;

  static  get({ required String url, Map<String, dynamic>? headers, Map<String,String>? params}) async {
    Options options = Options(headers: headers,sendTimeout: timeout);
    options.contentType = ContentType.json.toString();
    _dio.interceptors.add(HttpInterceptor());
    Response response = await _dio.get(baseUrl + url,queryParameters: params,options: options);
    try {
      if (response.statusCode == 200) {
        return response.data;
      }
    } catch (error) {
      log("request error :${error.toString()}", stackTrace: StackTrace.current);
    } finally {
      log("finally ");
    }
    // return Future.value(true);
  }

  static Future<bool> post({ required String url, Map<String, dynamic>? headers, Map<String,String>? params}) async {
    Options options = Options(headers: headers,sendTimeout: timeout);
    Response response = await _dio.post(baseUrl + url,data: params,options: options);

    try {
      if (response.statusCode == 200) {
        return response.data;
      }
    } catch (error) {
      log("request error :${error.toString()}", stackTrace: StackTrace.current);
    } finally {
      log("finally ");
    }
    return Future.value(true);
  }
}


class HttpInterceptor extends Interceptor{
  @override
  void onError(DioError err, ErrorInterceptorHandler handler) async {
      log("http interceptor request error response : ${err.response}");
      log("http interceptor request error info : ${err.toString()}");
      handler.next(err);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    log("http interceptor request  response : ${response.toString()}");
    super.onResponse(response, handler);
  }

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    log("http interceptor request  options headers: ${options.headers}");
    log("http interceptor request  options queryParameters: ${options.queryParameters}");
    log("http interceptor request  options path: ${options.path}");
    handler.next(options);
  }
}
