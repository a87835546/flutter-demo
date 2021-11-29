
import 'dart:ui';

import 'package:flutter_demo/mine/model/user_info_model.dart';

class AppSingleton{
  // static _instance，_instance会在编译期被初始化，保证了只被创建一次
  static final AppSingleton _instance = AppSingleton._internal();
  static UserInfoModel? userInfoModel;
  //提供了一个工厂方法来获取该类的实例
  factory AppSingleton(){
    return _instance;
  }

  // 通过私有方法_internal()隐藏了构造方法，防止被误创建
  AppSingleton._internal(){
    // 初始化
    init();
  }
  // Singleton._internal(); // 不需要初始化

  void init(){
    print("这里初始化");
  }


  static Brightness? brightness;
}