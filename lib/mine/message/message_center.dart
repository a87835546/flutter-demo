import 'dart:developer';

import 'package:badges/badges.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo/base_page/base_page.dart';
import 'package:flutter_demo/mine/message/message_activity.dart';
import 'package:flutter_demo/mine/message/message_announcement.dart';
import 'package:flutter_demo/mine/message/message_notifacation.dart';
import 'package:flutter_demo/mine/message/message_app_bar.dart';
import 'package:flutter_demo/utils/color_util.dart';
import 'package:flutter_demo/utils/http_manager.dart';

class MessageCenter extends StatefulWidget {
  final double width;

  const MessageCenter({Key? key, required this.width}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _MessageCenterState();
}

class _MessageCenterState extends State<MessageCenter>
    with SingleTickerProviderStateMixin, BasePage {
  final titles = ['活动', '通知', '公告'];
  final pages = [
    const MessageActivity(),
    MessageNotification(),
    MessageAnnouncement()
  ];
  static const double itemWidth = 30;
  static const double lineScale = 1.2;
  AnimationController? animationController;
  SwiperController _swiperController = SwiperController();
  num x = 0;
  int count = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    animationController = AnimationController(
        duration: const Duration(milliseconds: 300), vsync: this);
    CurvedAnimation animation = CurvedAnimation(
        parent: animationController!, curve: Curves.fastLinearToSlowEaseIn)
      ..addStatusListener((status) {
        log("listen status $status");
      });
    getX(0);
    getUnreadCount();
  }

  @override
  void dispose() {
    super.dispose();
    animationController?.dispose();
  }

  void getX(int index) {
    double width = widget.width;
    num temp = 0;
    num item = width / 3;
    temp = item / 2;
    temp = temp - itemWidth * lineScale / 2;
    temp = item * index + temp;
    setState(() {
      x = temp;
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double top = MediaQuery.of(context).padding.top;
    return Scaffold(
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            MessageAppBar(topPadding: top),
            Container(
              color: const Color(0xff252626),
              child: Column(
                children: [
                  Container(
                      height: 40,
                      width: width,
                      alignment: Alignment.center,
                      child: ListView.builder(
                        itemBuilder: (BuildContext context, int index) {
                          return Container(
                            width: width / titles.length,
                            height: 38,
                            child: ListTile(
                              title: GestureDetector(
                                onTap: () {
                                  getX(index);
                                  log("$x");
                                  _swiperController.move(index);
                                  animationController?.forward();
                                },
                                child: Container(
                                  width: itemWidth,
                                  child: index == 0
                                      ? Badge(
                                          badgeContent: Text("$count"),
                                          position:
                                              BadgePosition(end: 5, bottom: 10),
                                          badgeColor: ColorUtil.mainColor(),
                                          child: Text(
                                            titles[index],
                                            style: const TextStyle(
                                                color: Color(0xffc1c1c4),
                                                fontSize: 14),
                                            textAlign: TextAlign.center,
                                          ),
                                        )
                                      : Text(
                                          titles[index],
                                          style: const TextStyle(
                                              color: Color(0xffc1c1c4),
                                              fontSize: 14),
                                          textAlign: TextAlign.center,
                                        ),
                                ),
                              ),
                            ),
                          );
                        },
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: 3,
                      )),
                  Padding(
                    padding: const EdgeInsets.only(top: 5, bottom: 10),
                    child: Container(
                      width: width,
                      height: 1,
                      child: Stack(
                        children: [
                          Positioned(
                              left: x.toDouble(),
                              child: Container(
                                height: 2,
                                width: itemWidth * lineScale,
                                decoration: BoxDecoration(
                                    gradient: LinearGradient(colors: [
                                  ColorUtil.hexColor('0xA1927F'),
                                  ColorUtil.hexColor('0xFFF1E3')
                                ])),
                              ))
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
            Expanded(
                child: Container(
              child: _createScroll(),
            ))
          ],
        ),
      ),
    );
  }

  Widget _createScroll() {
    return ListView.builder(
      itemBuilder: (context, index) {
        return Container(
          width: widget.width,
          child: Swiper(
              itemCount: titles.length,
              itemBuilder: (context, index) {
                return pages[index];
              },
              controller: _swiperController,
              onTap: (int index) async {
                log("swiper index ---- >>>> ${titles[index]}");
              },
              onIndexChanged: (index) {
                log("index --- >>>$index");
                getX(index);
              }),
        );
      },
      itemCount: titles.length,
      scrollDirection: Axis.horizontal,
    );
  }

  void getUnreadCount() {
    HttpManager.get(url: 'message/getUnreadCount').then((value) {
      log("get unread count $value");
      if (value['code'] == 200) {
        setState(() {
          count = value['data'];
        });
      }
    }).catchError((err) {
      log('get unread count error ${err}');
    });
  }
}
