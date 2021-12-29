import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo/utils/color_util.dart';
import 'package:flutter_demo/wallet/entity/deposit_style_model.dart';

typedef DepositChannelViewClickItem = Function(dynamic);
class DepositChannelView extends StatefulWidget {
  final DepositChannelViewClickItem click;
  final List<DepositChannel>? channels;
  const DepositChannelView({Key? key,required this.click,this.channels}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _DepositChannelViewState();
}

class _DepositChannelViewState extends State<DepositChannelView> {
  var selected = null;

  @override
  Widget build(BuildContext context) {
    log('deposit channel count :${widget.channels?.length}');
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Padding(
          padding: EdgeInsets.only(top: 10),
          child: Row(
            children: [
              Container(
                height: 20,
                width: 2,
                color: ColorUtil.mainColor(),
              ),
              const Padding(padding: EdgeInsets.only(left: 10)),
              const Text(
                "充值渠道",
                style: TextStyle(color: Colors.white),
              )
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 15, right: 15, top: 10),
          child: GridView.count(
            crossAxisCount: 2,
            mainAxisSpacing: 4.0,
            crossAxisSpacing: 4.0,
            padding: const EdgeInsets.all(4.0),
            childAspectRatio: 3,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            children: (widget.channels??[]).map((e) {
              return GestureDetector(
                onTap: (){
                  widget.click(e);
                  setState(() {
                    selected = e;
                  });
                },
                child:Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        image:const DecorationImage(
                          image: AssetImage(
                              "imgs/deposit/images/background-for-charge@3x.png"),
                        ),
                      ),
                      child: Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: 20),
                            child: Container(
                              height: 30,
                              width: 36,
                              child: Image.network(e.url),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 5),
                            child: Container(
                              alignment: Alignment.centerLeft,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    width:90,
                                    child: Text(
                                      e.showName,
                                      style: TextStyle(color: Colors.white),
                                      textAlign: TextAlign.left,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  Text(
                                    "￥${e.minAmount}-${e.maxAmount}",
                                    style:const TextStyle(
                                        color: Colors.white, fontSize: 12),
                                    textAlign: TextAlign.left,
                                  )
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Visibility(child: Positioned(child: Image.asset("imgs/deposit/images/images-choose@3x.png")),visible: selected == e,)
                  ],
                ),
              );
            }).toList(),
          ),
        )
      ],
    );
  }
}
