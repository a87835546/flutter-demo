
import 'package:flutter/material.dart';
import 'package:flutter_demo/home/home.dart';

class RouterPassArguments extends StatefulWidget {
  /// 此模型 接受前面传递过来的参数，
  final RouterModel model;
  const RouterPassArguments(this.model, {Key? key}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return _routerPassArgemnts();
  }

}

class _routerPassArgemnts extends State<RouterPassArguments> {

  _clickBtn(){
    print("点击回传参数");
    Navigator.pop(context,{'abc':"反向传值，回调",'def':'参数'});
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.model.navTitle),
      ),
      body: Center(
        child: Column(
          children: [
            Text(widget.model.navTitle),
            ElevatedButton(onPressed:
            _clickBtn, child: const Text("点击回传参数")),
          ],
        ) ,

      ),
    );
  }


}
