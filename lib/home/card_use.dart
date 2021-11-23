import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo/custom_widget/custom_card_view.dart';
import 'package:flutter_demo/custom_widget/custom_card_view_three.dart';
import 'package:flutter_demo/custom_widget/custom_card_view_two.dart';

class CardUse extends StatefulWidget {
  const CardUse({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _CardUseState();
}

class _CardUseState extends State<CardUse> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("常用的卡片view的使用"),
      ),
      body: Center(
          widthFactor: 1,
          heightFactor: 1,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10, top: 2, right: 10),
                child: CustomCardView(
                  clickItem: () {
                    print("custom card view click item");
                  },
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 10),
                child: CustomCardView2(),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 10,left: 10,right: 10),
                child: CustomCardView3(),
              ),
            ],
          )),
    );
  }
}
