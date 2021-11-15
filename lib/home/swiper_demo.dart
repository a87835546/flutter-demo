import 'dart:convert';

import 'package:card_swiper/card_swiper.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo/entity/active.dart';
import 'package:flutter_demo/entity/base_model.dart';
import 'package:json_annotation/json_annotation.dart';

class SwiperDemo extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => SwiperDemoState();
}

class SwiperDemoState extends State<SwiperDemo> {


  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("swiper 使用"),
      ),
      body: Center(
        child: Container(
          color: Colors.redAccent,
          height: 160,
          child: Swiper(
            itemHeight: 160,
            itemCount: 5,
            autoplay: true,
            itemBuilder: (context, index) {
              return Image.asset(
                "imgs/images/banner@3x.png",
                fit: BoxFit.fill,
              );
            },
            pagination: const SwiperPagination(),
            onTap:(int index) async{
              print("swiper index ---- >>>> $index");
              _getData();
            }
          ),
        ),
      ),
    );
  }
}




void _getData() async{

  var dio = Dio();
  final response = await dio.get("http://192.168.1.15:9000/active/queryAll");
  print(response.data);
  // print("data ------- >>>>>> ${response.data["data"]} \n type ----->>>>>> ${response.data["data"].runtimeType}");
  var data = jsonDecode(response.data.toString());
  List<Map<String,dynamic>> list = [];
  try {
    list = data['data'] as List<Map<String,dynamic>>;
  }catch(e) {
    print('error msg ----- >>>> $e');
  }
  List<Active> result = [];
  list.forEach((Map<String,dynamic> element) {
    result.add(Active.fromJson(element));
  });
  print("result ----- ><>>>>> $result");
  // Map<String,dynamic> map = jsonDecode(response.data);
  // print("map ------- >>>>>> $map");
  // Active active = Active.fromJson(response["data"]);
  // print(active);
}