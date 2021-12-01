import 'dart:developer';

import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceUtil {
  static SharedPreferences? sharedPreferences ;
  static SharedPreferenceUtil? instance ;

  SharedPreferenceUtil._(){
    init();
  }
  static SharedPreferenceUtil  getInstance(){
    if(instance == null){
      instance = SharedPreferenceUtil._();
    }
    return instance!;
  }

  void init() async {

    sharedPreferences ??= await SharedPreferences.getInstance();
    log("init --->>>>> $sharedPreferences");
  }

  void saveString(String key, String data) async{
    await sharedPreferences?.setString(key,data);
  }

  Object? getData(String key){
    return sharedPreferences?.get(key);
  }
}