import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter_demo/utils/color_util.dart';

import 'deposit_button.dart';

typedef DepositTransactionSegmentViewClick = Function(int);

class DepositTransactionSegmentView extends StatefulWidget {
  final DepositTransactionSegmentViewClick click;
  final int index;
  const DepositTransactionSegmentView({Key? key, required this.click,required this.index})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _DepositTransactionSegmentViewState();
}

class _DepositTransactionSegmentViewState
    extends State<DepositTransactionSegmentView> {
  var select = "存款1";
  List list = ['存款1', '存款2', '存款3', '存款4', '存款5'];

  @override
  Widget build(BuildContext context) {
    select = list[widget.index];
    return Container(
      padding: const EdgeInsets.only(left: 14, right: 14, top: 20, bottom: 5),
      color: ColorUtil.hexColor('0x1A1A1C'),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: list.map((e) {
          return DepositButton(
            click: (value) {
              setState(() {
                select = value;
              });
              widget.click(list.indexOf(value));
            },
            selected: select == e,
            title: e,
          );
        }).toList(),
      ),
    );
  }
}
