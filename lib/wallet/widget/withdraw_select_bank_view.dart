import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo/utils/color_util.dart';

import 'bank_item_view.dart';

typedef WithdrawAddBankViewClick = Function();
typedef WithdrawSelectedBankItemClick = Function();
class WithdrawAddBankView extends StatefulWidget {
  final WithdrawAddBankViewClick? clickAdd;
  final WithdrawSelectedBankItemClick? clickItem;
  const WithdrawAddBankView({Key? key, this.clickAdd,this.clickItem}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _WithdrawAddBankViewState();
}

class _WithdrawAddBankViewState extends State<WithdrawAddBankView> {
  bool hasBank = true;

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Row(
              children: [
                Container(
                  height: 20,
                  width: 2,
                  color: ColorUtil.mainColor(),
                ),
                const Padding(padding: EdgeInsets.only(left: 10)),
                const Text(
                  "选择提款银行卡",
                  style: TextStyle(color: Colors.white),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
            child: Container(
              decoration: BoxDecoration(
                  color: const Color(0xff222225),
                  borderRadius: BorderRadius.circular(8)),
              child: !hasBank
                  ? GestureDetector(
                      onTap: () {
                        if (widget.clickAdd != null) {
                          widget.clickAdd!();
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(left: 21),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              child: Image.asset(
                                "imgs/images/icon-add@3x.png",
                                fit: BoxFit.fitWidth,
                                width: 14,
                                height: 14,
                              ),
                            ),
                            Expanded(
                                child: Padding(
                              padding: EdgeInsets.only(
                                  top: 12, left: 12, bottom: 12),
                              child: Column(
                                children: [
                                  Container(
                                    height: 20,
                                    alignment: Alignment.centerLeft,
                                    child: const Text(
                                      "请绑定银行卡",
                                      style: TextStyle(
                                          color: Color(0xffC1C2C4),
                                          fontSize: 14),
                                    ),
                                  ),
                                  Container(
                                    alignment: Alignment.centerLeft,
                                    child: const Text(
                                      "您还未绑定银行卡，绑定后即可提款",
                                      style: TextStyle(
                                          color: Color(0xff919699),
                                          fontSize: 12),
                                    ),
                                  ),
                                ],
                              ),
                            ))
                          ],
                        ),
                      ),
                    )
                  : Padding(
                      padding: const EdgeInsets.only(
                          left: 20, right: 20, bottom: 10, top: 10),
                      child: ListView.builder(
                          itemBuilder: (BuildContext context, index) {
                            return Padding(
                              padding:
                                  const EdgeInsets.only(bottom: 10, left: 0),
                              child: GestureDetector(
                                onTap: () {
                                  if(widget.clickItem != null){
                                    widget.clickItem!();
                                  }
                                },
                                child: Container(
                                  height: 65,
                                  child: BankItemView(),
                                ),
                              ),
                            );
                          },
                          itemCount: 3,
                          shrinkWrap: true),
                    ),
            ),
          ),
        ],
      ),
    ));
  }
}
