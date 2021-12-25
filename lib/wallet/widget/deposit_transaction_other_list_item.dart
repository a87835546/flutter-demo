import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo/utils/http_manager.dart';
import 'package:flutter_demo/wallet/entity/transaction_model.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class DepositTransactionOtherListView extends StatefulWidget {
  const DepositTransactionOtherListView({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() =>
      _DepositTransactionOtherListViewState();
}

class _DepositTransactionOtherListViewState
    extends State<DepositTransactionOtherListView> {
  final RefreshController _refreshController =
      RefreshController(initialRefresh: true);
  List<TransactionModel> _lists = [];
  int _pageNum = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _refreshController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SmartRefresher(
      controller: _refreshController,
      onRefresh: () {
        withdrawTransaction();
        setState(() {
          _pageNum = 0;
        });
      },
      child: ListView.builder(
        itemBuilder: (context, index) {
          TransactionModel model = _lists[index];
          return Padding(
            padding: EdgeInsets.only(left: 14, right: 14, bottom: 10),
            child: Container(
              height: 40,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: Color(0xff2C2C2E),
                  borderRadius: BorderRadius.circular(4)),
              child: Padding(
                padding: EdgeInsets.only(left: 10, right: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      height: 30,
                      alignment: Alignment.center,
                      child: Text(
                        model.createTime,
                        style:
                            TextStyle(color: Color(0xffC1C2C4), fontSize: 12),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        height: 30,
                        alignment: Alignment.center,
                        child: Text(
                          "${model.amount}元",
                          style: TextStyle(color: Colors.white, fontSize: 12),
                        ),
                      ),
                    ),
                    Container(
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
                  ],
                ),
              ),
            ),
          );
        },
        itemCount: _lists.length,
      ),
    );
  }

  void withdrawTransaction() {
    HttpManager.get(
            url:
                "/wallet/transaction/getWithdraw?pageSize=10&pageNum=${_pageNum}")
        .then((value) {
      log('transaction value --- >>> $value');
      List<TransactionModel> lists = [];

      if (value['data']['records'] != null) {
        List<dynamic> temp = value['data']['records'];
        temp.forEach((element) {
          lists.add(TransactionModel.fromJson(element));
        });
        setState(() {
          if(_pageNum == 0){ _lists = [];}
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
}
