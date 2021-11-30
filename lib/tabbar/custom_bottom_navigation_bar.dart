import 'package:flutter/material.dart';
import 'package:flutter_demo/home/home.dart';
import 'package:flutter_demo/mine/mine.dart';

/// 底部tabbar  和 头部导航栏
class CustomBottomNavigationBar extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return TabbarController();
  }
}

class TabbarController extends State<CustomBottomNavigationBar> {
  int selectedIndex = 0;
  final List tabbar_controllers = [Home(), const Mine()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: tabbar_controllers[selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.blueAccent,
        currentIndex: selectedIndex,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.home, color: Colors.black12),
              activeIcon: Icon(Icons.home, color: Colors.greenAccent),
              title: Text(
                "首页",
                style: TextStyle(
                  color: Colors.white,
                ),
              )),
          BottomNavigationBarItem(
              icon: Icon(Icons.person, color: Colors.black12),
              activeIcon: Icon(Icons.person, color: Colors.greenAccent),
              title: Text(
                "我的",
                style: TextStyle(
                  color: Colors.white,
                ),
              )),
        ],
        onTap: (index) {
          print("tabbar selected index : $index");
          setState(() {
            selectedIndex = index;
          });
        },
      ),
    );
  }
}
