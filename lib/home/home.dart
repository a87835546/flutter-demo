import 'package:flutter/material.dart';


class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _home();
  }
}

class _home extends State<Home>{
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
          title: Text("flutter 学习资料"),
      ),
      body: Center(
        child: Container(
          child: RefreshIndicator(child: ListView(
            children: <Widget>[
                ListTile(
                  leading: Icon(Icons.home),
                  title: Text("1"),
                ),
              ListTile(
                leading: Icon(Icons.home),
                title: Text("2"),
              ),
              ListTile(
                leading: Icon(Icons.home),
                title: Text("3"),
              ),
            ],
          ), onRefresh: _refresh),
        ),
      ),
    );
  }
  Future<void> _refresh ()async {
    print("下拉刷新开始");
    Future.delayed(Duration(milliseconds:300),(){
      print("下拉刷新------end");
    });
  }
}

