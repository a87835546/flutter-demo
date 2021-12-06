import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo/utils/color_util.dart';
import 'package:flutter_demo/wallet/widget/deposit_amount_view.dart';
import 'package:flutter_demo/wallet/widget/deposit_channel_view.dart';
import 'package:flutter_demo/wallet/widget/deposit_input_view.dart';
import 'package:flutter_demo/wallet/widget/deposit_style_view.dart';

import 'deposit_select_style_page.dart';

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
    switch (widget.type) {
      case DepositStylePageType.withdraw:
        return _createWithdrawView();
      case DepositStylePageType.bank:
        {
          return _createBankView();
        }
      case DepositStylePageType.deposit:
        {
          return _createDepositView();
        }
    }
  }

  Widget _createDepositView() {
    return Column(
      children: [
        DepositSelectTypeView(),
        Padding(
          padding: EdgeInsets.only(left: 15, right: 15),
          child: Container(
            // height: 490,
            decoration: BoxDecoration(
                color: ColorUtil.hexColor('0x2C2C2E'),
                borderRadius: BorderRadius.circular(5)),
            child: Padding(
              padding: EdgeInsets.only(left: 0, right: 0),
              child: Container(
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    DepositStyleView(
                      click: (value) {
                        log('click deposit style view $value');
                      },
                    ),
                    DepositChannelView(
                      click: (value) {
                        log("DepositChannelView");
                      },
                    ),
                    const DepositAmountView(),
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
                                    color: ColorUtil.mainColor(), width: 1)),
                            alignment: Alignment.center,
                            child: Text(
                              "存款教程",
                              style: TextStyle(color: ColorUtil.mainColor()),
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
        ),
      ],
    );
  }

  Widget _createWithdrawView() {
    return Column(
      children: [
        DepositSelectTypeView(),
        Padding(
          padding: EdgeInsets.only(left: 15, right: 15),
          child: Container(
            // height: 490,
            decoration: BoxDecoration(
                color: ColorUtil.hexColor('0x2C2C2E'),
                borderRadius: BorderRadius.circular(5)),
            child: Padding(
              padding: EdgeInsets.only(left: 0, right: 0),
              child: Container(
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    DepositStyleView(
                      click: (value) {
                        log('click deposit style view $value');
                      },
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 10, right: 10,top: 10),
                      child: DepositInputView(
                        placeholder: '请输入金额',
                        tips: '限额100000',
                        prefixTitle: '￥',
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 10, bottom: 10),
                      child: Container(
                        child: GestureDetector(
                          child: Container(
                            height: 32,
                            width: 255,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(
                                    color: ColorUtil.mainColor(), width: 1)),
                            alignment: Alignment.center,
                            child: Text(
                              "下一步",
                              style: TextStyle(color: ColorUtil.mainColor()),
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
        ),
      ],
    );
  }

  Widget _createBankView() {
    return Column(
      children: [
        DepositSelectTypeView(),
        Padding(
          padding: EdgeInsets.only(left: 15, right: 15),
          child: Container(
            // height: 490,
            decoration: BoxDecoration(
                color: ColorUtil.hexColor('0x2C2C2E'),
                borderRadius: BorderRadius.circular(5)),
            child: Padding(
              padding: EdgeInsets.only(left: 0, right: 0),
              child: Container(
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
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
                                    color: ColorUtil.mainColor(), width: 1)),
                            alignment: Alignment.center,
                            child: Text(
                              "存款教程",
                              style: TextStyle(color: ColorUtil.mainColor()),
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
        ),
      ],
    );
  }
}
