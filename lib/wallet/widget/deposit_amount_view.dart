import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo/utils/color_util.dart';

import '../deposit_style_page.dart';
import 'deposit_input_view.dart';

class DepositAmountView extends StatefulWidget {
  final DepositStylePageType? type;
  final String? placeholder;
  final String? suffix;
  final String? prefix;

  const DepositAmountView(
      {Key? key,
      this.type = DepositStylePageType.deposit,
      this.placeholder,
      this.suffix,
      this.prefix})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _DepositAmountViewState();
}

class _DepositAmountViewState extends State<DepositAmountView> {
  final TextEditingController _controller = TextEditingController();
  var select = "";
  var _value = "";

  @override
  Widget build(BuildContext context) {
    return Container(
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
                  "充值金额",
                  style: TextStyle(color: Colors.white),
                )
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 15, right: 15, top: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: 35,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: ColorUtil.hexColor('0x212222'),
                  ),
                  child: TextField(
                    cursorColor: Color(0xffC1C2C4),
                    keyboardType: TextInputType.number,
                    controller: _controller,
                    style: TextStyle(color: Color(0xffC1C2C4), fontSize: 12),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      suffix: Padding(
                        padding: EdgeInsets.only(right: 10),
                        child: Text(
                          '限额10000',
                          style:
                              TextStyle(color: Color(0xffC1C2C4), fontSize: 12),
                        ),
                      ),
                      prefix: Text(
                        '￥',
                        style:
                            TextStyle(color: Color(0xffC1C2C4), fontSize: 14),
                      ),
                      focusColor: Colors.greenAccent,
                      labelStyle: TextStyle(
                        // color: Color(0xffC1C2C4),
                        color: Colors.redAccent,
                      ),
                    ),
                    onChanged: (value) {
                      setState(() {
                        _value = value;
                      });
                    },
                    onEditingComplete: () {
                      log("123");
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: ['100', '500', '1000', '5000'].map((e) {
                        return GestureDetector(
                          child: Container(
                            height: 34,
                            width: 70,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4),
                                color: select == e
                                    ? ColorUtil.mainColor()
                                    : ColorUtil.hexColor('0x212222')),
                            child: Text(
                              e,
                              style: TextStyle(
                                  color: select == e
                                      ? ColorUtil.hexColor('0x3A3A3A')
                                      : ColorUtil.hexColor('0x919699')),
                            ),
                          ),
                          onTap: () {
                            _controller.text = e;
                            setState(() {
                              select = e;
                            });
                          },
                        );
                      }).toList()),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 20),
                  child: Container(
                    height: 32,
                    width: 150,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      gradient: LinearGradient(
                          colors:
                              _value.length > 0 || _controller.text.length > 0
                                  ? [Color(0xffD0C3A6), Color(0xffD4C8A9)]
                                  : [Color(0xff3C3E41), Color(0xff37373A)]),
                    ),
                    child: GestureDetector(
                      onTap: () {},
                      child: Container(
                        child: Text(
                          '确定',
                          style: TextStyle(
                              color: _value.length > 0 ||
                                      _controller.text.length > 0
                                  ? Color(0xff3A3A3A)
                                  : Color(0xffC1C2C4)),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    ));
  }
}
