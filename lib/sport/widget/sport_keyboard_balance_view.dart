import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo/mine/widget/user_info_button.dart';
import 'package:flutter_demo/utils/color_util.dart';

class SportKeyboardBalanceView extends StatelessWidget {
  final String balance;
  final Function? refresh;

  const SportKeyboardBalanceView(
      {Key? key, required this.balance, this.refresh})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      child: Row(
        children: [
          Container(
            child: Text("余额",style: TextStyle(
              color: Color(0xffC1C2C4)
            ),),
          ),
          SizedBox(width: 2,),
          UserInfoButton(
              title: Text(
                "${balance}",
                style: TextStyle(
                    color: ColorUtil.mainColor(),
                    fontSize: 14,
                    fontWeight: FontWeight.w400),
              ),
              iconName: "imgs/mine/images/icon-Refresh@3x.png",
              width: 100,
              click: () async {
                if (refresh != null) {
                  refresh!();
                }
              }),
          Expanded(
              child: Container(
            alignment: Alignment.centerRight,
            child: Text(
              "限额10.00~5000.00",
              style: TextStyle(fontSize: 13,color: Color(0xffC1C2C4)),
            ),
          )),
        ],
      ),
    );
  }
}
