import 'package:flutter/material.dart';

List<String> names = [];

class ListViewController extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    _addData();
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
        body:RefreshIndicator(
          onRefresh: _refresh,
          child:  ListView(
            children: _createListViews(),
          ),
        )
    );
  }

  Future<void> _refresh() async {
    await Future.delayed(Duration(seconds: 1),(){
      print("refresh");
    });
  }
}

List<Widget> _createListViews() {
  return names.map((e) => _createItem(e)).toList();
}

Widget _createItem(title) {
  return Container(
    height: 100,
    margin: EdgeInsets.only(bottom: 1.0),
    alignment: Alignment.center,
    decoration: BoxDecoration(
        color: int.parse(title) % 2 == 0 ? Colors.white10 : Colors.white),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisSize: MainAxisSize.max,
      children: [
        Container(
          decoration: BoxDecoration(color: Colors.transparent),
          width: 80,
          alignment: Alignment.center,
          child: Column(
            children: [
              Text("letf:123",
                  style: TextStyle(fontSize: 20, color: Colors.black26)),
              Padding(padding: EdgeInsets.all(5),
                child:ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                  child: Opacity(opacity: 0.6,
                    child: Image.network("https://img.lianzhixiu.com/uploads/allimg/200229/30-2002291GU9.jpg",width: 60,height: 60,),
                  ),
                ) ,
                
              ),
            ],
          ),
        ),
        ///  Expanded 可以凑满整个父容器
        Expanded(
          child: Column(
            children: [
              Text("mid:$title",
                  style: TextStyle(
                      fontSize: 18,
                      color: Colors.red,
                      fontWeight: FontWeight.bold)),
              Text("mid:sub title",
                  style: TextStyle(fontSize: 12, color: Colors.black26)),
              ClipOval(
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                  child: SizedBox(
                    width: 60,
                    height: 60,
                    child: Image.network(
                        "https://img-pre.ivsky.com/img/tupian/pre/202104/01/oumei_meinv-013.jpg",
                      width: 60,
                      height: 60,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Container(
            decoration: BoxDecoration(color: Colors.yellow),
            width: 80,
            alignment: Alignment.center,
            child: Column(
              children: [Text("right: icon"), Icon(Icons.arrow_right)],
            ))
      ],
    ),
  );
}

_addData() {
  for (int i = 0; i < 1000; i++) {
    names.insert(0, i.toString());
  }
}
