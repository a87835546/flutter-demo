import 'package:flutter/material.dart';


class Mine extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _mine();
  }
}

class _mine extends State<Mine>{
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text("mine"),
      ),
    );
  }
}