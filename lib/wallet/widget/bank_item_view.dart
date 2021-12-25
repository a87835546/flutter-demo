import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo/wallet/entity/bank_model.dart';

typedef BankItemViewClickUnbind = Function();

class BankItemView extends StatefulWidget {
  final Banks? model;
  final BankItemViewClickUnbind? clickUnbind;
  final bool showUnbindingBtn;
  const BankItemView(
      {Key? key,
      required this.model,
      required this.clickUnbind,
      required this.showUnbindingBtn,})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _BankItemViewState();
}

class _BankItemViewState extends State<BankItemView> {
  bool show = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        setState(() {
          show = !show;
        });
      },
      child: Stack(
        children: [
          Row(
            children: [
              Padding(
                padding: EdgeInsets.only(left: 0),
                child: Container(
                  height: 34,
                  width: 34,
                  child: Image.network(widget.model?.bankLog ?? ""),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(left: 5, top: 12),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            child: Text(
                              '${widget.model?.bankName ?? "1231231"}',
                              style: TextStyle(
                                  color: Color(0xffC1C2C4), fontSize: 14),
                            ),
                          ),
                          Visibility(
                            child: GestureDetector(
                              child: Container(
                                height: 20,
                                padding: EdgeInsets.only(left: 12, right: 12),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(6),
                                    border: Border.all(
                                        color: Color(0xffC1C2C4), width: 1)),
                                child: Text(
                                  "解绑",
                                  style: TextStyle(
                                      color: Color(0xffC1C2C4), fontSize: 12),
                                ),
                              ),
                              onTap: () {
                                log("解绑");
                                if (widget.clickUnbind != null) {
                                  widget.clickUnbind!();
                                }
                              },
                            ),
                            visible: widget.showUnbindingBtn,
                          )
                        ],
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          '${widget.model?.bankCode ?? "1234**********4567"} ',
                          style:
                          TextStyle(color: Color(0xff919699), fontSize: 12),
                          textAlign: TextAlign.left,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Visibility(
            child: Positioned(
              child: Image.asset("imgs/deposit/images/images-choose@3x.png",fit: BoxFit.fill,),),
            visible: !widget.showUnbindingBtn && show != false,
          )
        ],
      ),
    );
  }
}
