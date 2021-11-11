
import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RequestUse extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return RequestUsePage();
  }
}

class RequestUsePage extends State<RequestUse> {
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
              child: ElevatedButton(onPressed: (){
                httpClientRequest();
              },child: const Text("dart 原生网络请求 httpClient"),),
            )
          ],
        ),
      ),
    );
  }
}

void httpClientRequest() async{
  HttpClient httpClient = HttpClient();
  Uri uri = Uri(scheme: "http",host: "localhost",queryParameters: {
    "username":"zhangsan",
    "password":"123456"
  },port: 9000,path: "user/test3");
  HttpClientRequest request = await httpClient.getUrl(uri);

  HttpClientResponse response = await request.close();

  if(response.statusCode == HttpStatus.ok) {

    var content = await response.transform(Utf8Decoder()).join();
    print("request success : $content");
  }
}