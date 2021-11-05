
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
            const Text('''
            /// 方法一，使用路由名称去跳转，首先需要在mian里面注册路由
                      /// arguments: model 传递过去的参数
                      // Navigator.pushNamed(context, model.routerName,arguments: model);
                      /// 方法二，不使用路由跳转，
                      final result = await Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        if (model.name == null) {
                          /// 需要传参
                          return RouterPassArguments(model);
                        } else {
                          return model.name;
                        }
                      }));
                      /// 接收的回调，返回的参数，必须要使用 async await.
            ''')
          ],
        ) ,

      ),
    );
  }


}
