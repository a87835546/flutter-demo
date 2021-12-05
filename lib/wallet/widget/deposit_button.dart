import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo/utils/color_util.dart';

typedef DepositButtonClick = Function(String);
class DepositButton extends StatefulWidget {
  final String? title;
  final bool selected;
  final DepositButtonClick click;
  const DepositButton({Key? key, this.title,required this.selected,required this.click}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _DepositButtonState();
}

class _DepositButtonState extends State<DepositButton> {

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        widget.click(widget.title??"");
        log('click deposit button ${widget.title}');
      },
      child: Container(
        height: 50,
        alignment: Alignment.center,
        padding: EdgeInsets.only(top: 5),
        child: Column(
          children: [
            Text(
              widget.title ?? "人民币充值",
              style: TextStyle(
                color:widget.selected ? ColorUtil.mainColor():ColorUtil.mainTitleColor(),
              ),
            ),
            Container(
              height: 1,
              width: 30,
              color:widget.selected ? ColorUtil.mainColor():Colors.transparent,
            )
          ],
        ),
      ),
    );
  }
}
