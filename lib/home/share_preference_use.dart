import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharePreferenceUse extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => SharePreferenceUseState();
}

class SharePreferenceUseState extends State<SharePreferenceUse> {
  Future<SharedPreferences> _preference = SharedPreferences.getInstance();
  String localString = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("share preference/本地数据存储 使用"),
      ),
      body: Column(
        children: [
          InkWell(
            onTap: () async {
              print("inkwell click");
              saveData();
            },
            child: const Text("测试-- inkwell/保存本地当前的时间"),
          ),
          ElevatedButton(
              onPressed: getData,
              child: Text("获取本地储存的数据")),
          Text("${DateTime.now()}"),
          Text("读取到的本地时间：${localString}"),
        ],
      ),
    );
  }

  void saveData() async {
    final SharedPreferences preferences = await _preference;
    preferences.setString("time", DateTime.now().toString()).then((value) {
      print("save data result :$value");
      return DateTime.now().toString();
    }).catchError((err){
      print("存储数据失败:$err");
    });
  }

  void getData() async {
    final SharedPreferences preferences = await _preference;
    var time = preferences.getString("time") as String;
    print("time : ${time}");
    setState(() {
      localString = time;
    });
  }
}
