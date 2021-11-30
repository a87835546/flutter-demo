import 'dart:collection';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_demo/mine/model/user_info_model.dart';
import 'package:flutter_demo/utils/app_singleton.dart';
import 'package:flutter_demo/utils/http_manager.dart';

class LoginRequest {
  static Future loginByUsername(String username, String pwd) async {
    Map<String, String> map = HashMap();
    map["username"] = username;
    map["password"] = pwd;
    dynamic model;
    await HttpManager.post(url: "/user/login", params: map).then((value){
      if(value['code'] == 200) {

        model = UserInfoModel.jsonToObject(value['data']);
        // AppSingleton.setUserInfoModel(value as UserInfoModel);
        log("login by user name result:$value    model : $model");
      }else{
        log("login error $value");
        model = value;
      }
     });
    return Future.value(model);
  }
  static Future loginByPhone(String phone, String code) async {
    Map<String, String> map = HashMap();
    map["mobile"] = phone;
    map["code"] = code;
    dynamic model;
    await HttpManager.post(url: "/user/loginByPhone", params: map).then((value){
      if(value['code'] == 200) {

        model = UserInfoModel.jsonToObject(value['data']);
        log("login by user name result:$value    model : $model");
      }else{
        log("login error $value");
        model = value;
      }
    });
    return Future.value(model);
  }
  static Future registerByUsername(String username, String pwd) async {
    Map<String, String> map = HashMap();
    map["username"] = username;
    map["password"] = pwd;
    map['email'] = "123@qq.com";
    dynamic model;
    await HttpManager.post(url: "/user/register", params: map).then((value){
      log("register by user name request result --- >>> $value");
      if(value['code'] == 200) {

        model = UserInfoModel.jsonToObject(value['data']);
        // AppSingleton.setUserInfoModel(value as UserInfoModel);
        log("login by user name result:$value    model : $model");
      }else{
        log("login error $value");
        model = value;
      }
    });
    return Future.value(model);
  }
}
