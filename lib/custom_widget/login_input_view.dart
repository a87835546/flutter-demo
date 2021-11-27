import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo/utils/color_util.dart';

typedef InputTextFieldValueDidChanged = void Function(String value);
typedef InputTextFieldValueDidComplete = void Function();

class InputTextField extends StatefulWidget {
  final String placeholder;
  final Widget? error;
  final bool isFocus;
  final String? leftIconName;
  final String? rightIconName;
  final bool security;
  final InputTextFieldValueDidChanged? didChanged;
  final InputTextFieldValueDidComplete? complete;
  final num maxLength;

  const InputTextField(
      {Key? key,
      required this.placeholder,
      this.error,
      this.isFocus = false,
      this.leftIconName,
      this.security = false,
      this.didChanged,
      this.complete,
      this.maxLength = 30,
      this.rightIconName})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _InputTextFieldState();
}

class _InputTextFieldState extends State<InputTextField> {
  final TextEditingController _editingController = TextEditingController();
  bool isVisible = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 38,
      alignment: Alignment.center,
      decoration: BoxDecoration(
          // color: Colors.black26,
          ),
      child: Padding(
        padding: EdgeInsets.only(left: 10, right: 10),
        child: PhysicalModel(
          color: Colors.black45,
          borderRadius: BorderRadius.circular(10),
          child: TextField(
            controller: _editingController,
            cursorColor: ColorUtil.mainColor(),
            autocorrect: true,
            style: const TextStyle(color: Colors.white),
            decoration: InputDecoration(
                contentPadding: const EdgeInsets.only(top: 5),
                hintText: "请输入${widget.placeholder}",
                hintStyle: TextStyle(
                  color: ColorUtil.hexColor("0x919699"),
                  fontSize: 13,
                ),
                isCollapsed: false,
                border: InputBorder.none,
                filled: false,
                prefixIcon: widget.leftIconName != null
                    ? Image.asset(widget.leftIconName!)
                    : const Icon(
                        Icons.person,
                        size: 14,
                        color: Colors.white38,
                      ),
                suffixIcon: widget.rightIconName != null
                    ? Image.asset(
                        widget.rightIconName!,
                        width: 14,
                        height: 14,
                      )
                    : Visibility(
                        child: GestureDetector(
                            onTap: () {
                              _editingController.clear();
                              widget.didChanged!("");
                              setState(() {
                                isVisible = false;
                              });
                            },
                            child: Icon(
                              Icons.close,
                              size: 14,
                              color: Colors.white38,
                            )),
                        visible: isVisible,
                      )),
            autofocus: widget.isFocus,
            obscureText: widget.security,
            onTap: () {
              log("text field did click");
            },
            onChanged: (value) {
              log("textfield did change: $value max lentg :${widget.maxLength} value length : ${value.length}");
              if(value.length > widget.maxLength){
                // value = value.substring(0,widget.maxLength.toInt());
                // _editingController.text = value;
              }
              setState(() {
                isVisible = value.isNotEmpty;
              });
              widget.didChanged!(value);
            },
            onEditingComplete: () {
              widget.complete!;
            },
          ),
        ),
      ),
    );
  }
}
