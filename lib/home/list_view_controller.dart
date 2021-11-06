import 'package:flutter/material.dart';

class ListViewController extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ListViewPage();
  }

}

class ListViewPage extends State<ListViewController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ListView的基本使用"),
      ),
      body:Center(
        child:Container(
          child:
          ListView(
            children: [
              ListTile(
                leading: Icon(Icons.title),
                title: Text("123"),
                subtitle: Text("abc"),
                isThreeLine: true,
              ),
              ListTile(
                leading: Icon(Icons.title),
                title: Text("123"),
                subtitle: Text("abc"),

              ),
            ],
          ),
        ),
      ),
    );
  }
}