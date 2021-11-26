import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo/mine/widget/user_info_button.dart';
import 'package:fluttertoast/fluttertoast.dart';

class MineWalletView extends StatefulWidget {
  final int balance;
  const MineWalletView({Key? key,required this.balance}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _MineWalletViewState();
}

class _MineWalletViewState extends State<MineWalletView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30,
      padding: const EdgeInsets.only(left: 10, right: 10),
      margin: const EdgeInsets.only(top: 15),
      decoration: const BoxDecoration(color: Colors.transparent),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          UserInfoButton(
              title:const Text(
                "我的钱包",
                style: TextStyle(
                    color: Color(0xffC1C2C4),
                    fontSize: 14,
                    fontWeight: FontWeight.w400),
              ),
              iconName: "imgs/mine/images/iocn-Unfold@3x.png",
              width:80,click: () async {
            Fluttertoast.showToast(msg: "点击我的钱包");
          }),
          UserInfoButton(
              title:Text(
                "${widget.balance}",
                style: const TextStyle(
                    color: Color(0xffC1C2C4),
                    fontSize: 14,
                    fontWeight: FontWeight.w400),
              ),
              iconName:"imgs/mine/images/icon-Refresh@3x.png",
              width:100, click:() async {
            Fluttertoast.showToast(msg: "点击 余额");
          }),
          Container(
            width: 128,
            height: 24,
            alignment: Alignment.center,
            decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(12)),
                border: Border.all(width: 1, color: const Color(0xffD3C294)),
                color: Colors.transparent),
            child: Row(
              children: [
                SizedBox(
                  width: 63,
                  height: 22,
                  child: GestureDetector(
                    onTap: () {
                      Fluttertoast.showToast(msg: "提款");
                    },
                    child: Container(
                      width: 62,
                      alignment: Alignment.center,
                      child: const Text(
                        "提款",
                        style: TextStyle(
                          color: Color(0xffD0C3A6),
                          backgroundColor: Colors.transparent,
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 63,
                  height: 22,
                  child: GestureDetector(
                    onTap: () {
                      Fluttertoast.showToast(msg: "充值");
                    },
                    child: Container(
                      width: 62,
                      alignment: Alignment.center,
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(12),
                              bottomRight: Radius.circular(12)),
                          color: Color(0xffD0C3A6)),
                      child: const Text(
                        "充值",
                        style: TextStyle(
                          color: Color(0xff3a3a3a),
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
