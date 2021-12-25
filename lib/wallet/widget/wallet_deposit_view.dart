import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter_demo/utils/color_util.dart';
import 'package:flutter_demo/utils/http_manager.dart';
import 'package:flutter_demo/wallet/entity/deposit_style_model.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../deposit_select_style_page.dart';
import '../deposit_style_page.dart';
import 'deposit_amount_view.dart';
import 'deposit_channel_view.dart';
import 'deposit_style_view.dart';

class WalletDepositView extends StatefulWidget {
  final List<DepositStyleModel> lists;

  const WalletDepositView({Key? key, required this.lists}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _WalletDepositViewState();
}

class _WalletDepositViewState extends State<WalletDepositView> {
  int _index = 0;
  int _index1 = 0;
  String _amount = '0';

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        const DepositSelectTypeView(
          type: DepositStylePageType.deposit,
        ),
        widget.lists.isNotEmpty
            ? Padding(
                padding: EdgeInsets.only(left: 15, right: 15),
                child: Container(
                  decoration: BoxDecoration(
                      color: ColorUtil.hexColor('0x2C2C2E'),
                      borderRadius: BorderRadius.circular(5)),
                  child: Padding(
                    padding: EdgeInsets.only(left: 0, right: 0),
                    child: Container(
                      child: Column(
                        children: [
                          DepositStyleView(
                            data: widget.lists,
                            click: (value) {
                              setState(() {
                                _index = value;
                                _index1 = 0;
                              });
                              log('click deposit style view $value');
                            },
                          ),
                          DepositChannelView(
                            model: widget.lists[_index],
                            click: (value) {
                              setState(() {
                                _index1 = value;
                              });
                              log("DepositChannelView");
                            },
                          ),
                          DepositAmountView(
                            amount: widget
                                .lists[_index].channels[_index1].fixedAmount,
                            click: (value) {
                              log('充值金额---->>>> $value');
                              setState(() {
                                _amount = value;
                              });
                              deposit();
                            },
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 10, bottom: 10),
                            child: Container(
                              child: GestureDetector(
                                child: Container(
                                  height: 32,
                                  width: 150,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      border: Border.all(
                                          color: ColorUtil.mainColor(),
                                          width: 1)),
                                  alignment: Alignment.center,
                                  child: Text(
                                    "存款教程",
                                    style:
                                        TextStyle(color: ColorUtil.mainColor()),
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              )
            : Text(""),
      ],
    );
  }

  void deposit() {
    HttpManager.post(url: "/wallet/deposit/deposit", params: {
      "amountType": widget.lists[_index].amountType.toString(),
      "channelId": widget.lists[_index].channels[_index1].id.toString(),
      "money": _amount,
      "typeId": '0'
    }).then((value) {
      log("deposit money result $value");
      if (value['code'] == 200) {
        Fluttertoast.showToast(msg: "充值成功");
      }
    }).catchError((err) {
      log("${err.toString()}");
    });
  }
}
