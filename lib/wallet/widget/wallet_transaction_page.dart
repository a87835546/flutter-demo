import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'deposit_transaction_list_item.dart';
import 'deposit_transaction_other_list_item.dart';
import 'deposit_transaction_segment_view.dart';

class DepositTransactionPage extends StatefulWidget {
  final double height ;
  const DepositTransactionPage({Key? key,required this.height}) : super(key: key);

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

  List pages =const [
    DepositTransactionListView(type: 0,),
    DepositTransactionOtherListView(),
    DepositTransactionListView(type: 1,),
    DepositTransactionListView(type: 2,),
    DepositTransactionListView(type: 3,),
  ];
  int _index = 0;

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double height = widget.height - kDepositTransactionSegmentViewHeight;
    return  Column(
      children: [
        DepositTransactionSegmentView(
          index: _index,
          click: (index) {
            log("$index");
            _pageController.jumpToPage(index);
          },
        ),
        Container(
          height:height ,
          child: PageView(
              controller: _pageController,
              onPageChanged: (value){
                setState(() {
                  _index = value;
                });
              },
              children: list.map((e) {
                return Container(
                    child: pages[list.indexOf(e)]);
              }).toList()),
        )
      ],
    );
  }
}
