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
                      padding: EdgeInsets.only(left: 10, right: 10, top: 10),
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
          padding: EdgeInsets.only(left: 10),
          child: Container(
            alignment: Alignment.centerLeft,
            child: Text('xxxxx',textAlign: TextAlign.left,style: TextStyle(
              color: Color(0xffC1C2C4)
            ),),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 34, right: 34, bottom: 10, top: 10),
          child: ListView.builder(
              itemBuilder: (BuildContext context, index) {
                return Padding(
                  padding: EdgeInsets.only(bottom: 10),
                  child: GestureDetector(
                    onTap: () {},
                    child: Container(
                      height: 65,
                      decoration: BoxDecoration(
                          color: ColorUtil.hexColor('0x2C2C2E'),
                          borderRadius: BorderRadius.circular(5)),
                      child: Container(
                        child: Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(left: 20),
                              child: Container(
                                height: 34,
                                width: 34,
                                child: Image.asset(
                                    "imgs/deposit/images/wechat@3x.png"),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 5, top: 12),
                              child: Column(
                                children: [
                                  Container(
                                    child: Text(
                                      'xxxxxxxxx',
                                      style: TextStyle(
                                          color: Color(0xffC1C2C4),
                                          fontSize: 14),
                                    ),
                                  ),
                                  Container(
                                    child: Text(
                                      'xxxxxxxxx',
                                      style: TextStyle(
                                          color: Color(0xff919699),
                                          fontSize: 12),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
              itemCount: 3,
              shrinkWrap: true),
        ),
        Padding(
          padding: EdgeInsets.only(left: 0, right: 0),
          child: Container(
            child: Padding(
              padding: EdgeInsets.only(top: 10, bottom: 10),
              child: Container(
                child: GestureDetector(
                  child: Container(
                    height: 40,
                    width: 255,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: [Color(0xff3C3E41),Color(0xff37373A)]
                      ),
                      borderRadius: BorderRadius.circular(5),),
                    alignment: Alignment.center,
                    child:Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 16,
                          width: 16,
                          child: Image.asset("imgs/images/icon-add@3x.png",fit: BoxFit.fitWidth,),
                        ),
                        Padding(padding: EdgeInsets.only(left: 5),child: Text(
                          "存款教程",
                          style: TextStyle(color: Color(0xffC1C2C4)),
                        ),)
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
