import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo/mine/mine_userinfo/mine_userinfo.dart';
import 'package:flutter_demo/mine/model/user_info_model.dart';
import 'package:flutter_demo/utils/app_singleton.dart';
typedef UserInfoViewEdit = void Function();
class UserInfoView extends StatefulWidget {
  final UserInfoModel? infoModel;
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
            child:(AppSingleton.userInfoModel?.avatar != null && AppSingleton.userInfoModel?.avatar != "" )
                ? Image.network(
              "${AppSingleton.userInfoModel?.avatar}",
              width: 40,
              height: 40,
            )
                : Image.asset(
              "imgs/mine/images/tx_icon@3x.png",
              width: 40,
              height: 40,
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
    // return "1";
    if(AppSingleton.userInfoModel?.registerTime != null){
      String registerTime = AppSingleton.userInfoModel?.registerTime??"";
      int start = DateTime.parse(registerTime).millisecondsSinceEpoch;
      int end = DateTime.now().millisecondsSinceEpoch;
      int days = (end-start)~/(1000*24*3600) + 1;
      return days.toString();
    }else{
      return "1";
    }

  }
}