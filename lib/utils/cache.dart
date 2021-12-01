import 'dart:developer';

import 'package:shared_preferences/shared_preferences.dart';

///缓存管理类
class HiCache {
  SharedPreferences? prefs;

  HiCache._() {
    log("_ init");
    init();
  }

  static HiCache? _instance;

  HiCache._pre(SharedPreferences prefs) {
    log("_pre ");
    this.prefs = prefs;
  }

  ///预初始化，防止在使用get时，prefs还未完成初始化
  static Future<HiCache> preInit() async {
    log("pre init");
    if (_instance == null) {
      var prefs = await SharedPreferences.getInstance();
      _instance = HiCache._pre(prefs);
    }
    return _instance!;
  }

  static HiCache getInstance() {
    log("get instance");
    _instance ??= HiCache._();
    return _instance!;
  }

  void init() async {
    log("init");
    prefs ??= await SharedPreferences.getInstance();
  }

  setString(String key, String value) {
    prefs?.setString(key, value).then((value) => log("save string value is ${value?'success':'fail'}  key is $key value is $value"));
  }

  setDouble(String key, double value) {
    prefs?.setDouble(key, value);
  }

  setInt(String key, int value) {
    prefs?.setInt(key, value);
  }

  setBool(String key, bool value) {
    prefs?.setBool(key, value);
  }

  setStringList(String key, List<String> value) {
    prefs?.setStringList(key, value);
  }

  remove(String key) {
    prefs?.remove(key);
  }

  T? get<T>(String key) {
    var result = prefs?.get(key);
    if (result != null) {
      return result as T;
    }
    return null;
  }
}
