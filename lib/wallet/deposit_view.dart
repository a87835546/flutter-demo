import 'dart:developer';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_demo/base_page/base_notification.dart';
import 'package:flutter_demo/utils/app_singleton.dart';
import 'package:flutter_demo/utils/color_util.dart';
import 'package:flutter_demo/utils/http_manager.dart';
import 'package:flutter_demo/wallet/banding_phone_page.dart';
import 'package:flutter_demo/wallet/deposit_segment_view.dart';
import 'package:flutter_demo/wallet/widget/wallet_transaction_page.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'deposit_navi_bar_widget.dart';
import 'deposit_style_page.dart';

class DepositView extends StatefulWidget {
  const DepositView({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _DepositViewState();
}

class _DepositViewState extends State<DepositView> {
  String balance = "10";
  final PageController _pageController = PageController();
  final RefreshController _refreshController = RefreshController();

  @override
  void initState() {
    super.initState();
    getBalance();
  }

  @override
  void dispose() {
    super.dispose();
    HttpManager.cancelRequest();
  }

  @override
  Widget build(BuildContext context) {
    double kContainerHeight = MediaQuery.of(context).size.height -
        MediaQuery.of(context).padding.bottom -
        kBottomNavigationBarHeight -
        kDepositSegmentViewHeight -
        kDepositNaviBarHeight;
    return (AppSingleton.userInfoModel != null &&
            AppSingleton.userInfoModel!.mobile == null)
        ? BandingPhonePage()
        : Scaffold(
            body: Container(
              color: ColorUtil.hexColor('0x1A1A1C'),
              child: MediaQuery.removePadding(
                removeTop: true,
                context: context,
                child: SmartRefresher(
                    controller: _refreshController,
                    header: MaterialClassicHeader(),
                    onRefresh: () {
                      log('refresh');
                      sleep(Duration(milliseconds: 500));
                      _refreshController.refreshCompleted();
                    },
                    child: ListView(
                      physics: const BouncingScrollPhysics(),
                      children: [
                        NotificationListener<BaseNotification>(
                          child: DepositNaviBar(
                            balance: balance,
                            height: MediaQuery.of(context).padding.top,
                            refresh: () {
                              getBalance();
                            },
                          ),
                          onNotification: (noti) {
                            log("接收到的通知内容---->>>>> ${noti.identify}");
                            log("接收到的通知内容---->>>>> ${BaseNotificationIdentify.refreshAmount.index}");
                            if (noti.identify ==
                                BaseNotificationIdentify
                                    .refreshAmount.name) {
                              getBalance();
                            }
                            return true;
                          },
                        ),
                        DepositSegmentView(
                          click: (value) {
                            SystemChannels.textInput
                                .invokeMethod('TextInput.hide');
                            log("$value");
                            _pageController.jumpToPage(value);
                          },
                        ),
                        Container(
                          height: kContainerHeight,
                          child: PageView(
                            physics: const NeverScrollableScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                            controller: _pageController,
                            children: [
                              DepositStylePage(
                                type: DepositStylePageType.deposit,
                              ),
                              DepositStylePage(
                                type: DepositStylePageType.withdraw,
                              ),
                              DepositTransactionPage(
                                  height: kContainerHeight),
                              DepositStylePage(
                                type: DepositStylePageType.bank,
                              ),
                            ],
                          ),
                        )
                      ],
                    )),
              ),
            ),
          );
  }

  void getBalance() {
    HttpManager.get(url: "pay/checkBalance").then((value) {
      log("get balance $value");
      if (value['data'] != null && mounted) {
        setState(() {
          balance = value['data']['balance'];
        });
        Fluttertoast.showToast(msg: "刷新成功", gravity: ToastGravity.TOP);
      }
    }).catchError((err) {
      Fluttertoast.showToast(
          msg: "刷新失败" + err.toString(), gravity: ToastGravity.CENTER);
    });
  }
}
