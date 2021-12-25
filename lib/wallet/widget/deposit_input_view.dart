import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo/utils/color_util.dart';
typedef DepositInputViewValueDidChange = Function(String);
class DepositInputView extends StatefulWidget {
  /// 前面货币
  final String prefixTitle;
  final String? placeholder;
  final String tips;
  final DepositInputViewValueDidChange didChange;

  const DepositInputView(
      {Key? key,
      required this.prefixTitle,
      required this.placeholder,
      required this.tips,
      required this.didChange})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _DepositInputViewState();
}

class _DepositInputViewState extends State<DepositInputView> {
  TextEditingController _controller = TextEditingController();
  var _value = "";

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        color: ColorUtil.hexColor('0x212222'),
      ),
      child: Stack(
        children: [
          Row(
            children: [
              Container(
                child: Text(
                  widget.prefixTitle,
                  style: TextStyle(color: Color(0xffC1C2C4), fontSize: 14),
                ),
              ),
              Expanded(
                child: Container(
                  alignment: Alignment.center,
                  child: TextField(
                    cursorColor: Color(0xffC1C2C4),
                    keyboardType: TextInputType.number,
                    controller: _controller,
                    style: TextStyle(color: Color(0xffC1C2C4), fontSize: 12,),
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: widget.placeholder,
                        hintStyle: TextStyle(
                          color: Color(0xffC1C2C4)
                        ),

                        contentPadding: EdgeInsets.only( left:10,bottom: 10)),
                    onChanged: (value) {
                      log(value);
                      setState(() {
                        _value = value;
                      });
                      widget.didChange(value);
                    },
                    onEditingComplete: () {
                      log("123");
                    },
                  ),
                ),
              ),
            ],
          ),
          Positioned(
            right: 10,
            top: 0,
            child: Container(
              height: 36,
              alignment: Alignment.center,
              child: Text(
                widget.tips,
                style: TextStyle(color: Color(0xffC1C2C4), fontSize: 12,),
                textAlign: TextAlign.center,
              ),
            )
          )
        ],
      ),
    );
  }
}
