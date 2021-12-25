import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo/utils/color_util.dart';

import '../deposit_style_page.dart';

typedef DepositAmountViewClick = Function(dynamic);

class DepositAmountView extends StatefulWidget {
  final DepositStylePageType? type;
  final String? placeholder;
  final String? suffix;
  final String? prefix;
  final String? rightDescription;
  final List<String> amount;
  final DepositAmountViewClick? click;

  const DepositAmountView({
    Key? key,
    this.type = DepositStylePageType.deposit,
    this.placeholder,
    this.suffix,
    this.prefix,
    this.rightDescription,
    this.click,
    required this.amount,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _DepositAmountViewState();
}

class _DepositAmountViewState extends State<DepositAmountView> {
  final TextEditingController _controller = TextEditingController();
  var select = "";
  var _value = "";
  List<String> _list = ['100', '500', '600', '1000', '5000'];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _list = widget.amount.isNotEmpty ? widget.amount : _list;
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
                ),
                Visibility(
                  visible: widget.rightDescription != null,
                  child: Expanded(
                      child: Container(
                    padding: EdgeInsets.only(right: 20),
                    alignment: Alignment.centerRight,
                    child: Text(
                      "${widget.rightDescription}",
                      style: TextStyle(color: Color(0xff919699)),
                    ),
                  )),
                ),
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
                    cursorColor: const Color(0xffC1C2C4),
                    keyboardType: TextInputType.number,
                    controller: _controller,
                    style:
                        const TextStyle(color: Color(0xffC1C2C4), fontSize: 12),
                    decoration: const InputDecoration(
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
                  child: GridView.count(
                    crossAxisCount: _list.length,
                    crossAxisSpacing: 12,
                    padding: const EdgeInsets.all(4.0),
                    childAspectRatio: 1.6,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    children: _list.map((e) {
                      return GestureDetector(
                        child: Container(
                          height: 34,
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
                    }).toList(),
                  ),
                ),
                GestureDetector(
                  child: Padding(
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
                  onTap: () {
                    if (widget.click != null) {
                      widget.click!(_controller.text);
                    }
                  },
                  behavior: HitTestBehavior.translucent,
                )
              ],
            ),
          )
        ],
      ),
    ));
  }
}
