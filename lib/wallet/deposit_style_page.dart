import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo/utils/color_util.dart';
import 'package:flutter_demo/utils/http_manager.dart';
import 'package:flutter_demo/wallet/entity/deposit_style_model.dart';
import 'package:flutter_demo/wallet/widget/bank_item_view.dart';
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
  List<DepositStyleModel> _list = [];
  @override
  void initState() {
    super.initState();
    getStyle();
  }

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
   int _index = 0;
   int _index1 = 0;
  Widget _createDepositView() {
    return Column(
      children: [
        DepositSelectTypeView(type:  DepositStylePageType.deposit,),
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
                      data: _list,
                      click: (value) {
                        setState(() {
                          _index = value;
                          _index1 = 0;
                        });
                        log('click deposit style view $value');
                      },
                    ),
                    DepositChannelView(
                      model:_list.isNotEmpty? _list[_index]:null,
                      click: (value) {
                        setState(() {
                          _index1 = value;
                        });
                        log("DepositChannelView");
                      },
                    ),
                    DepositAmountView(amount:_list[_index].channels[_index1].fixedAmount,),
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
        DepositSelectTypeView(type: DepositStylePageType.withdraw,),
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
                      data: _list,
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
        DepositSelectTypeView(type: DepositStylePageType.bank,),
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
                  padding: EdgeInsets.only(left: 20),
                  child: BankItemView(),
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
                          "添加银行卡",
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

  void getStyle(){
    HttpManager.get(url: "/wallet/deposit/style").then((value){
      List<DepositStyleModel> lists = [];
      if(value['data'] != null) {
        List<dynamic> temp = value["data"];

        temp.forEach((element) {
          lists.add(DepositStyleModel.fromJson(element));
        });
        setState(() {
          _list = lists;
        });
      }
    }).catchError((err){
      log("${err.toString()}");
    });
  }
}
