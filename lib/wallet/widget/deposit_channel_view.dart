import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo/utils/color_util.dart';

typedef DepositChannelViewClickItem = Function(String);
class DepositChannelView extends StatefulWidget {
  final DepositChannelViewClickItem click;
  const DepositChannelView({Key? key,required this.click}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _DepositChannelViewState();
}

class _DepositChannelViewState extends State<DepositChannelView> {
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
                  "充值渠道",
                  style: TextStyle(color: Colors.white),
                )
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 15, right: 15, top: 10),
            child: GridView.count(
              crossAxisCount: 2,
              mainAxisSpacing: 4.0,
              crossAxisSpacing: 4.0,
              padding: const EdgeInsets.all(4.0),
              childAspectRatio: 3,
              shrinkWrap: true,
              children: [
                'imgs/deposit/images/alipay@3x.png',
                'imgs/deposit/images/alipay@3x.png',
                'imgs/deposit/images/alipay@3x.png',
              ].map((e) {
                return GestureDetector(
                  onTap: (){
                    widget.click(e);
                    log("click deposit channel");
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      image: DecorationImage(
                        image: AssetImage(
                            "imgs/deposit/images/background-for-charge@3x.png"),
                      ),
                    ),
                    child: Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 20),
                          child: Container(
                            height: 30,
                            width: 36,
                            child: Image.asset(e),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 5),
                          child: Container(
                            alignment: Alignment.centerLeft,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "支付宝转账",
                                  style: TextStyle(color: Colors.white),
                                  textAlign: TextAlign.left,
                                ),
                                Text(
                                  "￥1-3",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 12),
                                  textAlign: TextAlign.left,
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
          )
        ],
      ),
    ));
  }
}
