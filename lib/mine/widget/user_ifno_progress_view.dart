import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo/mine/model/user_sign_info_model.dart';

class UserInfoProgressView extends StatefulWidget {
  final UserSignInfoModel? signInfoModel;
  const UserInfoProgressView({Key? key,this.signInfoModel}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _UserInfoProgressViewState();
}

class _UserInfoProgressViewState extends State<UserInfoProgressView> {
  @override
  Widget build(BuildContext context) {
    int step = widget.signInfoModel?.taskConfigs.first.available.toInt()??0;
    // log("step ---- >>>> $step");
    return SizedBox(
        height: 40,
        child: ListView.builder(
          itemBuilder: (BuildContext context, int index) {
            return _createProgressItemView(index == 0, index >= step);
          },
          itemCount: 7,
          scrollDirection: Axis.horizontal,
        ));
  }

  Widget _createProgressItemView(bool isFirst, bool isSelected) {
    Color _color = Color(isSelected ? 0xff414148 : 0xffD0C3A6);

    return SizedBox(
      height: 40,
      width: 20 + (isFirst ? 0 : 30),
      child: Column(
        children: [
          Container(
            height: 17,
            width: 20 + (isFirst ? 0 : 30),
            alignment: Alignment.centerRight,
            // color: Colors.greenAccent,
            child: Text(
              isSelected ? "+0" : "+8",
              textAlign: TextAlign.right,
              style: TextStyle(
                  color: isSelected ? const Color(0xffC1C2C4) : Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.w400),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              isFirst
                  ? Container()
                  : Container(
                height: 2,
                width: 30,
                decoration: BoxDecoration(
                  color: _color,
                ),
              ),
              Image.asset(
                isSelected
                    ? "imgs/mine/images/icon-unselected@3x.png"
                    : "imgs/mine/images/icon-selected@3x.png",
                width: 20,
                height: 20,
              ),
            ],
          )
        ],
      ),
    );
  }
}
