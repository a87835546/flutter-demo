import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo/utils/color_util.dart';
import 'package:flutter_demo/utils/http_manager.dart';
import 'package:flutter_demo/wallet/entity/deposit_style_model.dart';

typedef DepositStyleViewClick = Function(DepositStyleModel);
class DepositStyleView extends StatefulWidget {
  final DepositStyleViewClick click;
  const DepositStyleView({Key? key,required this.click}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _DepositStyleViewState();
}

class _DepositStyleViewState extends State<DepositStyleView> {
  List<DepositStyleModel> _list = [];
@override
  void initState() {
    super.initState();
    getStyle();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
        // height: 90,
        child: Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 10),
            child: Row(
              children: [
                Container(
                  height: 20,
                  width: 2,
                  color: ColorUtil.mainColor(),
                ),
                Padding(padding: EdgeInsets.only(left: 10)),
                Text(
                  "充值方式",
                  style: TextStyle(color: Colors.white),
                )
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 15, right: 15, top: 10),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: _list.map((e) {
                  return GestureDetector(
                    onTap: (){
                      widget.click(e);
                    },
                    child: Container(
                      height: 62,
                      width: 62,
                      child: Image.network(e.url)
                    ),
                  );
                }).toList()),
          )
        ],
      ),
    ));
  }

  void getStyle(){
    HttpManager.get(url: "/wallet/deposit/style").then((value){
      List<DepositStyleModel> lists = [];
      if(value['data'] != null) {
        List<dynamic> temp = value["data"];

        temp.forEach((element) {
          lists.add(DepositStyleModel.fromJson(element));
        });
        log("$lists");
        setState(() {
          _list = lists;
        });
      }
    }).catchError((err){
      log("${err.toString()}");
    });
  }
}
