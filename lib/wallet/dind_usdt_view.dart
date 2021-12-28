import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_demo/utils/color_util.dart';
import 'package:flutter_demo/utils/http_manager.dart';
import 'package:flutter_demo/wallet/widget/text_filed_input.dart';
import 'package:flutter_pickers/pickers.dart';
import 'package:flutter_pickers/style/default_style.dart';

class BindUSDTView extends StatefulWidget {
  @override
  _BindUSDTView createState() => _BindUSDTView();
}

class _BindUSDTView extends State<BindUSDTView> {
  String initData = '';

  int _index = 0;
  List<Map<String, dynamic>> channelsData = [
    {
      'name': '以太坊（ERC20）',
      'id': 'ERC20',
      'img': 'usdtIcon2',
    },
    {
      'name': '波场（TRC20）',
      'id': 'TRC20',
      'img': 'usdtIcon',
    }
  ];
  List<String> selectChannelsData = ['以太坊（ERC20）', '波场（TRC20）'];
  int selectChannelindex = 0;

  List<dynamic> purses = [];
  String seletctPurses = '';
  List<String> pursesname = [];
  int seletpurseindex = 0;

  String purseInput = '';
  String confirmPurseInput = '';

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xff1A1A1C),
        appBar: AppBar(
          backgroundColor: Color(0XFF252626),
          title: Text("添加钱包"),
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
                    height: 450,
//                color: Colors.white,
                    child: Column(
                      children: [
                        Container(
                          margin:
                              EdgeInsets.only(top: 20, bottom: 10, left: 10),
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "协议类型",
                            style: TextStyle(color: Color(0xFFc1c2c4)),
                          ),
                        ),
                        _delegateType(),
                        Container(
                          margin:
                              EdgeInsets.only(top: 20, bottom: 10, left: 10),
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "钱包类型",
                            style: TextStyle(color: Color(0xFFc1c2c4)),
                          ),
                        ),
                        // _purseType(),
                        Container(
                          margin:
                              EdgeInsets.only(top: 20, bottom: 10, left: 10),
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "钱包地址",
                            style: TextStyle(color: Color(0xFFc1c2c4)),
                          ),
                        ),
                        TextFiledInput(
                          "",
                          "请输入钱包地址",
                          onChanged: (text) {
                            purseInput = text;
                          },
                        ),
                        Container(
                            alignment: Alignment.centerLeft,
                            padding:
                                EdgeInsets.only(left: 10, top: 5, bottom: 5),
                            child: Text(
                              "暂只支持0x开头的42位ERC20地址",
                              style: TextStyle(
                                  fontSize: 10, color: Color(0xFFfd3a2e)),
                            )),
                        Container(
                          margin:
                              EdgeInsets.only(top: 20, bottom: 10, left: 10),
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "确认钱包地址",
                            style: TextStyle(color: Color(0xFFc1c2c4)),
                          ),
                        ),
                        TextFiledInput("", "请再次输入钱包地址", onChanged: (text) {
                          confirmPurseInput = text;
                        }),
                        Container(
                            alignment: Alignment.centerLeft,
                            padding:
                                EdgeInsets.only(left: 10, top: 5, bottom: 5),
                            child: Text(
                              "两次输入钱包地址不一致，请核对后重新输入",
                              style: TextStyle(
                                  fontSize: 10, color: Color(0xFFfd3a2e)),
                            )),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 25),
                    child: GestureDetector(
                        onTap: () {
                          addCr();
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
                  ),
                  Container(
                    margin: EdgeInsets.only(
                        left: 10, right: 10, top: 20, bottom: 10),
                    height: 40,
                    width: 200,
                    alignment: Alignment.center,
                    child: RichText(
                      text: TextSpan(
                          text: "如需帮助，",
                          style:
                              TextStyle(color: Color(0xffC1C2C4), fontSize: 12),
                          children: [
                            TextSpan(
                                text: '联系客服',
                                style: TextStyle(color: ColorUtil.mainColor()))
                          ]),
                    ),
                  ),
                ],
              ),
            )
          ],
        ));
  }

  //协议类型
  _delegateType() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 40,
      decoration: BoxDecoration(
          color: Color(0XFF1C1C1D), borderRadius: BorderRadius.circular(5.0)),
      child: TextButton(
          style: ButtonStyle(
            alignment: Alignment.centerLeft,
          ),
          onPressed: () {
            Pickers.showSinglePicker(
              context,
              data: selectChannelsData,
              selectData: initData,
              pickerStyle: DefaultPickerStyle.dark(),
              onConfirm: (p, position) {
                log('longer >>> 返回数据下标：$position');
                setState(() {
                  initData = p;
                  selectChannelindex = position;
                  _index = position;
                });
              },
              onChanged: (p, position) {
                log('longer >>> 返回数据下标：$position');
                log('数据发生改变：$p');
              },
            );
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                initData.length == 0 ? '请选择协议类型' : initData,
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: initData.length == 0
                        ? Color(0xff919699)
                        : Color(0xffFFFFFF),
                    fontSize: 11,
                    fontWeight: FontWeight.w400),
              ),
              Icon(
                Icons.arrow_forward_ios,
                color: Colors.white54,
                size: 20,
              )
            ],
          )),
    );
  }

  //钱包类型
  _purseType() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 40,
      decoration: BoxDecoration(
          color: Color(0XFF1C1C1D), borderRadius: BorderRadius.circular(5.0)),
      child: TextButton(
          style: ButtonStyle(
            alignment: Alignment.centerLeft,
            // backgroundColor: MaterialStateProperty.all(Color(0XFF252626))
          ),
          onPressed: () {
            Pickers.showSinglePicker(
              context,
              data: pursesname,
              selectData: seletctPurses,
              pickerStyle: DefaultPickerStyle.dark(),
              onConfirm: (p, position) {
                print('longer >>> 返回数据下标：$position');
                setState(() {
                  seletctPurses = p;
                  seletpurseindex = position;
                });
              },
              onChanged: (p, position) {
                print('longer >>> 返回数据下标：$position');
                print('数据发生改变：$p');
              },
            );
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                seletctPurses.length == 0 ? '请选择钱包类型' : seletctPurses,
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: seletctPurses.length == 0
                        ? Color(0xff919699)
                        : Color(0xffFFFFFF),
                    fontSize: 11,
                    fontWeight: FontWeight.w400),
              ),
              Icon(
                Icons.arrow_forward_ios,
                color: Colors.white54,
                size: 20,
              )
            ],
          )),
    );
  }

//正则判断钱包
  static bool isValidatePurse(String input) {
    RegExp TPurse = new RegExp(r"^T\w{33}");
    RegExp XPurse = new RegExp(r"^0x[0-9a-fA-F]{40}$");
    return TPurse.hasMatch(input) || XPurse.hasMatch(input);
  }

  void addCr(){
    HttpManager.post(url: 'wallet/bank/addCryptocurrency', params: {
      "address": purseInput,
      "protocol": _index
    }).then((value){
      log('1234-- >>> $value');
      if(value['code'] == 200){
        Navigator.pop(context,true);
      }
    });
  }
}
