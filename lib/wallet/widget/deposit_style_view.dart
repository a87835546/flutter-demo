import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo/utils/color_util.dart';

typedef DepositStyleViewClick = Function(int);
class DepositStyleView extends StatefulWidget {
  final DepositStyleViewClick click;
  const DepositStyleView({Key? key,required this.click}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _DepositStyleViewState();
}

class _DepositStyleViewState extends State<DepositStyleView> {
  List list = [
    'imgs/deposit/images/alipay@3x.png',
    'imgs/deposit/images/alipay@3x.png',
    'imgs/deposit/images/alipay@3x.png',
    'imgs/deposit/images/alipay@3x.png'
  ];
  var select = "";
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
                children: list.map((e) {
                  return GestureDetector(
                    onTap: (){
                      setState(() {
                        select = e;
                      });
                      widget.click(list.indexOf(e));
                    },
                    child: Container(
                      height: 62,
                      width: 62,
                      child: Image.asset(e),
                    ),
                  );
                }).toList()),
          )
        ],
      ),
    ));
  }
}
