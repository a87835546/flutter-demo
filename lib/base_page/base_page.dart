import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo/login&register/login.dart';
import 'package:flutter_demo/utils/http_manager.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class BasePage {
  final RefreshController _refreshController = RefreshController();
  /// 是否显示异常网页页面
  bool show  = false;
  /// 异常网络页面显示的内容
  String? errorTitle = "网络异常。。。。。。";
  Widget setNetError(BuildContext context) {
   return ConstrainedBox(

     constraints: const BoxConstraints.expand(),
     child: SmartRefresher(
       controller:  _refreshController,
       onRefresh: (){
        getData().then((value){
          if(value){
            _refreshController.refreshCompleted();
          }else{
            log("$errorTitle");
          }
        });
       },
       child: Center(
         child: Text("$errorTitle"),
       ),
     ),
   );
  }

  void setInterError(BuildContext context) {}

  /// 判断请求是否异常。。。
  bool determineRequest(dynamic value) {
    if (value.runtimeType == HttpManagerErrorType) {
      log("网络异常");
      return true;
    }
    return false;
  }

  void goToLogin(BuildContext context) async {
    final result =
        await Navigator.push(context, MaterialPageRoute(builder: (context) {
      return const LoginPage();
    }));
  }

  Future getData() async{
    return true;
  }
}
