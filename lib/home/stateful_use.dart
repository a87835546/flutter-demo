import 'package:flutter/material.dart';
class StatefulUse extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _statefulUse();
  }
}

class _statefulUse extends State<StatefulUse> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("有状态变化widget的使用"),
      ),
      body: Center(
        child: Text("有状态变化widget的使用"),
      ),
    );
  }
}