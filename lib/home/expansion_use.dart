import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ExpansionUse extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => ExpansionUseState();
}

class ExpansionUseState extends State<ExpansionUse> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("expension 可折叠的列表使用"),
      ),
      body: Container(
        child: const ExpansionTile(
          title: Text("123"),
          subtitle: Text("234"),
          children: [
            ListTile(
              title: Text("list title "),
            ),
            ListTile(
              title: Text("list title "),
            ),
          ],
          initiallyExpanded: true,
        ),
      ),
    );
  }
}
