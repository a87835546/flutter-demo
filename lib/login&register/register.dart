import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo/custom_widget/login_input_view.dart';
import 'package:flutter_demo/login&register/login_request.dart';
import 'package:flutter_demo/mine/model/user_info_model.dart';
import 'package:flutter_demo/utils/color_util.dart';
import 'package:fluttertoast/fluttertoast.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _RegisterPage();

}

class _RegisterPage extends State<RegisterPage>{
  String username = "";
  String pwd = "";
  String pwd2 = "";

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    log("width $width");
    return Scaffold(
        backgroundColor: Colors.lightBlueAccent,
        body: Container(
          width: width,
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("imgs/background-pic@3x.png"),
                  fit: BoxFit.fill)),
          child: Padding(
            padding: EdgeInsets.only(left: 62, right: 62),
            child: Container(
              color: Colors.black12,
              child: Container(
                child: Column(
                  children: [
                    const Padding(padding: EdgeInsets.only(top: 100)),
                    _createLogoView(),
                    const Padding(
                      padding: EdgeInsets.only(top: 60, bottom: 20),
                      child: Text(
                        "注册",
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                    ),
                    _createLoginByPwd(),
                    _createLoginButton(),
                    _createRememberPwd1()
                  ],
                ),
              ),
            ),
          ),
        ));
  }

  Widget _createLoginByPwd() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 10),
          child: InputTextField(
            placeholder: "6-10位字母或者数字组合",
            isFocus: true,
            maxLength: 10,
            minLength: 6,
            didChanged: (value) {
              log("user name value : $value");
              setState(() {
                username = value;
              });
            },
          ),
        ),
        Padding(
            padding: const EdgeInsets.only(top: 5),
            child: InputTextField(
              placeholder: "6-18位字母或数字组合",
              errorText: "请输入密码",
              maxLength: 18,
              minLength: 6,
              security: true,
              didChanged: (value) {
                log("password value : $value");
                setState(() {
                  pwd = value;
                });
              },
              complete: () {
                log("password input complete");
              },
            )),
        Padding(
            padding: const EdgeInsets.only(top: 5),
            child: InputTextField(
              placeholder: "请在此输入密码",
              errorText: "请在此输入密码",
              maxLength: 18,
              minLength: 6,
              security: true,
              didChanged: (value) {
                log("password value : $value");
                setState(() {
                  pwd2 = value;
                });
              },
              complete: () {
                log("password input complete");
              },
            )),
      ],
    );
  }

  Widget _createLogoView() {
    return SizedBox(
        height: 55,
        width: 180,
        child: Image.network(
          "https://img0.baidu.com/it/u=2137386184,3836304387&fm=26&fmt=auto",
          width: 180,
          fit: BoxFit.fitWidth,
        ));
  }

  Widget _createLoginButton() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(22),
      child: GestureDetector(
        onTap: () {
          if (pwd == pwd2 && pwd.length >=6 && pwd.length <= 18) {
            if (username.length >= 6 || username.length <= 10) {
              LoginRequest.registerByUsername(username, pwd).then((value) {
                log("value ----->>>>>> $value");
                if (value != null && value.runtimeType == UserInfoModel) {
                  Navigator.pop(context, true);
                } else {
                  Fluttertoast.showToast(msg: value["message"]);
                }
              }).catchError((err) {
                log("err --- >>>> $err");
              });
            }
          }
        },
        child: Container(
          alignment: Alignment.center,
          color: (pwd == pwd2 && pwd.length >=6 && pwd.length <= 18) && (username.length >= 6 || username.length <= 10)
              ? ColorUtil.mainColor()
              : ColorUtil.mainColor().withAlpha(100),
          width: 250,
          height: 44,
          child: Text(
            "注册",
            style: (pwd == pwd2 && pwd.length >=6 && pwd.length <= 18) && (username.length >= 6 || username.length <= 10)
                ? TextStyle(color: Colors.white, fontSize: 18)
                : TextStyle(
                color: ColorUtil.hexColor("0xC1C2C4"), fontSize: 18),
          ),
        ),
      ),
    );
  }

  Widget _createRememberPwd1() {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text(
              "已有账号，返回登录",
              style: TextStyle(color: Colors.white, fontSize: 12),
            ),
          ),
        ],
      ),
    );
  }
}