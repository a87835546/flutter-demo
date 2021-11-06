
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class WidgetLifeCycle extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    print("------- 生命周期 createState------- ");
    return LifeCyclePage();
  }
}

class LifeCyclePage extends State<WidgetLifeCycle> {
  int i = 0;

  /// 初始化widget
  @override
  void initState() {
    print("------- 生命周期 initState------- ");
    super.initState();
  }

  /// 当有新的widget之后调用
  @override
  void didUpdateWidget(WidgetLifeCycle oldWidget) {
    print("------- 生命周期 didUpdateWidget------- ");
    super.didUpdateWidget(oldWidget);
  }


  /// 在销毁这个widget 之前调用
  @override
  void deactivate() {
    print("------- 生命周期 deactivate------- ");
    super.deactivate();
  }


  /// 销毁这个页面，就是widget
  @override
  void dispose() {
    print("------- 生命周期 dispose------- ");
    super.dispose();
  }

  /// build 是在调用了是setState 之后回被调用
  @override
  Widget build(BuildContext context) {
    print("------- 生命周期 build------- ");
    return Scaffold(
      appBar: AppBar(
        title: Text("widget 的常用生命周期的介绍"),
      ),
      body: Center(
        child: Container(
          child: Column(
            children: [
              ElevatedButton(onPressed: _clickBtn, child:
                  Text("点击")
              ),
              Text(i.toString()),
              ],
          ),
        ),
      ),
    );
  }

  void _clickBtn() {
    setState(() {
      i ++;
    });
  }
}