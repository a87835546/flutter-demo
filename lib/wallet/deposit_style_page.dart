import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo/utils/color_util.dart';
import 'package:flutter_demo/wallet/widget/deposit_amount_view.dart';
import 'package:flutter_demo/wallet/widget/deposit_channel_view.dart';
import 'package:flutter_demo/wallet/widget/deposit_style_view.dart';

class DepositStylePage extends StatefulWidget {
  const DepositStylePage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _DepositStylePageState();
}

class _DepositStylePageState extends State<DepositStylePage> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 15, right: 15),
      child: Container(
        // height: 490,
        decoration: BoxDecoration(
            color: ColorUtil.hexColor('0x2C2C2E'),
            borderRadius: BorderRadius.circular(5)),
        child: Padding(
          padding: EdgeInsets.only(left: 0, right: 0),
          child: Container(
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                DepositStyleView(click: (value){
                  log('click deposit style view $value');
                },),
                DepositChannelView(click:(value){
                  log("DepositChannelView");
                },),
                const DepositAmountView(),
                Padding(
                  padding: EdgeInsets.only(top: 10, bottom: 10),
                  child: Container(
                    child: GestureDetector(
                      child: Container(
                        height: 32,
                        width: 150,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(
                                color: ColorUtil.mainColor(), width: 1)),
                        alignment: Alignment.center,
                        child: Text(
                          "存款教程",
                          style: TextStyle(color: ColorUtil.mainColor()),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
