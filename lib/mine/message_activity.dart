import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo/base_page/base_page.dart';
import 'package:flutter_demo/utils/color_util.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class MessageActivity extends StatefulWidget {
  const MessageActivity({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _MessageActivityState();
}

class _MessageActivityState extends State<MessageActivity> with BasePage {
  RefreshController refreshController = RefreshController();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [ColorUtil.hexColor("0x1A1A1C"),ColorUtil.hexColor("0x202123")]
        )
      ),
        child: SmartRefresher(

      controller: refreshController,
      onRefresh: () {
        log("下拉刷新");
        refreshController.refreshCompleted();
      },
      onLoading: () {
        log("加载更多");
        refreshController.loadComplete();
      },
      child: show ? setNetError(context) : _createView(),
    ));
  }

  Widget _createView() {
    return ListView.separated(
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: (){
              log("activity page click cell index : $index");
            },
            child:  Container(
              height: 60,
              child: ListTile(
                title: Text("123",style: TextStyle(
                    color: Colors.white
                ),),
              ),
            ),
          );
        },
        separatorBuilder: (context, index) {
          return Divider(
            color: Colors.indigoAccent,
          );
        },

        itemCount: 2);
  }
}
