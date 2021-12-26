import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo/mine/model/user_info_model.dart';
import 'package:provider/provider.dart';

/// provider 全局的状态管理 使用
class ProviderPage extends StatelessWidget {
  const ProviderPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ProviderModel>(
        create: (_) => ProviderModel(),
        child: Scaffold(
          appBar: AppBar(
            title: Text("provider 的使用介绍"),
            centerTitle: true,
          ),
          body: Center(
            child: ListView(
              children: [
                Text("123123123"),
                Consumer(builder:
                    (BuildContext context, ProviderModel value, Widget? child) {
                  log("value ---->>> $value");
                  return Text("${value.name}");
                }),
                ElevatedButton(
                  onPressed: (){
                    context.read<ProviderModel>().doSomething();
                  },
                  child: Text("++++++++"),
                )
              ],
            ),
          ),
        ));
  }
}

class ProviderModel extends ChangeNotifier {
  int count = 0;
  String name = "zhangsan";

  void doSomething() {
    log("provider model function doing ");
    notifyListeners();
  }
}
class UserProviderModel extends ChangeNotifier {
  UserInfoModel? userInfoModel;
  int count = 0;
  String name = "zhangsan";

  void doSomething() {
    log("provider model function doing ");
    notifyListeners();
  }

  void updateUserInfo(){
    notifyListeners();

  }
}