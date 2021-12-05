import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo/custom_widget/login_input_view.dart';
import 'package:flutter_demo/utils/color_util.dart';

class DepositAmountView extends StatefulWidget {
  const DepositAmountView({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _DepositAmountViewState();
}

class _DepositAmountViewState extends State<DepositAmountView> {
  final TextEditingController _controller = TextEditingController();
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
                    cursorColor:Color(0xffC1C2C4),
                    keyboardType: TextInputType.number,
                    controller: _controller,
                    style: TextStyle(
                      color: Color(0xffC1C2C4),
                      fontSize: 12
                    ),
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
                                color: ColorUtil.hexColor('0x212222')),
                            child: Text(
                              e,
                              style: TextStyle(
                                  color: ColorUtil.hexColor('0x919699')),
                            ),
                          ),
                          onTap: () {
                            _controller.text = e;
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
                        gradient: LinearGradient(colors: [
                          ColorUtil.hexColor('0x3C3E41'),
                          ColorUtil.hexColor('0x37373A')
                        ])),
                    child: Text(
                      '确定',
                      style: TextStyle(color: Color(0xffC1C2C4)),
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
