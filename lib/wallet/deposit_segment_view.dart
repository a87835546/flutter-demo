import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter_demo/utils/color_util.dart';

typedef DepositSegmentViewClick = Function(String);

class DepositSegmentView extends StatefulWidget {
  final DepositSegmentViewClick click;

  const DepositSegmentView({Key? key, required this.click}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _DepositSegmentViewState();
}

class _DepositSegmentViewState extends State<DepositSegmentView> {
  var select = "存款";

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:const EdgeInsets.only(left: 14, right: 14, top: 20, bottom: 5),
      // height: 90,
      color: ColorUtil.hexColor('0x1A1A1C'),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: ['存款', '取款', '交易记录', '银行卡'].map((e) {
          return GestureDetector(
            onTap: () {
              setState(() {
                select = e;
              });
              widget.click(e);
            },
            child: Container(
              height: 32,
              width: (MediaQuery.of(context).size.width - 28 - 30) / 4,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: e != select
                    ? ColorUtil.hexColor('0xC1C2C4')
                        .withAlpha((0.58 * 255).toInt())
                    : ColorUtil.mainColor(),
              ),
              alignment: Alignment.center,
              child: Text(
                e,
                style: TextStyle(
                    color: e != select
                        ? ColorUtil.mainTitleColor()
                        : ColorUtil.hexColor('0x3a3a3a')),
                textAlign: TextAlign.center,
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
