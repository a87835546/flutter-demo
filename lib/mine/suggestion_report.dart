import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_demo/base_page/base_page.dart';
import 'package:flutter_demo/mine/widget/suggestion_description_view.dart';
import 'package:flutter_demo/mine/widget/suggestion_select_image_view.dart';
import 'package:flutter_demo/mine/widget/suggestion_type_view.dart';
import 'package:flutter_demo/mine/widget/suggestion_type_list_view.dart';
import 'package:flutter_demo/utils/color_util.dart';

///意见反馈
class SuggestionReport extends StatefulWidget {
  const SuggestionReport({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _SuggestionReportState();
}

class _SuggestionReportState extends State<SuggestionReport> with BasePage {
  bool _visible = false;
  String? type;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "意见反馈",
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xff252626),
        automaticallyImplyLeading: true,
        actions: [
          Container(
            padding: const EdgeInsets.only(right: 10),
            width: 40,
            height: 24,
            child: GestureDetector(
              onTap: () {},
              child: Image.asset(
                "imgs/mine/images/icon-customer-service@3x.png",
                width: 20,
                height: 20,
              ),
            ),
          )
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
          ColorUtil.hexColor('0x1a1a1c'),
          ColorUtil.hexColor('0x202123'),
        ])),
        child: ConstrainedBox(
          constraints: BoxConstraints.expand(),
          child: Stack(
            children: [
              ListView(
                shrinkWrap: true,
                children: [
                  SuggestionTypeView(
                    type: type,
                    click: (value) {
                      setState(() {
                        _visible = value;
                      });
                    },
                  ),
                  const Padding(padding: EdgeInsets.only(top: 5)),
                  SuggestionDescView(
                    valueChange: (value) {},
                  ),
                  const Padding(padding: EdgeInsets.only(top: 5)),
                  SuggestionSelectImageView(
                    click: (image) {},
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 10, left: 60, right: 60),
                    child: GestureDetector(
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: 40,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: ColorUtil.hexColor('0x2C2C2E'),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: const Text(
                          "提交",
                          style:
                              TextStyle(color: Color(0xffC1C2C4), fontSize: 14),
                        ),
                      ),
                      onTap: () {
                        log("click submit");
                      },
                    ),
                  )
                ],
              ),
              SuggestionTypeListView(
                visible: _visible,
                click: (index) {
                  log("click type index $index");
                  setState(() {
                    _visible = !_visible;
                    type = index;
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
