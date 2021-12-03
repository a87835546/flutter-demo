import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo/base_page/base_page.dart';
import 'package:flutter_demo/mine/message/message_entity.dart';
import 'package:flutter_demo/utils/color_util.dart';
import 'package:flutter_demo/utils/http_manager.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class MessageActivity extends StatefulWidget {
  const MessageActivity({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _MessageActivityState();
}

class _MessageActivityState extends State<MessageActivity> with BasePage {
  RefreshController refreshController = RefreshController();
  List _message = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
          ColorUtil.hexColor("0x1A1A1C"),
          ColorUtil.hexColor("0x202123")
        ])),
        child: SmartRefresher(
          controller: refreshController,
          onRefresh: () {
            log("下拉刷新");
            getData();
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
          Message message = _message[index];
          return GestureDetector(
            onTap: () async{
              log("activity page click cell index : $index");
              readMessage(message.id);
            },
            child: Container(
              height: 50,
              color: Colors.transparent,
              child: Container(
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 5, right: 5, top: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "${message.title}",
                            style: _style(),
                          ),
                          Text("${message.time}", style: _style()),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 5, right: 5, top: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("${message.textContent}", style: _style()),
                          Text("${message.date}", style: _style()),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        },
        separatorBuilder: (context, index) {
          return Divider(
            color: Colors.indigoAccent,
          );
        },
        itemCount: _message.length);
  }

  TextStyle _style() {
    return TextStyle(color: ColorUtil.mainTitleColor());
  }

  @override
  Future getData() async {
    HttpManager.get(url: 'message/info?messageType=0').then((value) {

      if (value['code'] == 200 && value['data'].runtimeType == [].runtimeType) {
        List list = value['data'] as List;
        List<Message> temp = [];
        for (var element in list) {
          temp.add(Message.fromJson(element));
        }
        setState(() {
          _message = temp;
        });
      }
    }).catchError((err) {
      log("err --->>> $err");
    }).whenComplete(() {
      log("complete");
    });
    return super.getData();
  }

  void readMessage(int id) async{
     await HttpManager.get(url: "message/read?messageId=$id").then((value){
       if (value == true){
         log("消息已读");
       }
     }).catchError((error){
       log("read message error $error");
    });
  }
}
