import 'package:flutter/material.dart';

class NavigatorUse extends StatefulWidget {
  final String title;
  const NavigatorUse(this.title, {Key? key}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return _navigatorUse();
  }
}

class _navigatorUse extends State<NavigatorUse>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Text(widget.title),
      ),
    );
  }
}