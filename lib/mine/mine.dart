import 'dart:developer';

import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo/base_page/base_page.dart';
import 'package:flutter_demo/login&register/login.dart';
import 'package:flutter_demo/login&register/register.dart';
import 'package:flutter_demo/mine/message_center.dart';
import 'package:flutter_demo/mine/widget/mine_list_view.dart';
import 'package:flutter_demo/mine/widget/user_ifno_progress_view.dart';
import 'package:flutter_demo/mine/widget/user_info_button.dart';
import 'package:flutter_demo/mine/widget/user_info_mine_wallet_view.dart';
import 'package:flutter_demo/mine/widget/user_info_view.dart';
import 'package:flutter_demo/utils/app_singleton.dart';
import 'package:flutter_demo/utils/http_manager.dart';
import 'package:logger/logger.dart';


import 'package:pull_to_refresh/pull_to_refresh.dart';
import "dart:math";

import 'model/user_info_model.dart';
import 'model/user_sign_info_model.dart';
import 'model/user_vip_info_model.dart';

class Mine extends StatefulWidget {
  const Mine({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _MinePageState();
  }
}
var logger = Logger(
  printer: PrefixPrinter(
    PrettyPrinter(
        stackTraceBeginIndex: 5,
        methodCount: 1
    ),
  ),
  filter: ProductionFilter(),
);

class _MinePageState extends State<Mine> with BasePage {
  final _refreshController = RefreshController();

  /// 用户消息
  UserInfoModel? _userInfoModel;

  /// 签到model
  UserSignInfoModel? _signInfoModel;

  /// vip model
  UserVipInfoModel? _vipInfoModel;

  /// 余额
  late int _balance = 0;

  /// 消息中心的未读消息数量
  late int _unreadCount = 0;

  /// 是否已经跳转到我的登陆的页面
  late bool isJump = false;

  /// 记录接口是否请求完成
  late int _count = 0;

  @override
  void initState() {

    isJump = false;
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Widget error = setNetError(context);
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            '我的',
            style: TextStyle(
                fontSize: 18, color: Colors.white, fontWeight: FontWeight.w400),
          ),
          backgroundColor: const Color(0xff252626),
          centerTitle: true,
          automaticallyImplyLeading: true,
          actions: [
            Badge(
                badgeColor: const Color(0xffD3C294),
                badgeContent: Container(
                  color: const Color(0xffD3C294),
                  width: 11,
                  height: 11,
                  alignment: Alignment.center,
                  child: Text(
                    _unreadCount.toString(),
                    style: const TextStyle(
                        color: Color(0xff44454B),
                        fontSize: 9,
                        fontWeight: FontWeight.w400),
                    textAlign: TextAlign.center,
                  ),
                ),
                showBadge: _unreadCount > 0 ? true : false,
                borderRadius: BorderRadius.circular(7.5),
                position: const BadgePosition(bottom: 10, end: -10),
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      isJump = false;
                    });
                    if(checkLogin()){
                      // Navigator.pushNamed(context, 'message_center');
                      Navigator.push(context, MaterialPageRoute(builder: (BuildContext context){
                        return MessageCenter(width: MediaQuery.of(context).size.width);
                      }));
                    }else{
                      goToLogin(context);
                    }
                  },
                  child: Image.asset(
                    "imgs/mine/images/icon-chat@3x.png",
                    width: 40,
                    height: 24,
                  ),
                )),
            IconButton(
                onPressed: () {

                },
                icon: Image.asset(
                  "imgs/mine/images/icon-customer-service@3x.png",
                  width: 40,
                  height: 24,
                )),
          ],
        ),
        body:show?error: Container(
          decoration: const BoxDecoration(
            // color: Color(0xff30323f),
            color: Colors.transparent,
            image: DecorationImage(
                image: AssetImage("imgs/mine/images/bg@3x.png"),
                fit: BoxFit.fill),
          ),
          child: SmartRefresher(
            onRefresh: () async {
              getData();
            },
            child: CustomScrollView(
              slivers: [headerView(), const MineListView()],
            ),
            controller: _refreshController,
          ),
        ));
  }

  SliverToBoxAdapter headerView() {
    return SliverToBoxAdapter(
      child: Container(
        color: const Color(0xff252626),
        height: 333 + 28,
        child: Column(
          children: [
            Center(
              child: Container(
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(
                            "imgs/mine/images/background-mig@3x.png"),
                        fit: BoxFit.fill),
                    color: Colors.transparent),
                height: 190,
                child: Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Row(
                    // mainAxisAlignment: MainAxisAlignment.end,
                    // mainAxisSize: MainAxisSize.max,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(left: 20, right: 10),
                        width: 36,
                        height: 16,
                        child: _createVip(_vipInfoModel?.accountLevel ?? 0,true),
                      ),
                      Expanded(
                          child: Container(
                            color: Colors.transparent,
                            child: OverflowBox(
                              alignment: Alignment.topCenter,
                              maxHeight: 230,
                              maxWidth: 236,
                              minHeight: 190,
                              minWidth: 236,
                              child: Stack(
                                clipBehavior: Clip.antiAlias,
                                alignment: Alignment.topCenter,
                                children: [
                                  Container(
                                    color: Colors.transparent,
                                    child: SizedBox(
                                      height: 230,
                                      width: 236,
                                      child: Transform.rotate(
                                        angle: pi * 1.25,
                                        child: const CircularProgressIndicator(
                                            value: 0.8,
                                            backgroundColor: Colors.transparent,
                                            valueColor: AlwaysStoppedAnimation(
                                                Color(0xffD3C294))),
                                      ),
                                    ),
                                  ),
                                  UserInfoView(infoModel: AppSingleton.userInfoModel,clickEdit: (){
                                    // showToast("点击编辑用户名");
                                  },),
                                  // _createVipInfo(),
                                ],
                              ),
                            ),
                          )),
                      Container(
                        margin: const EdgeInsets.only(left: 10, right: 20),
                        width: 36,
                        height: 16,
                        child: _createVip((_vipInfoModel?.accountLevel??0)+1,false),
                      )
                    ],
                  ),
                ),
              ),
            ),
            Transform.translate(
              offset: const Offset(0, -10),
              child: Container(
                height: 171,
                margin: const EdgeInsets.only(top: 0),
                child: Container(
                  height: 148,
                  decoration: const BoxDecoration(
                      color: Colors.transparent,
                      image: DecorationImage(
                          image: AssetImage(
                              "imgs/mine/images/background-mig-up@3x.png"),
                          fit: BoxFit.fill)),
                  child: Column(
                    children: [
                      _createVipInfo(_vipInfoModel?.accountLevel??0),
                      MineWalletView(balance: _balance),
                      _createVipTaskView(),
                      _createBtn()
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _createVip(int vipLevel, bool isSelected) {
    return ClipRRect(
        borderRadius: BorderRadius.circular(8),
        clipBehavior: Clip.antiAlias,
        child: Container(
          color: isSelected ? const Color(0xffD0C3A6) : const Color(0xff26262B),
          alignment: Alignment.center,
          child: Text(
            "VIP$vipLevel",
            style: TextStyle(
                color: isSelected
                    ? const Color(0xff3A3A3A)
                    : const Color(0xffC1C2C4),
                fontSize: 10,
                fontWeight: FontWeight.w400),
          ),
        ));
  }

  Widget _createVipInfo(int vipLevel) {
    return Container(
      child: GestureDetector(
          onTap: () {
            // showToast("点击vip详情");
          },
          child: ClipRRect(
            borderRadius: BorderRadius.circular(14),
            child: Container(
              width: 135,
              height: 28,
              decoration: const BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Color(0xffEAEAEA),
                        Color(0xffE0E0E0),
                      ])),
              alignment: Alignment.center,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "VIP$vipLevel详情",
                    style: TextStyle(color: Color(0xff3A3A3A), fontSize: 14),
                  ),
                  Image.asset(
                    "imgs/mine/images/icon-Expand-all@3x.png",
                    width: 16,
                    height: 16,
                  )
                ],
              ),
            ),
          )),
    );
  }

  Widget _createVipTaskView() {
    return Container(
      height: 60,
      color: Colors.transparent,
      padding: const EdgeInsets.only(left: 28),
      child: Padding(
        padding: const EdgeInsets.only(right: 35),
        child: Column(
          children: [
            UserInfoProgressView(signInfoModel: _signInfoModel),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "签到满7日另送礼金28元",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w400),
                ),
                UserInfoButton(
                    title: const Text(
                      "上上签到规则",
                      style: TextStyle(
                          color: Color(0xffD0C3A6),
                          fontSize: 12,
                          fontWeight: FontWeight.w400),
                    ),
                    iconName: "imgs/mine/images/icon-vip-task-arrow@3x.png",
                    width: 100,
                    click: () {
                      // showToast("上上签到规则");
                    }),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _createBtn() {
    return Container(
      // widthFactor: 1,
      margin: const EdgeInsets.only(top: 10),
      color: Colors.transparent,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(14),
        child: Container(
          height: 28,
          width: 180,
          alignment: Alignment.center,
          decoration: const BoxDecoration(
              color: Colors.white,
              gradient: LinearGradient(colors: [
                Color(0xffFFECC3),
                Color(0xffE4D2B2),
              ])),
          child: GestureDetector(
            onTap: () {
              // showToast("点击签到");
            },
            child: const Text(
              "点击签到",
              style: TextStyle(
                  color: Color(0xff3A3A3A),
                  fontSize: 14,
                  fontWeight: FontWeight.w400),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Future getData() async {
    setState(() {
      isJump = false;
    });
    getMessageUnread();
    getBalance();
    getUserInfo();
    getVipInfo();
    return isJump;
  }

  void finishedRequesting(){
    setState(() {
      _count = 0;
    });
    _refreshController.refreshCompleted();
  }

  ///获取未读消息
  void getMessageUnread() async {
    logger.i("future complete 1 ");
    HttpManager.get(url:"/message/unreadCount?terminal=1&msgType=0")
        .then((result) {
      logger.i("get message unread result :$result");
      if(determineRequest(result)){
        goToLogin(context);
        return;
      }
      try {
        setState(() {
          if (result['code'] == 200 && result['data'] != null) {
            _unreadCount = result['data']["count"];
          } else {
            _unreadCount = 0;
          }
        });
      } catch (err) {
        logger.i("parser user unread message count err:${err.toString()}");
      } finally {
        if (result['code'] == 401) {
          goToLogin(context);
        }
      }
    }).whenComplete(() {
      setState(() {
        _count = _count + 1;
      });
      if (_count == 4) {
        finishedRequesting();
      }
      logger.i("when complete2  count :$_count");
    });
  }

  void getUserInfo() async {
    logger.i("future complete 4 ");

    HttpManager.get(url:"/activity/signInfo?terminal=1")
        .then((result) {
      logger.i("get user sign info result :$result");
      if(determineRequest(result)){
        goToLogin(context);
        return;
      }
      try {
        UserSignInfoModel signInfoModel = UserSignInfoModel.fromJson(result['data']);
        logger.i("get user sign info model :$signInfoModel");

        setState(() {
          _signInfoModel = signInfoModel;
        });
      } catch (err) {
        logger.i("parser user sign info err:${err.toString()}");
      } finally {
        if (result['code'] == 401) {
          goToLogin(context);
        }
      }
    }).whenComplete(() {
      setState(() {
        _count = _count + 1;
      });
      if (_count == 4) {
        finishedRequesting();
      }
      logger.i("when complete2  count :$_count");
    });
  }

  void getVipInfo() {
    HttpManager.get(url:"/activity/vipInfo?=1&terminal=1")
        .then((result) {
      logger.i("get user vip info result :${result.runtimeType}");
      if(determineRequest(result)){
        setState(() {
          show = !show;
          errorTitle = "测试。。。。。。。";
        });
        // goToLogin(context);
        logger.i("get user vip info");
        return;
      }
      try {
        UserVipInfoModel vipInfoModel = UserVipInfoModel.jsonToObject(result['data']);
        setState(() {
          _vipInfoModel = vipInfoModel;
        });
      } catch (err) {
        logger.i("parser user vip info err:${err.toString()}");
      } finally {
        if (result['code'] == 401) {
          goToLogin(context);
        }
      }
    }).whenComplete(() {
      setState(() {
        _count = _count + 1;
      });
      if (_count == 4) {
        finishedRequesting();
      }
      logger.i("when complete2  count :$_count");
    });
  }

  void getBalance() {
    logger.i("future complete 2 ");

    HttpManager.get(url:"/pay/checkBalance?terminal=1").then((result) {
      logger.i("get balance info result : $result");
      if(determineRequest(result)){
        goToLogin(context);
        return;
      }
      try {
        setState(() {
          _balance = result['balance'];
        });
      } catch (err) {
        logger.i("parser user sign info err:${err.toString()}");
      } finally {
        if (result['code'] == 401) {
          goToLogin(context);
        }
      }
    }).whenComplete(() {
      setState(() {
        _count = _count + 1;
      });
      if (_count == 4) {
        finishedRequesting();
      }
      logger.i("when complete2  count :$_count");
    });
  }

  @override
  void goToLogin(BuildContext context) async {
    if (!isJump) {
      setState(() {
        isJump = true;
      });
      final result =
      await Navigator.push(context, MaterialPageRoute(builder: (context) {
        return const LoginPage();
      }));
      if(result == true){
        getData();
      }
    }
  }

}
