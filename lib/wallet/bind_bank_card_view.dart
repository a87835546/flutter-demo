// ignore_for_file: file_names, prefer_const_constructors, prefer_const_literals_to_create_immutables, import_of_legacy_library_into_null_safe, non_constant_identifier_names

import 'dart:developer';

import 'package:city_picker_china/city_picker_china.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_demo/utils/http_manager.dart';
import 'package:flutter_demo/wallet/widget/disable_text_filed_input.dart';
import 'package:flutter_demo/wallet/widget/text_filed_input.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'entity/bank_model.dart';

class BindBankCardView extends StatefulWidget {
  @override
  _BindBankCardView createState() => _BindBankCardView();
}

class _BindBankCardView extends State<BindBankCardView> {
  String choiceAddress = "请选择开户行地址";
  String choiceBank = "所属银行";
  String _province = "";
  String _city = "";
  BankModel? bankModel;
  String _address = "";
  String cardNum = "6212262502009182455";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xff1A1A1C),
        appBar: AppBar(
          backgroundColor: Color(0XFF252626),
          title: Text("添加银行卡"),
        ),
        body: ListView(
          children: [
            Container(
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.only(left: 10, right: 10),
                    margin: EdgeInsets.only(
                        left: 10, right: 10, top: 20, bottom: 10),
                    decoration: BoxDecoration(
                      color: Color(0xFF2c2c2e),
                      borderRadius: BorderRadius.all(Radius.circular(4.0)),
                    ),
                    height: 580,
//                color: Colors.white,
                    child: Column(
                      children: [
                        Container(
                          margin:
                              EdgeInsets.only(top: 20, bottom: 10, left: 10),
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "持卡人姓名",
                            style: TextStyle(color: Color(0xFFc1c2c4)),
                          ),
                        ),
                        TextFiledInput("", "请输入真实姓名", onChanged: (text) {
//            userName = text;
//            checkInput();
                        }),
                        Container(
                            alignment: Alignment.centerLeft,
                            padding:
                                EdgeInsets.only(left: 10, top: 5, bottom: 5),
                            child: Text(
                              "请输入姓名",
                              style: TextStyle(
                                  fontSize: 10, color: Color(0xFFfd3a2e)),
                            )),
                        Container(
                          margin:
                              EdgeInsets.only(top: 20, bottom: 10, left: 10),
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "银行卡号",
                            style: TextStyle(color: Color(0xFFc1c2c4)),
                          ),
                        ),
                        TextFiledInput(cardNum, "请输入银行卡号", onChanged: (text) {
                          setState(() {
                            cardNum = text;
                          });
                        }),
                        Container(
                            alignment: Alignment.centerLeft,
                            padding:
                                EdgeInsets.only(left: 10, top: 5, bottom: 5),
                            child: Text(
                              "请输入银行卡号",
                              style: TextStyle(
                                  fontSize: 10, color: Color(0xFFfd3a2e)),
                            )),
                        Container(
                          margin:
                              EdgeInsets.only(top: 20, bottom: 10, left: 10),
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "所属银行",
                            style: TextStyle(color: Color(0xFFc1c2c4)),
                          ),
                        ),
                        DisableTextFiledInput(
                          "",
                          choiceBank,
                          onChanged: (text) {
                            log(text,stackTrace: StackTrace.current);
                          },
                          onTap: (value) async {},
                        ),
                        Container(
                            alignment: Alignment.centerLeft,
                            padding:
                                EdgeInsets.only(left: 10, top: 5, bottom: 5),
                            child: Text(
                              "所属银行",
                              style: TextStyle(
                                  fontSize: 10, color: Color(0xFFfd3a2e)),
                            )),
                        Container(
                          margin:
                              EdgeInsets.only(top: 20, bottom: 10, left: 10),
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "开户行地址",
                            style: TextStyle(color: Color(0xFFc1c2c4)),
                          ),
                        ),
                        DisableTextFiledInput(
                          "12312312",
                          choiceAddress,
                          onChanged: (text) {},
                          onTap: (value) async {
                            _invoke();
                          },
                        ),
                        Container(
                          margin:
                              EdgeInsets.only(top: 20, bottom: 10, left: 10),
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "开户支行",
                            style: TextStyle(color: Color(0xFFc1c2c4)),
                          ),
                        ),
                        TextFiledInput("", "请输入开户支行", onChanged: (text) {

                        }),
                        Container(
                            alignment: Alignment.centerLeft,
                            padding:
                                EdgeInsets.only(left: 10, top: 5, bottom: 5),
                            child: Text(
                              "支行名称只能是中文",
                              style: TextStyle(
                                  fontSize: 10, color: Color(0xFFfd3a2e)),
                            )),
                      ],
                    ),
                  ),
                  GestureDetector(
                      onTap: () async {
                        _submitChange();
                      },
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(5),
                        clipBehavior: Clip.antiAlias,
                        child: Container(
                          height: 40,
                          color: const Color(0xff2C2C2E),
                          width: 300,
                          alignment: Alignment.center,
                          child: Text(
                            "下一步",
                            style: const TextStyle(
                                color: Color(0xffC1C2C4),
                                fontSize: 14,
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                      )),
                  Container(
                    margin: EdgeInsets.only(
                        left: 10, right: 10, top: 20, bottom: 10),
                    height: 40,
                    width: 200,
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "如需帮助, ",
                          style: const TextStyle(
                              color: Color(0xffC1C2C4),
                              fontSize: 11,
                              fontWeight: FontWeight.w400),
                        ),
                        Text(
                          "联系客服",
                          style: const TextStyle(
                              color: Color(0xffd3c294),
                              fontSize: 11,
                              fontWeight: FontWeight.w400),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ));
  }

  void _submitChange() async {
    Map<String, dynamic> Parms = {
      "bankName": "中国工商银行",
      "province": _province,
      "city": _city,
      "address": _address,
      "number": cardNum,
    };
    HttpManager.post(url: '/wallet/bank/add', params: Parms).then((res) {
      log("add bank info ${res}");
      if(res['code'] == 200){
        Navigator.pop(context,true);
        Fluttertoast.showToast(msg: "添加银行卡成功");
      }
    }).catchError((error) {
      log(error.toString());
    });
  }

  Future<void> _invoke() async {
    final res = await showModalBottomSheet<CityResult>(
        context: context, builder: (_) => const CityPicker());
    if (res == null) {
      return;
    } else {
      log("select city result ${res.county}");
      setState(() {
        _city = res.city ?? "";
        _province = res.province;
        _address = res.county ?? "";
      });
    }
  }
}
