import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo/utils/http_manager.dart';
import 'package:flutter_demo/wallet/entity/deposit_style_model.dart';
import 'package:flutter_demo/wallet/widget/wallet_bank_view.dart';
import 'package:flutter_demo/wallet/widget/wallet_deposit_view.dart';
import 'package:flutter_demo/wallet/widget/wallet_withdraw_view.dart';

import 'entity/bank_model.dart';

enum DepositStylePageType {
  deposit,
  withdraw,
  bank,
}

class DepositStylePage extends StatefulWidget {
  final DepositStylePageType type;

  const DepositStylePage({Key? key, required this.type}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _DepositStylePageState();
}

class _DepositStylePageState extends State<DepositStylePage> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getDatas(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasError || snapshot.data == null) {
          log("error ---->>>> ${snapshot.error}");
          return Text("");
        } else {
          // log("data ---->>>> ${snapshot.data}");
          List temp = snapshot.data;
          List<DepositStyleModel> list =
              temp.first as List<DepositStyleModel>;
          List<Banks> banks = temp[1] as List<Banks>;
          List<DepositChannel> channels = temp.last as List<DepositChannel>;
          switch (widget.type) {
            case DepositStylePageType.withdraw:
              return WalletWithdrawView(
                lists: list,
                banks: banks,
              );
            case DepositStylePageType.bank:
              return const WalletBankView();
            case DepositStylePageType.deposit:
              return WalletDepositView(
                lists: list,
                channel: channels,
              );
          }
        }
      },
    );
  }

  Future getDatas() async {
    return Future.wait([getStyle(), getList(),getStyle2()]);
  }

  Future<List<DepositStyleModel>> getStyle() async {
    var result = await HttpManager.get(url: "/wallet/style");
    // log('result --->>>>> $result');
    List<DepositStyleModel> lists = [];
    if (result['data'] != null) {
      List<dynamic> temp = result["data"];
      temp.forEach((element) {
        lists.add(DepositStyleModel.fromJson(element));
      });
    }
    return lists;
  }

  Future<List<Banks>> getList() async {
    final result = await HttpManager.get(url: "wallet/bank/list");
    // log("get bank list --- >>> $result");
    if (result['data'] != null) {
      List<Banks> banks = [];
      List temp = result['data'];
      temp.forEach((element) {
        banks.add(Banks.fromJson(element));
      });
      return banks;
    }
    return [];
  }

  Future<List<DepositChannel>> getStyle2() async {
    var result = await HttpManager.get(url: "wallet/style?type=1");
    // log('result --->>>>> $result');
    List<DepositChannel> lists = [];
    if (result['data'] != null) {
      List<dynamic> temp = result["data"];
      temp.forEach((element) {
        lists.add(DepositChannel.fromJson(element));
      });
    }
    return lists;
  }
}
