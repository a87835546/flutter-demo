import 'package:flutter/material.dart';
import 'package:flutter_demo/home/device_info_page.dart';
import 'package:flutter_demo/home/home.dart';
import 'package:flutter_demo/tabbar/custom_bottom_navigation_bar.dart';
import 'package:flutter_demo/utils/app_singleton.dart';

import 'home/app_lifecycle.dart';
import 'home/catalogue_list.dart';
import 'home/list_view_controller.dart';
import 'home/navigator_use.dart';
import 'home/page_transition.dart';
import 'home/stateful_use.dart';
import 'home/widget_lifecycle.dart';
import 'mine/mine.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  MyApp({Key? key}) : super(key: key);
  @override
  late int i ;
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        brightness: AppSingleton.brightness,
        primarySwatch: Colors.blue,
      ),
      // home: const MyHomePage(title: 'Flutter Demo Home Page'),
      home: CustomBottomNavigationBar(),
      routes: <String,WidgetBuilder>{
        'home': (BuildContext context)=>Home(),
        'mine': (BuildContext context)=>Mine(),
        'stateful_use': (BuildContext context)=>StatefulUse(),
        'navigator_use': (BuildContext context)=>const NavigatorUse("123"),
        'list_view_controller': (BuildContext context)=>ListViewController(),
        'widget_lifecycle': (BuildContext context)=>WidgetLifeCycle(),
        'app_lifecycle': (BuildContext context)=>AppLifeCycle(),
        'page_transition': (BuildContext context)=>PageTransition(),
        'device_info': (BuildContext context)=>DeviceInfo(),

        'catalogue_list': (BuildContext context)=>CatalogueList(),

      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("flutter 学习"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
