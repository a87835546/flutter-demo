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
    return Scaffold(
      appBar: AppBar(
        title: Text("provider 的使用介绍"),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: [
            ChangeNotifierProvider<ProviderModel>(
              create: (_) => ProviderModel(),
              child: ListView(
                shrinkWrap: true,
                children: [
                  Text("provider model count :${context.read<ProviderModel>().count}"),
                  Consumer(builder: (BuildContext context, ProviderModel value,
                      Widget? child) {
                    log("value ---->>> $value");
                    return Text("${value.name}");
                  }),
                  ElevatedButton(
                    onPressed: () {
                      context.read<ProviderModel>().doSomething();
                    },
                    child: Text("provider model +++ "),
                  )
                ],
              ),
            ),
            ChangeNotifierProvider<UserProviderModel>(
              create: (_) => UserProviderModel(),
              child: ListView(
                shrinkWrap: true,
                children: [
                  Text("provider model count :${context.read<UserProviderModel>().count}"),
                  Consumer(builder: (BuildContext context, UserProviderModel value,
                      Widget? child) {
                    log("value ---->>> $value");
                    return Text("${value.name}");
                  }),
                  ElevatedButton(
                    onPressed: () {
                      context.read<UserProviderModel>().doSomething();
                    },
                    child: Text("user provider model"),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      context.read<UserProviderModel>().updateUserInfo();
                    },
                    child: Text("user provider model count ++"),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
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
    log("provider user model function doing ");
    notifyListeners();
  }

  void updateUserInfo() {
    count++;
    log('user provider model count $count');
    notifyListeners();
  }
}
