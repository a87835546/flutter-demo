import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceUtil {
  static SharedPreferences? sharedPreferences ;
  static SharedPreferenceUtil? instance ;

  SharedPreferenceUtil._(){
    init();
  }
  static SharedPreferenceUtil  getInstance(){
    if(instance == null){
      SharedPreferenceUtil._();
    }
    return instance!;
  }

  void init() async {
    sharedPreferences ??= await SharedPreferences.getInstance();
  }


}