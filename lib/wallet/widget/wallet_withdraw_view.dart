import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo/base_page/base_notification.dart';
import 'package:flutter_demo/mine/widget/user_info_button.dart';
import 'package:flutter_demo/utils/color_util.dart';
import 'package:flutter_demo/utils/http_manager.dart';
import 'package:flutter_demo/wallet/bind_bank_card_view.dart';
import 'package:flutter_demo/wallet/entity/bank_model.dart';
import 'package:flutter_demo/wallet/entity/deposit_style_model.dart';
import 'package:flutter_demo/wallet/widget/withdraw_select_bank_view.dart';

import '../deposit_select_style_page.dart';
import '../deposit_style_page.dart';
import 'deposit_input_view.dart';
import 'deposit_style_view.dart';

/// 充值的渠道
enum DepositSelectType {
  /// 人民币
  rmb,

  /// 虚拟货币
  cr,

  ///支付宝
  alipay,
}

extension DepositSelectTypeTarget on DepositSelectType {
  Widget get target {
    switch (this) {
      case DepositSelectType.rmb:
        return BindBankCardView();
      case DepositSelectType.cr:
        return BindBankCardView();
      default:
        return BindBankCardView();
    }
  }
}

///取款页面
class WalletWithdrawView extends StatefulWidget {
  final List<DepositStyleModel> lists;
  final List<Banks> banks;

  const WalletWithdrawView({Key? key, required this.lists,required this.banks}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _WalletWithdrawViewState();
}

class _WalletWithdrawViewState extends State<WalletWithdrawView> {
  DepositSelectType _withdrawSelected = DepositSelectType.rmb;
  var amount;
  int _index = 0;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      child: ListView(
        physics: NeverScrollableScrollPhysics(),
        children: [
          DepositSelectTypeView(
            type: DepositStylePageType.withdraw,
            click: (index){},
          ),
          Padding(
            padding: EdgeInsets.only(left: 15, right: 15),
            child: Container(
              decoration: BoxDecoration(
                color: ColorUtil.hexColor('0x2C2C2E'),
                  borderRadius: BorderRadius.circular(5)),
              child: Padding(
                padding: EdgeInsets.only(left: 0, right: 0),
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(bottom: 15, top: 0),
                        child: WithdrawAddBankView( list: widget.banks,
                          clickAdd: () {},clickItem: (index){
                            setState(() {
                              _index = index;
                            });
                          },
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 10),
                        child: Row(
                          children: [
                            Container(
                              height: 20,
                              width: 2,
                              color: ColorUtil.mainColor(),
                            ),
                            Padding(padding: EdgeInsets.only(left: 10)),
                            Text(
                              "充值方式",
                              style: TextStyle(color: Colors.white),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 10, right: 10, top: 10),
                        child: DepositInputView(
                          placeholder: '请输入金额',
                          tips: '限额100000',
                          prefixTitle: '￥',
                          didChange: (value){
                            setState(() {
                              amount = value;
                            });
                          },
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 10, left: 15, right: 15),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "今日提现次数: 0/10",
                                  style: TextStyle(
                                      color: ColorUtil.mainColor(), fontSize: 12),
                                ),
                                Text(
                                  "提现金额: 0/300000",
                                  style: TextStyle(
                                      color: ColorUtil.mainColor(), fontSize: 12),
                                ),
                              ],
                            ),
                            Visibility(
                              child: Padding(
                                padding: EdgeInsets.only(top: 5),
                                child: Container(
                                  width: double.infinity,
                                  child: Text(
                                    "当前参考汇率：1 USDT ≈ 6.4769 CNY",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 12),
                                    textAlign: TextAlign.left,
                                  ),
                                ),
                              ),
                              visible: _withdrawSelected != DepositSelectType.rmb,
                            ),
                            Visibility(
                              child: Padding(
                                padding: EdgeInsets.only(top: 5, bottom: 5),
                                child: Container(
                                  width: double.infinity,
                                  child: Text(
                                    "预计到账金额：0 CNY",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 12),
                                    textAlign: TextAlign.left,
                                  ),
                                ),
                              ),
                              visible: _withdrawSelected != DepositSelectType.rmb,
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 10, bottom: 10),
                        child: Container(
                          child: GestureDetector(
                            onTap: (){
                              log("取款");
                              withdraw();
                            },
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
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void withdraw(){
    HttpManager.post(url: "wallet/withdraw", params: {"bankId":widget.banks[_index].id,"cardNum":widget.banks[_index].bankCode,"amount":amount}).then((value){
      log("withdraw result --- >>> $value");
      if(value['code'] == 200){
        BaseNotification(BaseNotificationIdentify.refreshAmount.name).dispatch(context);
      }
    });
  }
}
