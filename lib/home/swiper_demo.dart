import 'dart:convert';

import 'package:card_swiper/card_swiper.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo/entity/active.dart';
import 'package:flutter_demo/entity/base_model.dart';
import 'package:flutter_demo/utils/screen_utils.dart';
import 'package:json_annotation/json_annotation.dart';

const double kAppBarHeight = 49;

class SwiperDemo extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => SwiperDemoState();
}

class SwiperDemoState extends State<SwiperDemo> {
  double appBarAlpha = 0;
  List<Active> _list = [];

  @override
  void initState() {
    _getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(
        "${ScreenUtils.kStatusBarHeight}  --- >>>> ${MediaQuery.of(context).padding}");

    return Scaffold(
        body: Stack(
      children: [
        MediaQuery.removePadding(
            removeTop: true,
            context: context,
            child: NotificationListener(
              onNotification: (Notification scrollNotification) {
                if (scrollNotification is ScrollUpdateNotification &&
                    scrollNotification.depth == 0) {
                  _didScroll(scrollNotification.metrics.pixels);
                  print(
                      "scroll offset ---->>> ${scrollNotification.metrics.pixels}");
                  return true;
                }
                return false;
              },
              child: ListView(
                children: [
                  Container(
                    color: Colors.redAccent,
                    height: 160,
                    child: FutureBuilder<List<Active>>(
                      future: _getData(),
                      builder: (BuildContext context,
                          AsyncSnapshot<List<Active>> snapshot) {
                        if (snapshot.hasData) {
                          var list = snapshot.data as List<Active>;
                          return Swiper(
                              itemHeight: 160,
                              itemCount: list.length,
                              autoplay: true,
                              itemBuilder: (context, index) {
                                return FadeInImage.assetNetwork(
                                  placeholder: "imgs/images/banner@3x.png",
                                  image: list[index].url,
                                  fit: BoxFit.fill,
                                );
                              },
                              pagination: const SwiperPagination(),
                              onTap: (int index) async {
                                print("swiper index ---- >>>> ${list[index]}");
                              });
                        } else {
                          return Text(
                              "net work request error ${snapshot.error}");
                        }
                      },
                    ),
                  ),
                  Container(
                    height: 1000,
                    child: Text("12312312312312312"),
                  ),
                ],
              ),
            )),
        Padding(
          padding: EdgeInsets.only(top: 20),
          child: Opacity(
            opacity: appBarAlpha,
            child: Container(
              height: kAppBarHeight + MediaQuery.of(context).padding.top,
              color: Colors.lightBlue,
              alignment: Alignment.center,
              child: Padding(
                padding:
                    EdgeInsets.only(top: MediaQuery.of(context).padding.top),
                child: Text(
                  "自定义导航栏",
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ),
          ),
        )
      ],
    ));
  }

  void _didScroll(double pixels) {
    double alpha =
        pixels / (kAppBarHeight + MediaQuery.of(context).padding.top);
    if (alpha < 0) {
      alpha = 0;
    } else if (alpha > 1) {
      alpha = 1;
    }
    setState(() {
      appBarAlpha = alpha;
    });
  }

  Future<List<Active>> _getData() async {
    var dio = Dio();
    // final response = await dio.get("http://192.168.1.15:9000/active/queryAll");
    final response = await dio.get("http://192.168.1.15:9000/active/banner");
    print(response.data);
    List list = [];
    try {
      list = response.data['data'];
    } catch (e) {
      print('error msg ----- >>>> $e');
    }
    List<Active> result = [];
    list.forEach((element) {
      print("element ---->>>>>> $element \n type: ${element.runtimeType}");
      result.add(Active.fromJson(element));
    });
    print("result ----- >>>>>> $result");
    // setState(() {
    //   _list = result;
    // });
    return result;
  }
}
