import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo/utils/app_singleton.dart';

class AppLifeCycle extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return AppLifeCyclePage();
  }
}

class AppLifeCyclePage extends State<AppLifeCycle> with WidgetsBindingObserver {
  @override
  void initState() {
    WidgetsBinding.instance!.addObserver(this);
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance!.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("app 的生命周期的介绍"),
      ),
      body: Center(
        child: ListView(
          children: [
            Text("app 的生命周期的介绍"),
            TextField(
              controller: null,
              decoration: InputDecoration(
                hintText: "app 的生命周期的介绍",

              ),

            ),
            ElevatedButton(onPressed: (){
              setState(() {
                AppSingleton.brightness =  AppSingleton.brightness == Brightness.dark ? Brightness.light : Brightness.dark;
              });
            }, child: Text("切换主题模式"))
          ],
        ),
      ),
    );
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    print("AppLifecycleState:$state");
    switch (state) {
      case AppLifecycleState.resumed: //前台，活动状态
        break;
      case AppLifecycleState.inactive:
        break;
      case AppLifecycleState.paused: // 进入后台
        break;
    }
  }
}
