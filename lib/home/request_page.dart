import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo/entity/active.dart';
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
    request.add(utf8.encode(json.encode({"username":"zhangsan","password":"123456"})));

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
    var userAgentClient = UserAgentClient("",client);
    http.Response response = await userAgentClient.post(uri,
        body: utf8.encode(json.encode({"username":"zhangsan","password":"123456"})));
    print("response:${response.headers}");
    print("request success : ${response.body}");
    var decodedResponse = jsonDecode(utf8.decode(response.bodyBytes));

    setState(() {
      _result = decodedResponse;
    });
  }

  /// dio get 请求
  void dioGetRequest() async{
    var dio = Dio();
    var url = "http://$API_HOST:$API_PORT/user/test1";
    final response = await dio.get(url);
    setState(() {
      _result = response;
    });
  }

  /// dio post 请求
  void dioPostRequest() async{
    var dio = Dio();
    var url = "http://$API_HOST:$API_PORT/user/register";

    final response = await dio.post(url,data: {"username":"wangwu:${DateTime.now()}","password":"123456","email":"123@gmail.com"});
    setState(() {
      _result = response;
    });
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
