import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo/utils/color_util.dart';
import 'package:flutter_demo/wallet/deposit_segment_view.dart';
import 'package:flutter_demo/wallet/widget/deposit_transaction_page.dart';

import 'deposit_navi_bar_widget.dart';
import 'deposit_select_style_page.dart';
import 'deposit_style_page.dart';

class DepositView extends StatefulWidget {
  const DepositView({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _DepositViewState();
}

class _DepositViewState extends State<DepositView> {
  String balance = "10";
  PageController _pageController = PageController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: ColorUtil.hexColor('0x1A1A1C'),
        child: MediaQuery.removePadding(
          removeTop: true,
          context: context,
          child: ListView(
            // physics: const AlwaysScrollableScrollPhysics(),
            children: [
              DepositNaviBar(
                balance: balance,
                height: MediaQuery.of(context).padding.top,
              ),
              DepositSegmentView(
                click: (value) {
                  log("$value");
                  _pageController.jumpToPage(value);
                },
              ),
              Container(
                height: MediaQuery.of(context).size.height,
                child: PageView(
                  physics: NeverScrollableScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  controller: _pageController,
                  children: [
                     DepositStylePage(type: DepositStylePageType.deposit,),
                     DepositStylePage(type: DepositStylePageType.withdraw,),
                     DepositTransactionPage(),
                     DepositStylePage(type: DepositStylePageType.bank,),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
