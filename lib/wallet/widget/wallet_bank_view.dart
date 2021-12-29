import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo/utils/http_manager.dart';
import 'package:flutter_demo/wallet/entity/bank_model.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../bind_bank_card_view.dart';
import '../deposit_select_style_page.dart';
import '../deposit_style_page.dart';
import '../dind_usdt_view.dart';
import 'bank_item_view.dart';

/// 添加银行卡页面
class WalletBankView extends StatefulWidget {
  const WalletBankView({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _WalletBankViewState();
}

class _WalletBankViewState extends State<WalletBankView> {
  int _index = 0;
  List<Banks> _list = [];
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getData(),
        builder:
        (BuildContext context, AsyncSnapshot snapshot) {
      if (snapshot.hasError || snapshot.data == null) {
        return Text("${snapshot.error}");
      } else {
        List temp = snapshot.data;
        List<Banks> list = temp.first as List<Banks>;
        List<Banks> crList = temp.last as List<Banks>;

        return Column(
          children: [
             DepositSelectTypeView(
              type: DepositStylePageType.bank,
              click: (index){
                setState(() {
                    _list = index == 0? list :crList;
                });
              },

            ),
            Padding(
              padding: EdgeInsets.only(left: 10),
              child: Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  '我的卡共 ${_list.length>0?_list.length:list.length}张',
                  textAlign: TextAlign.left,
                  style: TextStyle(color: Color(0xffC1C2C4)),
                ),
              ),
            ),
            Padding(
              padding:
                  EdgeInsets.only(left: 34, right: 34, bottom: 10, top: 10),
              child: ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (BuildContext context, index) {
                    return SizedBox(
                      height: 65,
                      child: Padding(
                        padding: EdgeInsets.only(left: 0),
                        child: BankItemView(model: _list.length>0?_list[index]:list[index],clickUnbind: (){
                          disapper(_list[index]);
                        },showUnbindingBtn: true,
                        ),
                      ),
                    );
                  },
                  itemCount: _list.length>0?_list.length:list.length,
                  shrinkWrap: true),
            ),
            Padding(
              padding: EdgeInsets.only(left: 0, right: 0),
              child: Container(
                child: Padding(
                  padding: EdgeInsets.only(top: 10, bottom: 10),
                  child: Container(
                    child: GestureDetector(
                      onTap: () async {
                        var result = await Navigator.push(context, MaterialPageRoute(builder: (_) {
                          return  _index == 0? BindBankCardView() :  BindUSDTView();
                        }));
                        if (result == true){
                          getList();
                        }
                      },
                      child: Container(
                        height: 40,
                        width: 255,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                              colors: [Color(0xff3C3E41), Color(0xff37373A)]),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        alignment: Alignment.center,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              height: 16,
                              width: 16,
                              child: Image.asset(
                                "imgs/images/icon-add@3x.png",
                                fit: BoxFit.fitWidth,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 5),
                              child: Text(
                                "添加银行卡",
                                style: TextStyle(color: Color(0xffC1C2C4)),
                              ),
                            )
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
    });
  }

  Future getData() async{
    return Future.wait([getList(), getList1()]);
  }

  Future<List<Banks>> getList() async{
   final result =  await HttpManager.get(url: "wallet/bank/list");
   // log("get bank list --- >>> $result");
   if(result['data'] != null){
     List<Banks> banks = [];
     List temp = result['data'];
     temp.forEach((element) {
       banks.add(Banks.fromJson(element));
     });
     return banks;
   }
   return [];
  }

  Future<List<Banks>> getList1() async{
    final result =  await HttpManager.get(url: "wallet/bank/crList");
    log("get bank list --- >>> $result");
    if(result['data'] != null){
      List<Banks> banks = [];
      List temp = result['data'];
      temp.forEach((element) {
        banks.add(Banks.fromJson1(element));
      });
      log('banks ---- >>> $banks');
      return banks;
    }
    return [];
  }
  void disapper(Banks model){
    HttpManager.post(url: "wallet/bank/delete?bankId=${model.id??0}",params: {}).then((value){
      // log('delete bank result $value');
      if(value['code'] == 200){
        Fluttertoast.showToast(msg: "解绑银行卡成功");
        getList();
      }
    });
  }
}
