import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_demo/utils/color_util.dart';
typedef SuggestionTypeViewClick = void Function(bool);
class SuggestionTypeView extends StatefulWidget {
  /// 点击弹窗的响应事件
  final SuggestionTypeViewClick click;
  /// 选择的类型
  final String? type;
  const SuggestionTypeView({Key? key,required this.click, this.type}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _SuggestionTypeViewState();
}

class _SuggestionTypeViewState extends State<SuggestionTypeView> {
  bool _visible = false;

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
                "问题类型：",
                textAlign: TextAlign.left,
                style:
                    TextStyle(color: ColorUtil.mainTitleColor(), fontSize: 14),
              ),
            )),
        Padding(
            padding: const EdgeInsets.only(left: 14, right: 14),
            child: Container(
              height: 40,
              decoration: BoxDecoration(
                  // border: Border.all(),
                  borderRadius: BorderRadius.circular(4),
                  color: ColorUtil.hexColor('0x2c2c2e')
                      .withAlpha((255 * 0.6).toInt())),
              child: Container(
                child: GestureDetector(
                  onTap: () {
                    log("选择问题类型");
                    setState(() {
                      _visible = !_visible;
                      widget.click(_visible);
                    });
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        widget.type??"请选择问题类型",
                        style: TextStyle(
                            color: ColorUtil.hexColor('0x919699'),
                            fontSize: 14),
                      ),
                      Padding(
                        padding: EdgeInsets.only(right: 10),
                        child: Image.asset(
                          "imgs/images/iocn-arrow-down@3x.png",
                          width: 16,
                          height: 16,
                          fit: BoxFit.contain,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            )),
      ],
    ));
  }


}
