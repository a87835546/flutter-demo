import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo/utils/color_util.dart';
import 'package:flutter_demo/utils/http_manager.dart';
import 'package:flutter_demo/wallet/entity/deposit_style_model.dart';

typedef DepositStyleViewClick = Function(int);
class DepositStyleView extends StatefulWidget {
  final DepositStyleViewClick click;
  final List<DepositStyleModel> data;
  const DepositStyleView({Key? key,required this.click,required this.data}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _DepositStyleViewState();
}

class _DepositStyleViewState extends State<DepositStyleView> {
  var selected = null;

  @override
  Widget build(BuildContext context) {
    return Container(
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
                children: widget.data.map((e) {
                  return GestureDetector(
                    onTap: (){
                      widget.click(widget.data.indexOf(e));
                      setState(() {
                        selected = e;
                      });
                    },
                    child: Stack(
                      children: [
                        Container(
                            height: 62,
                            width: 62,
                            child: Image.network(e.url)
                        ),
                        Visibility(child: Positioned(child: Image.asset("imgs/deposit/images/deposit-images-choose@3x .png",height: 62,
                          width: 62,fit: BoxFit.cover,)),visible: selected == e,)
                      ],
                    ),
                  );
                }).toList()),
          )
        ],
      ),
    );
  }

}
