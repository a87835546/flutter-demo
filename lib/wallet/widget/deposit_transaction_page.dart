import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'deposit_transaction_list_item.dart';
import 'deposit_transaction_other_list_item.dart';
import 'deposit_transaction_segment_view.dart';

class DepositTransactionPage extends StatefulWidget {
  const DepositTransactionPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _DepositTransactionPageState();
}

class _DepositTransactionPageState extends State<DepositTransactionPage> {
  final PageController _pageController = PageController();
  List list = [
    '存款',
    '存款1',
    '存款2',
    '存款3',
    '存款4',
  ];

  List pages = [
    DepositTransactionListView(),
    DepositTransactionOtherListView(),
    DepositTransactionListView(),
    DepositTransactionOtherListView(),
    DepositTransactionListView(),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          DepositTransactionSegmentView(
            click: (index) {
              log("$index");
              _pageController.jumpToPage(index);
            },
          ),
          Container(
            height: MediaQuery.of(context).size.height -
                250 -
                MediaQuery.of(context).padding.bottom -
                kBottomNavigationBarHeight,
            child: PageView(
                controller: _pageController,
                children: list.map((e) {
                  return Container(child: pages[list.indexOf(e)]);
                }).toList()),
          )
        ],
      ),
    );
  }
}
