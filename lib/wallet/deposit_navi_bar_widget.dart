import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo/mine/widget/user_info_button.dart';
import 'package:flutter_demo/utils/color_util.dart';
import 'package:fluttertoast/fluttertoast.dart';

class DepositNaviBar extends StatefulWidget {
  final String balance;
  final double height;
  const DepositNaviBar({Key? key,required this.balance,required this.height}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _DepositNaviBarState();

}

class _DepositNaviBarState extends State<DepositNaviBar>{
  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height + 40,
      color: ColorUtil.hexColor('0x1A1A1C'),
      child: Padding(
        padding: EdgeInsets.only(top: widget.height),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(padding: EdgeInsets.only(left: 10),child:
            SizedBox(
                child: _createLogoView()
            )),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                UserInfoButton(
                    title:Text(
                      "￥${widget.balance}",
                      style: const TextStyle(
                          color: Color(0xffC1C2C4),
                          fontSize: 14,
                          fontWeight: FontWeight.w400),
                    ),
                    iconName:"imgs/mine/images/icon-Refresh@3x.png",
                    width:100, click:() async {
                  Fluttertoast.showToast(msg: "点击 余额");
                }),
                IconButton(onPressed: (){
                  Fluttertoast.showToast(msg: "点击 跟多");
                }, icon: Image.asset("imgs/deposit/images/icon-List@3x.png")),
              ],
            )

          ],
        ),
      ),
    );
  }
  Widget _createLogoView() {
    return SizedBox(
        height: 40,
        width: 60,
        child: Image.network(
          "https://img0.baidu.com/it/u=2137386184,3836304387&fm=26&fmt=auto",
          width: 60,
          fit: BoxFit.fitWidth,
        ));
  }
}