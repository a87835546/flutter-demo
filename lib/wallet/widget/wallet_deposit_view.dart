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
  final List<DepositChannel> channel;

  const WalletDepositView({Key? key, required this.lists,required this.channel}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _WalletDepositViewState();
}

class _WalletDepositViewState extends State<WalletDepositView> {
  int _index = 0;
  DepositChannel? _channel;
  bool show = true;
  String _amount = '0';

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
         DepositSelectTypeView(
          type: DepositStylePageType.deposit,
          click: (index){
            setState(() {
              show = index == 0;
            });
          },

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
                          Visibility(child: DepositStyleView(
                            data: widget.lists,
                            click: (value) {
                              setState(() {
                                _index = value;
                              });
                              log('click deposit style view $value');
                            },
                          ),
                          visible:show ,),
                          DepositChannelView(
                            channels: show == true ? widget.lists[_index].channels : widget.channel,
                            click: (value) {
                              setState(() {
                                _channel = value;
                              });
                              log("DepositChannelView");
                            },
                          ),
                          DepositAmountView(
                            amount: (show == true ? widget.lists[_index].channels : widget.channel).first.fixedAmount,
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
      "amountType": _channel?.depositTypeId.toString(),
      "channelId": _channel?.id.toString(),
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
