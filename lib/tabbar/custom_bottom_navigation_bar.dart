import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_demo/home/home.dart';
import 'package:flutter_demo/mine/mine.dart';
import 'package:flutter_demo/sport/sport.dart';
import 'package:flutter_demo/wallet/deposit_view.dart';

/// 底部tabbar  和 头部导航栏
class CustomBottomNavigationBar extends StatefulWidget {
  const CustomBottomNavigationBar({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return TabbarController();
  }
}

class TabbarController extends State<CustomBottomNavigationBar> {
  int selectedIndex = 0;
  final List tabbar_controllers = [
    const Home(),
    const SportPage(),
    const DepositView(),
    const Mine(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: tabbar_controllers[selectedIndex],
      bottomNavigationBar: _createBottomBar(),
    );
  }

  Widget _createBottomBar() {
    return BottomNavigationBar(
      currentIndex: selectedIndex,
      selectedItemColor: Colors.greenAccent,
      unselectedItemColor: Colors.redAccent,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home, color: Colors.black12),
          activeIcon: Icon(Icons.home, color: Colors.greenAccent),
          label: "首页",
        ),
        BottomNavigationBarItem(
            icon: Icon(Icons.sports, color: Colors.black12),
            activeIcon: Icon(Icons.sports, color: Colors.greenAccent),
            label: "体育"),
        BottomNavigationBarItem(
          icon: Icon(Icons.wallet_membership, color: Colors.black12),
          activeIcon: Icon(Icons.wallet_membership, color: Colors.greenAccent),
          label: "充值",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person, color: Colors.black12),
          activeIcon: Icon(Icons.person, color: Colors.greenAccent),
          label: "我的",
        ),
      ],
      onTap: (index) {
        print("tabbar selected index : $index");
        setState(() {
          selectedIndex = index;
        });
      },
    );
  }
}
