import 'dart:convert';
import 'dart:developer';
import 'dart:ui';

import 'package:flutter_demo/mine/model/user_info_model.dart';
import 'package:flutter_demo/utils/cache.dart';
import 'package:flutter_demo/utils/share_preference_util.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppSingleton {
  // static _instance，_instance会在编译期被初始化，保证了只被创建一次
  static AppSingleton get instance => AppSingleton.getInstance();
  static final AppSingleton _instance = AppSingleton.getInstance();
  static UserInfoModel? userInfoModel;
  static SharedPreferences? _preference;

  //提供了一个工厂方法来获取该类的实例
  factory AppSingleton() => getInstance();

  static AppSingleton getInstance() {
    log("app get instance");
    init();
    return _instance;
  }

  // 通过私有方法_internal()隐藏了构造方法，防止被误创建
  AppSingleton._internal() {
    // 初始化

  }
  static void init() async {
    log("这里初始化");
    _preference ??= await SharedPreferences.getInstance();

  }

  static Brightness? brightness;

  static void test(){
    // SharedPreferenceUtil.getInstance().saveString("userinfo", "test");
    // Cache.getInstance().setString("userinfo", "test");
  }

  static Future test1() async{
    dynamic s = await Cache.getInstance().get("userinfo");
    log("reading ---->>>>>> $s");
    return Future.value(s);
  }
  static Future<UserInfoModel?> getUserInfoModel() async{
    if (userInfoModel == null) {
      UserInfoModel? model;
      try {
        String s = await Cache.getInstance().get("userinfo") as String;
        Map<String,dynamic> map = json.decode(s);
        log("string result $s");
        model = UserInfoModel.jsonToObject(map);
      } catch (err) {
        log("get user info model cache parse error ${err}");
      }

      userInfoModel = model;
      log("get user info result $model");
      return model;
    } else {
      return userInfoModel!;
    }
  }


  static void setUserInfoModel(UserInfoModel model) {
    userInfoModel = model;
    try {
      String userinfo = json.encode(model.toJson());
      log("user info string value : $userinfo");
      Cache.getInstance().setString("userinfo", userinfo);
    } catch (err) {
      log("set user info model error ${err}");
    }
  }

  static void clearUserInfo() {
    userInfoModel = null;
    try {
      Cache.getInstance().remove("userinfo");
    } catch (err) {
      log("clear user info model error ${err}");
    }
  }
}
