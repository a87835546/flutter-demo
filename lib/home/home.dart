import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_demo/home/animation_use.dart';
import 'package:flutter_demo/home/app_lifecycle.dart';
import 'package:flutter_demo/home/card_use.dart';
import 'package:flutter_demo/home/catalogue_list.dart';
import 'package:flutter_demo/home/corner_radius_button.dart';
import 'package:flutter_demo/home/device_info_page.dart';
import 'package:flutter_demo/home/navigator_use.dart';
import 'package:flutter_demo/home/page_transition.dart';
import 'package:flutter_demo/home/request_page.dart';
import 'package:flutter_demo/home/router_pass_arguments.dart';
import 'package:flutter_demo/home/share_preference_use.dart';
import 'package:flutter_demo/home/stateful_use.dart';
import 'package:flutter_demo/home/swiper_demo.dart';
import 'package:flutter_demo/home/webview_use.dart';
import 'package:flutter_demo/home/widget_lifecycle.dart';
import 'package:flutter_demo/utils/app_singleton.dart';
import 'package:flutter_demo/utils/screen_utils.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'expansion_use.dart';
import 'list_view_controller.dart';
import 'package:logger/logger.dart';

var logger = Logger(
  printer: PrefixPrinter(
    PrettyPrinter(
      stackTraceBeginIndex: 5,
      methodCount: 1
    ),
  ),
  filter: ProductionFilter(),
);
class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

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
    RouterModel("swiper和自定义导航的使用", "swiper_demo", SwiperDemo()),
    RouterModel("SharePreferences的使用/本地数据存储", "share_preference_use", SharePreferenceUse()),
    RouterModel("ExpansionTitle的使用/可折叠的列表", "expansion_title_use", ExpansionUse()),
    RouterModel("定义button 带圆角", "corner_radius_button", const CornerRadiusButton()),
    RouterModel("webview 的常见使用", "custom_webView", const CustomWebView()),
    RouterModel("卡片式的view 常见使用", "card_use", const CardUse()),

  ];

  @override
  Widget build(BuildContext context) {
    AppSingleton.getUserInfoModel().then((value)  {
      log("get result");
      // Fluttertoast.showToast(msg: value?.token??"");
    });
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
                return const Divider(height: 2,color: Colors.grey,);
              }, itemCount: data.length),
              onRefresh: _refresh),
        ),
      ),
    );
  }

  Future<void> _refresh() async {
    print("下拉刷新开始");
    logger.w("测试logger 的使用");
    logger.i("测试logger 的使用");
    logger.e("测试logger 的使用");
    logger.v("测试logger 的使用");
    logger.d("测试logger 的使用");
    logger.wtf("测试logger 的使用");
    // setState(() {
    //   int length = data.length;
    //   for(int i = 1 ;i <= 10; i++){
    //     data.add(RouterModel("${i + length}", "stateful_use", StatefulUse()));
    //   }
    // });
    Future.delayed(const Duration(milliseconds: 300), () {
      log("下拉刷新------end",name: "log");
    });
  }
}

class RouterModel {
  String navTitle;
  String routerName;
  dynamic name;

  RouterModel(this.navTitle, this.routerName, this.name);
}
