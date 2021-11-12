import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class Mine extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MinePage();
  }
}

class MinePage extends State<Mine> {
  var _refreshController = RefreshController();
  final List<MimeModel> _list = [
    MimeModel("imgs/images/Transaction-Record@3x.png", "交易记录",
        "imgs/images/iocn-Unfold@3x.png"),
    MimeModel(
        "imgs/images/icon-p@3x.png", "我的优惠", "imgs/images/iocn-Unfold@3x.png"),
    MimeModel("imgs/images/iocn-Unfold@3x.png", "优惠活动",
        "imgs/images/iocn-Unfold@3x.png"),
    MimeModel("imgs/images/icon-help@3x.png", "帮助中心",
        "imgs/images/iocn-Unfold@3x.png"),
    MimeModel("imgs/images/icon-NEW-HELP@3x.png", "新手任务",
        "imgs/images/iocn-Unfold@3x.png"),
    MimeModel("imgs/images/Security-center@3x.png", "安全中心",
        "imgs/images/iocn-Unfold@3x.png"),
    MimeModel("imgs/images/iocn-Unfold@3x.png", "意见反馈",
        "imgs/images/iocn-Unfold@3x.png"),
    MimeModel("imgs/images/iocn-Unfold@3x.png", "下载APP",
        "imgs/images/iocn-Unfold@3x.png"),
    MimeModel("imgs/images/iocn-Unfold@3x.png", "下载APP",
        "imgs/images/iocn-Unfold@3x.png"),
    MimeModel("imgs/images/iocn-Unfold@3x.png", "下载APP",
        "imgs/images/iocn-Unfold@3x.png"),
    MimeModel("imgs/images/iocn-Unfold@3x.png", "下载APP",
        "imgs/images/iocn-Unfold@3x.png"),
    MimeModel("imgs/images/iocn-Unfold@3x.png", "下载APP",
        "imgs/images/iocn-Unfold@3x.png"),
    MimeModel("imgs/images/iocn-Unfold@3x.png", "下载APP",
        "imgs/images/iocn-Unfold@3x.png"),
    MimeModel("imgs/images/iocn-Unfold@3x.png", "下载APP",
        "imgs/images/iocn-Unfold@3x.png"),
    MimeModel("imgs/images/iocn-Unfold@3x.png", "下载APP",
        "imgs/images/iocn-Unfold@3x.png"),
    MimeModel("imgs/images/iocn-Unfold@3x.png", "下载APP",
        "imgs/images/iocn-Unfold@3x.png"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("我的"),
          centerTitle: true,
          automaticallyImplyLeading: true,
          actions: [
            IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.message,
                color: Colors.white,
                size: 20,
              ),
              color: Colors.red,
            ),
            IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.lightbulb_outline_sharp,
                  color: Colors.white,
                  size: 20,
                )),
          ],
        ),
        body: Container(
          decoration: BoxDecoration(
            color: Color(0xff30323f),
          ),
          child: SmartRefresher(
            onRefresh: () async {
              _refreshController.refreshCompleted();
            },
            onLoading: () async {
              _refreshController.loadComplete();
            },
            child: CustomScrollView(
              slivers: [headerView(), listView()],
            ),
            controller: _refreshController,
          ),
        ));
  }

  SliverToBoxAdapter headerView() {
    return SliverToBoxAdapter(
      child: Container(
        color: Colors.red,
        height: 300,
      ),
    );
  }

  SliverToBoxAdapter listView() {
    return SliverToBoxAdapter(
        child: ListView.separated(
            shrinkWrap: true,
            physics: ScrollPhysics(),
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                onTap: () async {},
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    clipBehavior: Clip.antiAlias,
                    child: Container(
                      padding: EdgeInsets.only(left: 5, right: 5),
                      color: Color(0xff2C2C2E),
                      height: 45,
                      child: Row(
                        children: [
                          Container(
                            width: 50,
                            padding: EdgeInsets.only(left: 10),
                            alignment: Alignment.centerLeft,
                            child: Image(
                              image: AssetImage("${_list[index].iconName}"),
                              width: 20,
                              height: 20,
                            ),
                          ),
                          Expanded(
                              child: Container(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              _list[index].title,
                              style: TextStyle(color: Colors.white),
                            ),
                          )),
                          Container(
                            padding: EdgeInsets.only(right: 10),
                            width: 50,
                            alignment: Alignment.centerRight,
                            child: Image(
                              image:
                                  AssetImage("${_list[index].rightIconName}"),
                              width: 20,
                              height: 20,
                            ),
                          ),
                        ],
                      ),
                    )),
              );
            },
            separatorBuilder: (BuildContext context, int index) {
              return Divider(
                height: 5,
                color: Colors.transparent,
              );
            },
            itemCount: _list.length));
  }
}

class MimeModel {
  String iconName = "";
  String title = "";
  String rightIconName = "";

  MimeModel(String _iconName, String _title, String _rightIconName) {
    iconName = _iconName;
    title = _title;
    rightIconName = _rightIconName;
  }
}
