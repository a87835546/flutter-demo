import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo/utils/color_util.dart';

typedef InputTextFieldValueDidChanged = void Function(String value);
typedef InputTextFieldValueDidComplete = void Function();

/// 输入内容的类型
enum InputTextFieldType {
  username,
  password,
  mobile,

}

extension TypeExtension on InputTextFieldType {
  String get name => describeEnum(this);

  String get value {
    switch (this) {
      case InputTextFieldType.username:
        return "注册用户名";
      case InputTextFieldType.password:
        return "密码";
      case InputTextFieldType.mobile:
        return "手机";
      default:
        return "111";
    }
  }
}

class InputTextField extends StatefulWidget {
  /// 输入框的占位 内容
  final String placeholder;
  final bool isFocus;
  final InputTextFieldType? inputTextFieldType;
  /// 当输入内容与给定的长度不符合的时候显示错误内容
  final String? errorText;
  final bool security;
  final InputTextFieldValueDidChanged? didChanged;
  final InputTextFieldValueDidComplete? complete;
  final num maxLength;
  final num minLength;

  const InputTextField({
    Key? key,
    required this.placeholder,
    this.isFocus = false,
    this.security = false,
    this.didChanged,
    this.complete,
    this.maxLength = 30,
    this.minLength = 6,
    this.errorText,
    this.inputTextFieldType = InputTextFieldType.username
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _InputTextFieldState();
}

class _InputTextFieldState extends State<InputTextField> {
  final TextEditingController _editingController = TextEditingController();
  bool isVisible = false;
  bool showErrorLabel = false;
  bool _security = false;
  @override
  void initState() {
    _security = widget.security;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 38 + 15,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        // color: Colors.redAccent,
      ),
      child: Padding(
        padding: EdgeInsets.only(left: 10, right: 10),
        child: Column(
          children: [
            SizedBox(
              height: 38,
              child: PhysicalModel(
                color: Colors.black45,
                borderRadius: BorderRadius.circular(10),
                child: TextField(
                  controller: _editingController,
                  cursorColor: ColorUtil.mainColor(),
                  autocorrect: true,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                      contentPadding: const EdgeInsets.only(top: 3),
                      hintText: widget.placeholder,
                      // errorText: widget.placeholder,
                      hintStyle: TextStyle(
                        color: ColorUtil.hexColor("0x919699"),
                        fontSize: 13,
                      ),
                      isCollapsed: false,
                      border: InputBorder.none,
                      filled: false,
                      prefixIcon: widget.security == true
                          ? const Icon(
                        Icons.lock,
                        size: 14,
                        color: Colors.white38,
                      )
                          : const Icon(
                        Icons.person,
                        size: 14,
                        color: Colors.white38,
                      ),
                      suffixIcon: widget.security == true
                          ? GestureDetector(
                        onTap: (){
                          setState(() {
                            _security = !_security;
                          });
                        },
                        child: Container(
                          width: 30,
                          alignment: Alignment.centerRight,
                          child: const Icon(
                            Icons.remove_red_eye_outlined,
                            size: 14,
                            color: Colors.white38,
                          ),
                        ),
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
                  obscureText: _security,
                  onTap: () {
                    log("text field did click");
                  },
                  onChanged: (value) {
                    log("textfield did change: $value max lentg :${widget
                        .maxLength} value length : ${value.length}");
                    if (value.length > widget.maxLength) {
                      // value = value.substring(0,widget.maxLength.toInt());
                      // _editingController.text = value;
                    }
                    setState(() {
                      isVisible = value.isNotEmpty;
                      showErrorLabel = value.length > widget.maxLength ||
                          value.length < widget.minLength;
                    });
                    widget.didChanged!(value);
                  },
                  onEditingComplete: () {
                    widget.complete!;
                  },
                ),
              ),
            ),
            Visibility(
              child: Container(
                height: 15,
                alignment: Alignment.centerLeft,
                child: Text(
                  widget.errorText ?? widget.placeholder,
                  style: TextStyle(color: ColorUtil.mainColor(), fontSize: 12),
                ),
              ),
              visible: showErrorLabel,
            )
          ],
        ),
      ),
    );
  }
}
