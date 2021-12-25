import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

///登录输入框，自定义widget
class DisableTextFiledInput extends StatefulWidget {
  final String title;
  final String hint;
  final ValueChanged<String>? onChanged;
  final ValueChanged<bool>? focusChanged;
  final bool lineStretch;
  final bool obscureText;

  final TextInputType? keyboardType;
  final GestureTtextCallback? onTap;
  const DisableTextFiledInput(this.title, this.hint,
      {Key? key,
      this.onChanged,
      this.focusChanged,
      this.lineStretch = false,
      this.obscureText = false,
      this.keyboardType,
      this.onTap})
      : super(key: key);

  @override
  _DisableTextFiledInput createState() => _DisableTextFiledInput();
}

typedef GestureTtextCallback = void Function(String a);

class _DisableTextFiledInput extends State<DisableTextFiledInput> {
  final _focusNode = FocusNode();
  late String captchaVerification;
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
    var choiceNatinoal;
    if (widget.hint == "手机号") {
      rightWidget = Positioned(
        right: 10.0,
        top: 10,
        child: Image(
            height: 20,
            width: 20,
            image: AssetImage('sdyimgs/login/images/avatar.png')),
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
                Text("中国",
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
          onTap: () => {print("中国")},
        ),
      );

      choiceNatinoal = OverflowBox(
          alignment: Alignment.topLeft,
          maxWidth: 400.0,
          maxHeight: 400.0,
          child: GestureDetector(
            child: Container(
              padding: EdgeInsets.only(left: 5),
              alignment: Alignment.centerLeft,
              margin: EdgeInsetsDirectional.only(top: 30, start: 35),
              width: 48,
              height: 20,
              decoration: BoxDecoration(
                color: Color.fromRGBO(62, 63, 68, 1),
              ),
              child: Text("台湾",
                  style: TextStyle(fontSize: 10, color: Color(0XFFc1c2c4))),
            ),
            onTap: () => {print("台湾")},
          ));
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

  GestureDetector textField() {
    return GestureDetector(
      onTap: () async {
//        _focusNode.unfocus();
        FocusScope.of(context).requestFocus(_focusNode);
        widget.onTap!("测试");
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(6),
        child: Container(
          padding: EdgeInsets.only(left: 10),
          alignment: Alignment.centerLeft,
          color: Color.fromRGBO(0, 0, 0, 0.37),
          height: 40,
          child: Text(widget.hint,
              style: TextStyle(fontSize: 11, color: Colors.grey)),
        ),
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

  //滑动拼图
  void loadingBlockPuzzle(BuildContext context, {barrierDismissible = true}) {
    showDialog<Null>(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (BuildContext context) {
        return Text("123123");
      },
    );
  }
}
