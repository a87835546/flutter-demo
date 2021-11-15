import 'package:flutter/material.dart';
import 'package:flutter_demo/home/animation_use.dart';
import 'package:flutter_demo/home/app_lifecycle.dart';
import 'package:flutter_demo/home/catalogue_list.dart';
import 'package:flutter_demo/home/device_info_page.dart';
import 'package:flutter_demo/home/navigator_use.dart';
import 'package:flutter_demo/home/page_transition.dart';
import 'package:flutter_demo/home/request_page.dart';
import 'package:flutter_demo/home/router_pass_arguments.dart';
import 'package:flutter_demo/home/stateful_use.dart';
import 'package:flutter_demo/home/swiper_demo.dart';
import 'package:flutter_demo/home/widget_lifecycle.dart';
import 'package:flutter_demo/utils/screen_utils.dart';

import 'list_view_controller.dart';

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _home();
  }
}

class _home extends State<Home> {
  int selectedIndex = 0;
  List data = <RouterModel>[
    RouterModel("导航路由的使用", "navigator_use", const NavigatorUse("导航路由的使用")),
    RouterModel("stateful的使用", "stateful_use", StatefulUse()),
    RouterModel("导航传参使用", "", null),
    RouterModel("stateful的使用", "list_view_controller", ListViewController()),
    RouterModel("widget的生命周期的使用", "widget_lifecycle", WidgetLifeCycle()),
    RouterModel("app的生命周期的使用", "app_lifecycle", AppLifeCycle()),
    RouterModel("常用的目录", "catalogue_list", CatalogueList()),
    RouterModel("常用页面转场动画", "page_transition", PageTransition()),
    RouterModel("查看设备信息", "device_info", DeviceInfo()),
    RouterModel("网络请求的使用", "request_use", RequestUse()),
    RouterModel("常用的动画animation的使用", "animation_use", AnimationUse()),
    RouterModel("swiper的使用", "swiper_demo", SwiperDemo()),

  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("flutter 学习资料"),

      ),
      body: Center(
        child: Container(
          child: RefreshIndicator(
              child: ListView.separated(itemBuilder: (BuildContext context,int index){
                return Container(
                  height: 60,
                  child: ListTile(
                    title: Text("row : ${data[index].navTitle}"),
                    subtitle: Text("${data[index].name}"),
                    onTap: () async {
                      RouterModel model = data[index];

                      /// 方法一，使用路由名称去跳转，首先需要在mian里面注册路由
                      /// arguments: model 传递过去的参数
                      // Navigator.pushNamed(context, model.routerName,arguments: model);
                      /// 方法二，不使用路由跳转，
                      final result = await Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                            if (model.name == null) {
                              /// 需要传参
                              return RouterPassArguments(model);
                            } else {
                              return model.name;
                            }
                          }));
                      /// 接收的回调，返回的参数，必须要使用 async await.
                      print("接收到的回传的值：${result}");
                    },
                  ),
                );
              }, separatorBuilder: (BuildContext context,int index){
                return Divider(height: 2,color: Colors.grey,);
              }, itemCount: data.length),
              onRefresh: _refresh),
        ),
      ),
    );
  }

  Future<void> _refresh() async {
    print("下拉刷新开始");
    // setState(() {
    //   int length = data.length;
    //   for(int i = 1 ;i <= 10; i++){
    //     data.add(RouterModel("${i + length}", "stateful_use", StatefulUse()));
    //   }
    // });
    Future.delayed(Duration(milliseconds: 300), () {
      print("下拉刷新------end");
    });
  }
}

class RouterModel {
  String navTitle;
  String routerName;
  dynamic name;

  RouterModel(this.navTitle, this.routerName, this.name);
}
