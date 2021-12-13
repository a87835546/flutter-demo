import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo/custom_widget/login_input_view.dart';

/// 绑定手机号
class BandingPhonePage extends StatefulWidget {
  const BandingPhonePage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _BandingPhonePageState();
}

class _BandingPhonePageState extends State<BandingPhonePage> {
  String guojia = "中国";
  bool guojiaChoiceVisible = false;
  String phoneNumber = "";

  bool isCorrect = true;

  String vifCode = "";

  bool isCorrectCode = true;

  String captchaVerification = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "手机号码",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: ListView(children: [
        Stack(
          children: [
            Container(
              padding: EdgeInsets.only(left: 10, right: 10),
              color: const Color(0xff1A1A1C),
              child: Column(
                children: [
                  InputTextField(
                    placeholder: "手机号",
                    didChanged: (text) {
                      phoneNumber = text;
                      // checkInput();
                      setState(() {
                        guojiaChoiceVisible = !guojiaChoiceVisible;
                      });
                    },
                    // guojia: guojia,
                  ),
                  Container(
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.only(left: 10, top: 5, bottom: 5),
                      child: Text(
                        isCorrect ? "" : "手机号格式不正确",
                        style:
                            TextStyle(fontSize: 10, color: Color(0xFFfd3a2e)),
                      )),
                  InputTextField(
                    placeholder: '请输入验证码',
                    security: false,
                    didChanged: (text) {
                      vifCode = text;
                      // checkInputCode();
                    },
                    // onTapVif: (a) {
                    //   print("点击了验证码哦");
                    //   if (phoneNumber == null || phoneNumber.isEmpty) {
                    //     log("请输入手机号");
                    //     return;
                    //   } else if (!isCorrect) {
                    //     log("请输入正确的手机号");
                    //     return;
                    //   }
                    // },
                  ),
                  Container(
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.only(left: 10, top: 5, bottom: 5),
                      child: Text(
                        isCorrectCode ? "" : "请输入正确的验证码",
                        style:
                            TextStyle(fontSize: 10, color: Color(0xFFfd3a2e)),
                      )),
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Text("为了您的隐私安全，信息在提交后将无法修改。",
                        style: TextStyle(height: 1.9, color: Colors.grey)),
                  ),
                  Container(
                      margin: EdgeInsets.only(bottom: 30),
                      alignment: Alignment.centerLeft,
                      child: Text("请务必如实填写，以保护您的账户安全。",
                          style: TextStyle(color: Colors.grey))),
                  GestureDetector(
                      onTap: () async {},
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(5),
                        clipBehavior: Clip.antiAlias,
                        child: Container(
                          height: 40,
                          color: const Color(0xff2C2C2E),
                          width: 200,
                          alignment: Alignment.center,
                          child: Text(
                            "提 交",
                            style: const TextStyle(
                                color: Color(0xffC1C2C4),
                                fontSize: 14,
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                      ))
                ],
              ),
            ),
            if (guojiaChoiceVisible) buildPositioned()
          ],
        ),
      ]),
    );
  }

  Positioned buildPositioned() {
    return Positioned(
      child: Container(
          alignment: Alignment.topLeft,
          child: GestureDetector(
            child: Container(
              padding: EdgeInsets.only(left: 5),
              alignment: Alignment.centerLeft,
              margin: EdgeInsetsDirectional.only(top: 30, start: 25),
              width: 48,
              height: 20,
              decoration: BoxDecoration(
                color: Color.fromRGBO(62, 63, 68, 1).withAlpha(155),
              ),
              child: Text(guojia == "中国" ? "台湾" : "中国",
                  style: TextStyle(fontSize: 10, color: Color(0XFFc1c2c4))),
            ),
            onTap: () {
              guojia = guojia == "中国" ? "台湾" : "中国";
              guojiaChoiceVisible = false;
              setState(() {});
            },
          )),
    );
  }
}
