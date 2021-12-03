import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo/utils/color_util.dart';
import 'package:flutter_demo/wallet/deposit_segment_view.dart';

import 'deposit_navi_bar_widget.dart';

class DepositView extends StatefulWidget {
  const DepositView({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _DepositViewState();
}

class _DepositViewState extends State<DepositView> {
  String balance = "10";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.redAccent,
        child: MediaQuery.removePadding(
          removeTop: true,
          context: context,
          child: ListView(
            physics: const AlwaysScrollableScrollPhysics(),
            children: [
              DepositNaviBar(
                balance: balance,
                height: MediaQuery.of(context).padding.top,
              ),
              DepositSegmentView(click: (value){
                log("$value");
              },),
            ],
          ),
        ),
      ),
    );
  }

}
