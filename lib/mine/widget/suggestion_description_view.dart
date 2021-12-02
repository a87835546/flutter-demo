import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_demo/utils/color_util.dart';
typedef SuggestionDescViewValueChange = Function(String);
/// 问题描述
class SuggestionDescView extends StatefulWidget {
  final SuggestionDescViewValueChange valueChange;
  const SuggestionDescView({Key? key,required this.valueChange}) : super(key: key);
  @override
  State<StatefulWidget> createState() => _SuggestionDescViewState();
}

class _SuggestionDescViewState extends State<SuggestionDescView> {
  TextEditingController _controller = TextEditingController();

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
                  child: Padding(
                    padding: EdgeInsets.only(top: 5, left: 5, right: 5),
                    child: TextField(
                      controller: _controller,
                      cursorColor: Colors.white,
                      maxLines: 10,
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                          hintText: "请输入…(内容介于20-200字)",
                          hintStyle:
                              TextStyle(color: ColorUtil.hexColor('0x919699')),
                          border: InputBorder.none,
                          labelStyle: TextStyle(color: Colors.white)),
                      maxLength: 200,
                      onEditingComplete: () {
                        log("suggestion desc input complete value ${_controller.text}");
                        widget.valueChange(_controller.text);
                      },
                      onChanged: (value) {
                        log("suggestion desc input value $value");
                        widget.valueChange(value);
                      },
                    ),
                  ),
                ),
              ),
            ))
      ],
    ));
  }
}
