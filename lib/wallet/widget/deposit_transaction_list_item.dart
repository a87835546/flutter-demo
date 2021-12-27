import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo/base_page/base_page.dart';
import 'package:flutter_demo/utils/http_manager.dart';
import 'package:flutter_demo/wallet/entity/transaction_model.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

/// 交易记录中的存款
class DepositTransactionListView extends StatefulWidget {
  /// 交易记录类型
  final int type;

  const DepositTransactionListView({Key? key, required this.type})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _DepositTransactionListViewState();
}

class _DepositTransactionListViewState extends State<DepositTransactionListView>
    with BasePage {
  final RefreshController _refreshController = RefreshController(
    initialRefresh: false,
  );
  List<TransactionModel> _lists = [];
  int _pageNum = 1;

  @override
  void initState() {
    super.initState();
    initData(widget.type);
  }
  void initData(int type){
    switch (type) {
      case 0:
        depositTransaction();
        break;
      case 1:
        depositTransaction1();
        break;
      case 2:
        depositTransaction2();
        break;
      case 3:
        depositTransaction3();
        break;
      default:
        break;
    }
  }


  @override
  void dispose() {
    _refreshController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SmartRefresher(
      controller: _refreshController,
      physics: const BouncingScrollPhysics(),
      enablePullUp: true,
      enablePullDown: true,
      header: WaterDropHeader(),
      footer: ClassicFooter(
        loadStyle: LoadStyle.ShowWhenLoading,
      ),
      child: ListView.builder(
        itemBuilder: (context, index) {
          TransactionModel model = _lists[index];
          return Padding(
            padding: EdgeInsets.only(left: 14, right: 14, bottom: 10),
            child: Container(
              height: 60,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: Color(0xff2C2C2E),
                  borderRadius: BorderRadius.circular(4)),
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 10, right: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          height: 30,
                          alignment: Alignment.center,
                          child: Text(
                            "${model.createTime}",
                            style: const TextStyle(
                                color: Color(0xffC1C2C4), fontSize: 12),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            height: 30,
                            alignment: Alignment.centerRight,
                            child: Text(
                              "${model.amount}元",
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 12),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 10, right: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          height: 30,
                          alignment: Alignment.center,
                          child: Text(
                            widget.type == 3 || widget.type == 2 ? "其他":"${model.description}",
                            style: const TextStyle(
                                color: Color(0xffC1C2C4), fontSize: 12),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            height: 30,
                            alignment: Alignment.centerRight,
                            child: Text(
                              "${model.resultType == true ? "成功" : " 失败"}",
                              style: TextStyle(
                                  color: model.resultType == true
                                      ? Color(0xff26C97F)
                                      : Colors.redAccent,
                                  fontSize: 12),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
        itemCount: _lists.length,
      ),
      onRefresh: () {
        setState(() {
          _pageNum = 1;
          _refreshController.resetNoData();
          _lists = [];
        });
        initData(widget.type);
        log("refresh");
      },
      onLoading: () {
        log("loading more");
        setState(() {
          _pageNum++;
        });
        initData(widget.type);
      },
    );
  }

  void depositTransaction() {
    HttpManager.get(
            url: "/wallet/transaction/deposit?pageSize=10&pageNum=${_pageNum}")
        .then((value) {
      log('transaction value --- >>> $value');
      List<TransactionModel> lists = [];

      if (value['data']['records'] != null) {
        List<dynamic> temp = value['data']['records'];
        temp.forEach((element) {
          lists.add(TransactionModel.fromJson(element));
        });
        setState(() {
          _lists.addAll(lists);
        });
        if (lists.isEmpty) {
          _refreshController.loadNoData();
        } else {
          _refreshController.refreshCompleted();
          _refreshController.loadComplete();
        }
      }
    }).catchError((err) {
      log("${err.toString()}");
    });
  }

  void depositTransaction1() {
    HttpManager.get(
            url:
                "/wallet/transaction/getCoupon?pageSize=10&pageNum=${_pageNum}")
        .then((value) {
      log('transaction value --- >>> $value');
      List<TransactionModel> lists = [];

      if (value['data']['records'] != null) {
        List<dynamic> temp = value['data']['records'];
        temp.forEach((element) {
          lists.add(TransactionModel.fromJson(element));
        });
        setState(() {
          _lists.addAll(lists);
        });
        if (lists.isEmpty) {
          _refreshController.loadNoData();
        } else {
          _refreshController.refreshCompleted();
          _refreshController.loadComplete();
        }
      }
    }).catchError((err) {
      log("${err.toString()}");
    });
  }

  void depositTransaction2() {
    HttpManager.get(
        url:
        "/wallet/transaction/getPrize?pageSize=10&pageNum=${_pageNum}")
        .then((value) {
      log('transaction value --- >>> $value');
      List<TransactionModel> lists = [];

      if (value['data']['records'] != null) {
        List<dynamic> temp = value['data']['records'];
        temp.forEach((element) {
          lists.add(TransactionModel.fromJson(element));
        });
        setState(() {
          _lists.addAll(lists);
        });
        if (lists.isEmpty) {
          _refreshController.loadNoData();
        } else {
          _refreshController.refreshCompleted();
          _refreshController.loadComplete();
        }
      }
    }).catchError((err) {
      log("${err.toString()}");
    });
  }
  void depositTransaction3(){
    HttpManager.get(
        url:
        "/wallet/transaction/getAmount?pageSize=10&pageNum=${_pageNum}")
        .then((value) {
      log('transaction value --- >>> $value');
      List<TransactionModel> lists = [];

      if (value['data']['records'] != null) {
        List<dynamic> temp = value['data']['records'];
        temp.forEach((element) {
          lists.add(TransactionModel.fromJson(element));
        });
        setState(() {
          _lists.addAll(lists);
        });
        if (lists.isEmpty) {
          _refreshController.loadNoData();
          _refreshController.refreshCompleted();
        } else {
          _refreshController.refreshCompleted();
          _refreshController.loadComplete();
        }
      }
    }).catchError((err) {
      log("${err.toString()}");
    });
  }
}
