import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../suggestion_report.dart';

typedef MineListViewItemClick = Function(MineModel);
class MineListView extends StatefulWidget {
  final MineListViewItemClick click;
  const MineListView({Key? key,required this.click}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _MineListViewState();
}

class _MineListViewState extends State<MineListView> {
  final List<MineModel> _list = [
    MineModel(
        iconName: 'imgs/mine/images/Transaction-Record@3x.png',
        title: '交易记录',
        rightIconName: 'imgs/mine/images/iocn-Unfold@3x.png',
        target: const SuggestionReport()),
    MineModel(
        iconName: 'imgs/mine/images/icon-mine-Promotions@2x.png',
        title: '我的优惠',
        rightIconName: 'imgs/mine/images/iocn-Unfold@3x.png',
        target: const SuggestionReport()),
    MineModel(
      iconName: 'imgs/mine/images/icon-p@3x.png',
      title: '优惠活动',
      rightIconName: 'imgs/mine/images/iocn-Unfold@3x.png',
      target: const SuggestionReport(),
    ),
    MineModel(
        iconName: 'imgs/mine/images/icon-help@3x.png',
        title: '帮助中心',
        rightIconName: 'imgs/mine/images/iocn-Unfold@3x.png',
        target: const SuggestionReport()),
    MineModel(
        iconName: 'imgs/mine/images/icon-NEW-HELP@3x.png',
        title: '新手任务',
        rightIconName: 'imgs/mine/images/iocn-Unfold@3x.png',
        target: const SuggestionReport()),
    MineModel(
        iconName: 'imgs/mine/images/Security-center@3x.png',
        title: '安全中心',
        rightIconName: 'imgs/mine/images/iocn-Unfold@3x.png',
        target: const SuggestionReport()),
    MineModel(
        iconName: 'imgs/mine/images/icon-Feedback@2x.png',
        title: '意见反馈',
        rightIconName: 'imgs/mine/images/iocn-Unfold@3x.png',
        target: const SuggestionReport()),
    MineModel(
        iconName: 'imgs/mine/images/iocn-Unfold@3x.png',
        title: '下载APP',
        rightIconName: 'imgs/mine/images/iocn-Unfold@3x.png',
        target: const SuggestionReport()),
  ];

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
        child: ListView.separated(
            shrinkWrap: true,
            physics: const ScrollPhysics(),
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                onTap: () async {
                  widget.click(_list[index]);
                },
                child: Padding(
                  padding: const EdgeInsets.only(right: 10, left: 10),
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(5),
                      clipBehavior: Clip.antiAlias,
                      child: Container(
                        color: const Color(0xff2C2C2E),
                        height: 40,
                        child: Row(
                          children: [
                            Container(
                              width: 50,
                              padding: const EdgeInsets.only(left: 10),
                              alignment: Alignment.centerLeft,
                              child: Image(
                                image: AssetImage(_list[index].iconName),
                                width: 18,
                                height: 18,
                              ),
                            ),
                            Expanded(
                                child: Container(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                _list[index].title,
                                style: const TextStyle(
                                    color: Color(0xffC1C2C4),
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400),
                              ),
                            )),
                            Container(
                              padding: const EdgeInsets.only(right: 10),
                              width: 50,
                              alignment: Alignment.centerRight,
                              child: Image(
                                image: AssetImage(
                                  _list[index].rightIconName,
                                ),
                                fit: BoxFit.fitHeight,
                                width: 18,
                                height: 18,
                              ),
                            ),
                          ],
                        ),
                      )),
                ),
              );
            },
            separatorBuilder: (BuildContext context, int index) {
              return const Divider(
                height: 5,
                color: Colors.transparent,
              );
            },
            itemCount: _list.length));
  }
}

class MineModel {
  String iconName = '';
  String title = '';
  String rightIconName = '';

  //跳转的目标
  Widget target;

  MineModel(
      {required this.iconName,
      required this.title,
      required this.rightIconName,
      required this.target});

  @override
  String toString() {
    return 'MineModel{iconName: $iconName, title: $title, rightIconName: $rightIconName, target: $target}';
  }
}
