import 'package:flutter/material.dart';
class StatefulUse extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _statefulUse();
  }
}

class _statefulUse extends State<StatefulUse> {
  String _string = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("有状态变化widget的使用"),
      ),
      body: Container(
        child: Column(
          children: [
            Text("有状态变化widget的使用"),
            TextField(

              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.greenAccent),
                  borderRadius: BorderRadius.circular(4),
                ),
                labelText: "textfield 的简单使用",
                labelStyle: TextStyle(color: Colors.black87),
                hintText: "12323123",
                hintStyle: TextStyle(color: Colors.grey),
                helperText: "helperText 的使用",
                helperMaxLines: 1,
                helperStyle: TextStyle(color: Colors.black87),
                errorText: "errorText 的使用",
                errorMaxLines: 1,
                errorStyle: TextStyle(color: Colors.redAccent),
                errorBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.red),
                  borderRadius: BorderRadius.circular(3)
                ),
                suffix: Text("suffix"),
                suffixIcon: Icon(Icons.ac_unit),
                filled: true,
                prefix: Text("prefix"),
                prefixIcon: Icon(Icons.pregnant_woman),
                focusColor: Colors.greenAccent

              ),
              controller: null,
              keyboardType: TextInputType.phone,
              obscureText: true, /// 是否是密码
              /// 显示光标
              showCursor: true,
              maxLength: 199,
              onChanged: (newValue){
                print("textfield ----- onChanged : $newValue");
                setState(() {
                  _string = newValue;
                });
              },
              onEditingComplete: (){
                print("textfield ----- onEditingComplete");
              },
              onTap: (){
                print("textfield ----- onTap");
              },
            ),
            Text("text field 的内容:$_string 内容的长度：${_string.length} 总长度:${199}"),
            Container(
              height: 100,
              margin: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.transparent
              ),
              child: PhysicalModel(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(6),
                /// 抗锯齿，不开就会看不到圆角
                clipBehavior: Clip.antiAlias,
                child: PageView(
                  children: [
                    _item("page1",Colors.amber),
                    _item("page2",Colors.teal),
                    _item("page3",Colors.blueGrey),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget _item(String s, Color color) {
  return Container(
    color: color,
    child: Text(s),
  );
}