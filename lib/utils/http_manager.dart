import 'dart:collection';
import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_demo/utils/app_singleton.dart';
/// 网络请求异常信息类型
enum HttpManagerErrorType {
  /// token失效
  tokenExpired,
  /// 服务异常
  internalServerError,
  /// 需要登陆
  needLogin,
  /// 请求参数异常
   paramsError
}

class HttpManager {
  // static String baseUrl = "http://192.168.1.18:9000/";
  static String baseUrl = "http://192.168.1.13:9001/api/v1/";
  // static String baseUrl = "http://3.85.245.163:9001/api/v1/";
  static final Dio _dio = Dio();

  static const int timeout = 1500;

  static List<CancelToken> _tokens = [];

  static get(
      {required String url,
      Map<String, dynamic>? headers,
      Map<String, String>? params}) async {
    Options options = Options(headers: headers, sendTimeout: timeout);
    options.contentType = ContentType.json.toString();
    _dio.interceptors.add(HttpInterceptor());
    Response response = await _dio.get(baseUrl + url,
        queryParameters: params, options: options);
    try {
      // log("$response");
      if (response.statusCode == 200) {
        if (response.data['code'] == 200) {
          return response.data;
        } else if(response.data['code'] == 500){
          return HttpManagerErrorType.tokenExpired;
        }
      }
    } catch (error) {
      log("request error :${error.toString()}", stackTrace: StackTrace.current);
    }
  }

  static post(
      {required String url,
      Map<String, dynamic>? headers,
      required Map<String, dynamic> params}) async {
    Options options = Options(headers: headers, sendTimeout: timeout);
    log("post request params $params");
    CancelToken token = CancelToken();
    _tokens.add(token);
    Response response =
        await _dio.post(baseUrl + url, data: params, options: options,cancelToken: token);

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

  static upload(
      {required String url,
        Map<String, dynamic>? headers,
        required FormData params}) async {
    Options options = Options(headers: headers, sendTimeout: timeout);
    log("post request params ${params.fields}");
    Map<String,dynamic> map = HashMap();
    map.putIfAbsent("file", () => params);
    Response response =
    await _dio.post(url, data:params, options: options);

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

  static cancelRequest(){
    _tokens.forEach((element) {
      log('取消网络请求 ----->>>>>> $element');
    });
  }

}

class HttpInterceptor extends Interceptor {
  @override
  void onError(DioError err, ErrorInterceptorHandler handler) async {
    log("http interceptor request error response : ${err.response}");
    log("http interceptor request error info : ${err.toString()}");
    handler.next(err);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    // log("http interceptor request  response : ${response.toString()}");

    super.onResponse(response, handler);
  }

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    String token = AppSingleton.userInfoModel?.token??"";
    options.headers.putIfAbsent("token", () => token);
    if(kIsWeb) {
      options.headers.putIfAbsent("Access-Control-Allow-Origin", () => "*");
      options.headers.putIfAbsent("Access-Control-Allow-Credentials", () => true);
    }
    // log("http interceptor request  options headers: ${options.headers}");
    // log("http interceptor request  options queryParameters: ${options.queryParameters}");
    // log("http interceptor request  options path: ${options.path}");
    handler.next(options);
  }
}
