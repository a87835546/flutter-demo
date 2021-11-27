import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo/utils/color_util.dart';

typedef SwitchButtonClick = void Function(String);

class SwitchButton extends StatefulWidget {
  final List<String> titles;
  final SwitchButtonClick? switchButtonClick;
  final double? width ;
  final double? height ;
  const SwitchButton({Key? key, required this.titles, this.switchButtonClick,this.width = 182,this.height = 30})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _SwitchButtonState();
}

class _SwitchButtonState extends State<SwitchButton> {
  bool isSelect = true;
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    return SizedBox(
      width: widget.width,
      height: widget.height,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        clipBehavior: Clip.antiAlias,
        child: Row(
          children: [
            _createButton(
                title: widget.titles.first,
                isSelect: isSelect,
                click: () {
                  clickButton(widget.titles.first);
                }),
            _createButton(
                title: widget.titles.last,
                isSelect: !isSelect,
                click: () {
                  clickButton(widget.titles.last);
                }),
          ],
        ),
      ),
    );
  }

  void clickButton(String title) {
    setState(() {
      isSelect = !isSelect;
    });
    if (widget.switchButtonClick != null) {
      widget.switchButtonClick!(title);
    }
  }

  Widget _createButton(
      {required String title,
      bool? isSelect = true,
      void Function()? click}) {
    return Container(
      width: widget.width!/2,
      height: widget.height,
      alignment: Alignment.center,
      decoration: BoxDecoration(
          color: isSelect == true
              ? ColorUtil.hexColor('0xD0C3A6')
              : Colors.black45),
      child: GestureDetector(
        onTap: click,
        child: Text(
          title,
          style: TextStyle(
              color: isSelect == true
                  ? ColorUtil.hexColor('0x363535')
                  : Colors.white
              // color: ColorUtil('#D0C3A6')
              ),
        ),
      ),
    );
  }
}
