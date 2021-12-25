// ignore_for_file: file_names, prefer_const_constructors

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

typedef GesturetTapCallback = void Function(bool a);

///登录输入框，自定义widget
class TextFiledInput extends StatefulWidget {
  final String title;
  final String hint;
  final ValueChanged<String>? onChanged;
  final ValueChanged<bool>? focusChanged;
  final bool lineStretch;
  final bool obscureText;
  final TextInputType? keyboardType;
  final GesturetTapCallback? onTap;
  final String? guojia;
  final ValueChanged<String>? onTapVif;

  const TextFiledInput(this.title, this.hint,
      {Key? key,
      this.onChanged,
      this.focusChanged,
      this.lineStretch = false,
      this.obscureText = false,
      this.keyboardType,
      this.onTap,
      this.guojia,
      this.onTapVif})
      : super(key: key);

  @override
  _TextFiledInput createState() => _TextFiledInput();
}

class _TextFiledInput extends State<TextFiledInput> {
  final _focusNode = FocusNode();
  Timer? _timer;

  //倒计时数值
  var _enable = true;
  var _time = 0;

  @override
  void initState() {
    super.initState();
    print("${widget.hint} ---- initState");
    //是否获取光标的监听
    _focusNode.addListener(() {
      print("Has focus:${widget.title}==== ${_focusNode.hasFocus}");
      if (widget.focusChanged != null) {
        widget.focusChanged!(_focusNode.hasFocus);
      }
    });
  }

  @override
  void dispose() {
    print("销毁....");
    _focusNode.dispose();
    if (_timer != null) {
      _timer?.cancel();
      _timer = null;
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [_input()],
        ),
      ],
    );
  }

  _input() {
    var rightWidget;
    var phonelocation;
    if (widget.hint == "手机号") {
      rightWidget = Positioned(
        right: 10.0,
        top: 10,
        child: Image(
            height: 20,
            width: 20,
            image: AssetImage('imgs/icon-protection@3x.png')),
      );

      phonelocation = Positioned(
        left: 10.0,
        top: 10,
        child: GestureDetector(
          child: Container(
            padding: EdgeInsets.only(left: 5),
            margin: EdgeInsets.only(left: 5, right: 5),
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: Color.fromRGBO(62, 63, 68, 1),
                borderRadius: BorderRadius.circular(3.0)),
            child: Row(
              children: [
                Text(widget.guojia!,
                    style: TextStyle(fontSize: 10, color: Color(0XFFc1c2c4))),
                Text(" "),
                Image(
                    height: 13,
                    width: 13,
                    image: AssetImage('sdyimgs/login/images/arrow_down.png')),
              ],
            ),
            width: 48,
            height: 20,
          ),
          onTap: () {
            widget.onTap!(true);
          },
        ),
      );
    } else if (widget.hint == "请输入验证码") {
      rightWidget = Positioned(
        right: 10.0,
        top: 15,
        child: GestureDetector(
          child: Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(),
            child: Text(_time == 0 ? "获取验证码" : "${_time}s后重新获取",
                style: TextStyle(fontSize: 11, color: Color(0XFFd3c294))),
          ),
          onTap: () => setState(() {
            print("获取验证码");
            widget.onTapVif!("");
            _enable ? startCountdown(50) : null;
          }),
        ),
      );
    }
    return Expanded(
        child: Container(
            height: 40,
            child: Stack(
                children: widget.hint == "手机号"
                    ? [
                        textField(),
                        phonelocation,
                      ]
                    : widget.hint == "请输入验证码"
                        ? [textField(), rightWidget]
                        : [
                            textField(),
                          ])));
  }

  TextField textField() {
    return TextField(
      focusNode: _focusNode,
      onChanged: widget.onChanged,
      obscureText: widget.obscureText,
      keyboardType: widget.keyboardType,
      autofocus: !widget.obscureText,
      cursorColor: Colors.grey,
      style: TextStyle(
          fontSize: 12, fontWeight: FontWeight.w300, color: Colors.white),
      //输入框的样式
      decoration: InputDecoration(
        filled: true,
        fillColor: Color.fromRGBO(0, 0, 0, 0.37),
        contentPadding: EdgeInsets.only(
            left: widget.hint == "手机号" ? 90 : 10,
            right: 20,
            top: 5,
            bottom: 10),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: BorderSide.none),
        hintText: widget.hint,
        hintStyle: TextStyle(fontSize: 11, color: Colors.grey),
//      focusedBorder: OutlineInputBorder(
//
//        borderRadius: BorderRadius.circular(25.7),
//      ),
//      enabledBorder: UnderlineInputBorder(
//
//        borderRadius: BorderRadius.circular(25.7),
//      ),
      ),
    );
  }

  //倒计时方法
  void startCountdown(int count) {
    if (!_enable) return;
    setState(() {
      _enable = false;
      _time = count;
    });
    //倒计时时间
    _timer = Timer.periodic(Duration(seconds: 1), (Timer it) {
      print(it.tick);
      setState(() {
        if (it.tick == count) {
          _enable = true;
          it.cancel();
        }
        _time = count - it.tick;
      });
    });
  }
}
