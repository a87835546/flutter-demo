import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo/entity/active.dart';
import 'package:flutter_demo/utils/http_manager.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

const API_HOST = '192.168.1.15';
const API_PORT = 9000;

class RequestUse extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return RequestUsePage();
  }
}

class RequestUsePage extends State<RequestUse> {
  dynamic _result;
  late int _count = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("flutter 中的常见网络请求方式 "),
      ),
      body: Center(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: ElevatedButton(
                onPressed: () {
                  httpClientRequest();
                },
                child: const Text("dart 原生网络请求 httpClient"),
              ),
            ),
            SliverToBoxAdapter(
              child: ElevatedButton(
                onPressed: () {
                  httpClientPostRequest();
                },
                child: const Text("dart 原生网络post请求 httpClient"),
              ),
            ),
            SliverToBoxAdapter(
              child: ElevatedButton(
                onPressed: () {
                  httpRequest();
                },
                child: const Text("http 库的网络请求"),
              ),
            ),
            SliverToBoxAdapter(
              child: ElevatedButton(
                onPressed: () {
                  httpPostRequest();
                },
                child: const Text("http 库的post网络请求"),
              ),
            ),
            SliverToBoxAdapter(
              child: ElevatedButton(
                onPressed: () {
                  dioGetRequest();
                },
                child: const Text("dio 库的get网络请求"),
              ),
            ),
            SliverToBoxAdapter(
              child: ElevatedButton(
                onPressed: () {
                  dioPostRequest();
                },
                child: const Text("dio 库的post网络请求"),
              ),
            ),
            SliverToBoxAdapter(
              child: ElevatedButton(
                onPressed: () {
                  httpManagerGetRequest();
                },
                child: const Text("封装的dio get网络请求"),
              ),
            ),
            SliverToBoxAdapter(
              child: ElevatedButton(
                onPressed: () {
                  multiRequest();
                },
                child: const Text("多个线程先执行，后再去刷新UI"),
              ),
            ),
            SliverToBoxAdapter(
              child: Text("${_result}"),
            )
          ],
        ),
      ),
    );
  }

  /// dart 原生 httpClient 网络请求
  void httpClientRequest() async {
    HttpClient httpClient = HttpClient();
    Uri uri = Uri(
        scheme: "http",
        host: API_HOST,
        queryParameters: {"username": "zhangsan", "password": "123456"},
        port: API_PORT,
        path: "user/test3");
    HttpClientRequest request = await httpClient.getUrl(uri);

    request.headers.add("test", "123");
    HttpClientResponse response = await request.close();

    if (response.statusCode == HttpStatus.ok) {
      var content = await response.transform(Utf8Decoder()).join();
      setState(() {
        _result = content;
      });
      print("request success : $content");
    }
  }

  void httpClientPostRequest() async {
    HttpClient httpClient = HttpClient();
    Uri uri = Uri(
        scheme: "http",
        host: API_HOST,
        queryParameters: {"username": "zhangsan", "password": "123456"},
        port: API_PORT,
        path: "user/test4");
    HttpClientRequest request = await httpClient.postUrl(uri);

    request.headers.set("ContentType", "application/json");
    request.headers.set("content-type", "application/json");
    print(request.headers);
    request.add(utf8
        .encode(json.encode({"username": "zhangsan", "password": "123456"})));

    HttpClientResponse response = await request.close();

    if (response.statusCode == HttpStatus.ok) {
      var content = await response.transform(Utf8Decoder()).join();
      setState(() {
        _result = content;
      });
      print("request success : $content");
    }
  }

  /// http 库的网络请求
  void httpRequest() async {
    Uri uri = Uri(
        scheme: "http",
        host: API_HOST,
        queryParameters: {"username": "zhangsan", "password": "123456"},
        port: API_PORT,
        path: "user/test1");
    Client client = http.Client();
    http.Response response = await client.get(uri);
    // response.body
    print("request success : ${response.body}");
    setState(() {
      _result = response.body;
    });
  }

  /// http 库的 post网络请求
  void httpPostRequest() async {
    Uri uri = Uri(
        scheme: "http",
        host: API_HOST,
        // queryParameters: {"username": "zhangsan", "password": "123456"},
        port: API_PORT,
        path: "user/test4");
    Client client = http.Client();
    var userAgentClient = UserAgentClient("", client);
    http.Response response = await userAgentClient.post(uri,
        body: utf8.encode(
            json.encode({"username": "zhangsan", "password": "123456"})));
    print("response:${response.headers}");
    print("request success : ${response.body}");
    var decodedResponse = jsonDecode(utf8.decode(response.bodyBytes));

    setState(() {
      _result = decodedResponse;
    });
  }

  /// dio get 请求
  void dioGetRequest() async {
    var dio = Dio();
    var url = "http://$API_HOST:$API_PORT/user/test1";
    final response = await dio.get(url);
    setState(() {
      _result = response;
    });
  }

  /// dio post 请求
  void dioPostRequest() async {
    var dio = Dio();
    var url = "http://$API_HOST:$API_PORT/user/register";

    final response = await dio.post(url, data: {
      "username": "wangwu:${DateTime.now()}",
      "password": "123456",
      "email": "123@gmail.com"
    });
    setState(() {
      _result = response;
    });
  }

  /// 封装的dio get网络请求
  Future<bool> httpManagerGetRequest() async {
    HttpManager.get(url: "/user/test1").then((value) async {
      log("request success : $value");
      setState(() {
        _result = value;
      });
    }).catchError((err) {
      log("request error : ${err.toString()}");
    }).whenComplete(() {
      log("when complete1  count :$_count");
      return Future.value(true);
    });
    log("11111111111");
    return Future.value(true);
  }

  Future<bool> httpManagerGetRequest1() async {
    HttpManager.get(url: "/user/test1").then((value) async {
      log("request success : $value");
      setState(() {
        _result = value;
      });
    }).catchError((err) {
      log("request error : ${err.toString()}");
    }).whenComplete(() {
      setState(() {
        _count = _count + 1;
      });
      log("when complete1  count :$_count");
      if (_count == 3) {
        afterRequest();
      }
      return Future.value(true);
    });
    log("11111111111");
    return Future.value(true);
  }

  /// 等待多线程ABC三个线程执行完，后执行其他的线程
  void multiRequest() {
    // Future.wait([Future.doWhile(() => httpManagerGetRequest()),]);
    setState(() {
      _count = 0;
    });
    Future future = Future(() {
      httpManagerGetRequest1();
    });
    Future future1 = Future(() {
      httpManagerGetRequest2();
    });
    Future future2 = Future(() {
      httpManagerGetRequest3();
    });
    Future.wait([future, future1, future2])
        .then((value) => log("future wait result : $value"))
        .catchError((error) {
      log("future wait error :${error.toString()}");
    }).whenComplete(() => log("future wait completed"));
    // httpManagerGetRequest();
    // httpManagerGetRequest2();
    // httpManagerGetRequest3();
  }

  void httpManagerGetRequest2() async {
    HttpManager.get(url: "/user/test1").then((value) {
      log("request success : $value");
      setState(() {
        _result = value;
      });
    }).catchError((err) {
      log("request error : ${err.toString()}");
    }).whenComplete(() {
      setState(() {
        _count = _count + 1;
      });
      if (_count == 3) {
        afterRequest();
      }
      log("when complete2  count :$_count");
    });
  }

  void httpManagerGetRequest3() async {
    HttpManager.get(url: "/user/test1").then((value) {
      log("request success : $value");
      setState(() {
        _result = value;
      });
    }).catchError((err) {
      log("request error : ${err.toString()}");
    }).whenComplete(() {
      setState(() {
        _count = _count + 1;
      });
      log("when complete3  count :$_count");
      if (_count == 3) {
        afterRequest();
      }
    });
  }

  void afterRequest() {
    _count = 0;
    log("当之前的三个网络请求执行完之后执行的此方法");
  }
}

class UserAgentClient extends http.BaseClient {
  final String userAgent;
  final http.Client _inner;

  UserAgentClient(this.userAgent, this._inner);

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) {
    request.headers['content-type'] = "application/json";
    return _inner.send(request);
  }
}
