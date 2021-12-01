import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_demo/utils/color_util.dart';

/// 问题描述
class SuggestionDescView extends StatefulWidget {
  const SuggestionDescView({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _SuggestionDescViewState();
}

class _SuggestionDescViewState extends State<SuggestionDescView> {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
      children: [
        Padding(
            padding: const EdgeInsets.only(left: 14, top: 5),
            child: Container(
              alignment: Alignment.centerLeft,
              child: Text(
                "问题描述：",
                textAlign: TextAlign.left,
                style:
                    TextStyle(color: ColorUtil.mainTitleColor(), fontSize: 14),
              ),
            )),
        Padding(
            padding: const EdgeInsets.only(left: 14, right: 14),
            child: Container(
              height: 250,
              decoration: BoxDecoration(
                  // border: Border.all(),
                  borderRadius: BorderRadius.circular(4),
                  color: ColorUtil.hexColor('0x2c2c2e')
                      .withAlpha((255 * 0.6).toInt())),
              child: Container(
                child: GestureDetector(
                  onTap: () {
                    log("选择问题类型");
                  },
                  child: TextField(

                  ),
                ),
              ),
            ))
      ],
    ));
  }
}
