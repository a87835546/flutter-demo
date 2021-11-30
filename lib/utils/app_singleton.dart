import 'dart:convert';
import 'dart:developer';
import 'dart:ui';

import 'package:flutter_demo/mine/model/user_info_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppSingleton {
  // static _instance，_instance会在编译期被初始化，保证了只被创建一次
  static final AppSingleton _instance = AppSingleton._internal();
  static UserInfoModel? userInfoModel;
  static SharedPreferences? _preference;

  //提供了一个工厂方法来获取该类的实例
  factory AppSingleton() {
    log("app factory");

    init();
    return _instance;
  }

  static AppSingleton getInstance() {
    log("app get instance");
    init();
    return _instance;
  }

  // 通过私有方法_internal()隐藏了构造方法，防止被误创建
  AppSingleton._internal() {
    // 初始化
    init();
  }

  // Singleton._internal(); // 不需要初始化

  static void init() async {
    print("这里初始化");
    if(_preference == null){
      _preference ??= await SharedPreferences.getInstance();
    }
  }

  static Brightness? brightness;

  // static UserInfoModel get userInfoModel {
  //   if (_userInfoModel == null) {
  //     UserInfoModel? model;
  //     if (_preference != null) {
  //       try {
  //         String? userinfo = _preference?.getString("userinfo");
  //         if (userinfo != null) {
  //           model = json.decode(userinfo) as UserInfoModel;
  //         }
  //         log("user info string value : $userinfo");
  //       } catch (err) {
  //         log("set user info model error ${err}");
  //       }
  //     } else {}
  //     return model!;
  //   } else {
  //     return _userInfoModel!;
  //   }
  // }
  //
  // static void setUserInfoModel(UserInfoModel model) {
  //   SharedPreferences sharedPreferences =
  //       SharedPreferences.getInstance() as SharedPreferences;
  //   _userInfoModel = model;
  //   try {
  //     String userinfo = json.encode(model.toJson());
  //     log("user info string value : $userinfo");
  //     sharedPreferences.setString("userInfo", userinfo);
  //   } catch (err) {
  //     log("set user info model error ${err}");
  //   }
  // }
}
