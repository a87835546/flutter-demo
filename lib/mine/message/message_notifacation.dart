import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo/base_page/base_page.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class MessageNotification extends StatefulWidget {
  const MessageNotification({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _MessageNotificationState();
}

class _MessageNotificationState extends State<MessageNotification>
    with BasePage {
  RefreshController refreshController = RefreshController();

  @override
  Widget build(BuildContext context) {
    return Container(
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
}

Widget _createView() {
  return ListView.separated(
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: (){
            log("notification page click cell index : $index");
          },
          child:  Container(
            height: 60,
            child: ListTile(
              title: Text("123",style: TextStyle(
                  color: Colors.redAccent
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
      itemCount: 10);
}
