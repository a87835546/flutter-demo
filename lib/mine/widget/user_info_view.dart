import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo/mine/model/user_vip_info_model.dart';
typedef UserInfoViewEdit = void Function();
class UserInfoView extends StatefulWidget {
  final UserVipInfoModel? infoModel;
  final UserInfoViewEdit clickEdit;
  const UserInfoView({Key? key,required this.infoModel,required this.clickEdit}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _UserInfoViewState();

}

class _UserInfoViewState extends State<UserInfoView>{
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 48, left: 12),
      height: 100,
      width: 150,
      alignment: Alignment.center,
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(24),
            child: Image.asset(
              "imgs/mine/images/tx_icon@3x.png",
              width: 48,
              height: 48,
            ),
          ),
          GestureDetector(
            onTap: () async {
              widget.clickEdit();
            },
            child: Center(
              widthFactor: 1,
              child: Container(
                height: 20,
                width: 160,
                padding:const EdgeInsets.only(left: 40),
                margin: EdgeInsets.only(top: 5, bottom: 5),
                color: Colors.transparent,
                alignment: Alignment.center,
                child: Row(
                  children: [
                    Text(
                      "${widget.infoModel?.loginName}",
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w400),
                    ),
                    Image.asset(
                      "imgs/mine/images/icon-edit@3x.png",
                      height: 16,
                      width: 16,
                    )
                  ],
                )
              ),
            ),
          ),
          Container(
            child: Text(
              '加入中国第${getJoinDays()}天',
              style:const TextStyle(
                  color: Color(0xffC1C2C4),
                  fontSize: 9,
                  fontWeight: FontWeight.w400),
            ),
          )
        ],
      ),
    );
  }

  String getJoinDays(){
    return "1";
    String registerTime = "";//HiCache.getInstance().get("registerTime");
    if (registerTime==null){
      return "1";
    }
    int start = DateTime.parse(registerTime).millisecondsSinceEpoch;
    int end = DateTime.now().millisecondsSinceEpoch;
    int days = (end-start)~/(1000*24*3600);
    return days.toString();
  }
}