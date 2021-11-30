import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo/login&register/login.dart';
import 'package:flutter_demo/utils/app_singleton.dart';
import 'package:flutter_demo/utils/http_manager.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

/// 基类的page
class BasePage {
  final RefreshController netErrorRefreshController = RefreshController();

  /// 是否显示异常网页页面
  bool show = false;

  /// 异常网络页面显示的内容
  String? errorTitle = "网络异常。。。。。。";

  Widget setNetError(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints.expand(),
      child: SmartRefresher(
        controller: netErrorRefreshController,
        onRefresh: () {
          getData().then((value) {
            if (value) {
              netErrorRefreshController.refreshCompleted();
            } else {
              log("error title ----- >$errorTitle");
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
      HttpManagerErrorType type = value as HttpManagerErrorType;

      switch (type) {
        case HttpManagerErrorType.tokenExpired:
          {
            log("token 过期");
            break;
          }
        case HttpManagerErrorType.needLogin:
          {
            log("需要登陆");
            break;
          }
        default:
          log("12312313");
          break;
      }
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

  Future getData() async {
    return true;
  }

  /// 已经登录，！= null
  bool checkLogin(){
    return AppSingleton.userInfoModel?.token != null;
  }
}
