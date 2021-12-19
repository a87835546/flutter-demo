import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_demo/custom_widget/login_input_view.dart';
import 'package:flutter_demo/custom_widget/switch_button.dart';
import 'package:flutter_demo/login&register/login_request.dart';
import 'package:flutter_demo/login&register/register.dart';
import 'package:flutter_demo/mine/model/user_info_model.dart';
import 'package:flutter_demo/utils/app_singleton.dart';
import 'package:flutter_demo/utils/color_util.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool pwdHasValid = false;
  bool userHasValid = false;
  bool phoneHasValid = false;
  bool codeHasValid = false;
  bool usePwdLogin = true;
  String username = "";
  String pwd = "";
  String phone = "";
  String code = "";

  @override
  void dispose() {
    super.dispose();
    SystemChannels.textInput.invokeMethod(
        'TextInput.hide');
  }
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.lightBlueAccent,
      resizeToAvoidBottomInset: false,
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
              alignment: Alignment.center,
              child: Stack(
                children: [
                  Column(
                    children: [
                      const Padding(padding: EdgeInsets.only(top: 100)),
                      _createLogoView(),
                      const Padding(
                        padding: EdgeInsets.only(top: 60, bottom: 20),
                        child: Text(
                          "登录",
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                      ),
                      SwitchButton(
                        titles: const ["密码登录", "手机登录"],
                        switchButtonClick: (title) {
                          log("click $title");
                          setState(() {
                            usePwdLogin = title == "密码登录";
                          });
                        },
                      ),
                      usePwdLogin ? _createLoginByPwd() : _createLoginByPhone(),
                      _createLoginButton(),
                      _createRememberPwd1()
                    ],
                  ),
                  Positioned(
                    child: IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Image.asset(
                          "imgs/images/icon-back@3x.png",
                          width: 20,
                          height: 20,
                          fit: BoxFit.fitWidth,
                        )),
                    left: 0,
                    top: 50,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _createLoginByPwd() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 20),
          child: InputTextField(
            placeholder: "用户名",
            isFocus: true,
            didChanged: (value) {
              log("user name value : $value");
              setState(() {
                userHasValid = value.length >= 6;
                username = value;
              });
            },
          ),
        ),
        Padding(
            padding: const EdgeInsets.only(top: 20),
            child: InputTextField(
              placeholder: "密码",
              security: true,
              didChanged: (value) {
                log("password value : $value");
                setState(() {
                  pwdHasValid = value.length >= 6;
                  pwd = value;
                });
              },
              complete: () {
                log("password input complete");
              },
            )),
        Padding(
          padding: EdgeInsets.only(top: 0),
          child: _createRememberPwd(),
        ),
      ],
    );
  }

  Widget _createLoginByPhone() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 20),
          child: InputTextField(
            placeholder: "手机号",
            maxLength: 11,
            isFocus: true,
            didChanged: (value) {
              log("phone num value : $value");
              setState(() {
                phoneHasValid = value.length >= 11;
                phone = value;
              });
            },
          ),
        ),
        Padding(
            padding: const EdgeInsets.only(top: 20),
            child: InputTextField(
              placeholder: "验证码",
              security: true,
              maxLength: 6,
              didChanged: (value) {
                log("verity code value : $value");
                setState(() {
                  codeHasValid = value.length >= 6;
                  code = value;
                });
              },
              complete: () {
                log("password input complete");
              },
            )),
        Padding(
          padding: EdgeInsets.only(top: 10),
        ),
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

  Widget _createRememberPwd() {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TextButton.icon(
              onPressed: () {},
              icon: const Icon(
                Icons.person,
                color: Colors.white,
                size: 13,
              ),
              label: const Text(
                "记住密码",
                style: TextStyle(color: Colors.white, fontSize: 13),
              )),
          TextButton(
            onPressed: () {},
            child: const Text(
              "忘记密码？",
              style: TextStyle(color: Colors.white, fontSize: 13),
            ),
          )
        ],
      ),
    );
  }

  Widget _createLoginButton() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(22),
      child: GestureDetector(
        onTap: () {
          if (usePwdLogin) {
            if (userHasValid && pwdHasValid) {
              LoginRequest.loginByUsername(username, pwd).then((value) {
                log("value ----->>>>>> $value");
                if (value != null && value.runtimeType == UserInfoModel) {
                  setState(() {
                    AppSingleton.setUserInfoModel(value as UserInfoModel);
                  });
                  Navigator.pop(context, true);
                } else {
                  Fluttertoast.showToast(msg: value["message"]);
                }
              }).catchError((err) {
                log("err --- >>>> $err");
              });
            }
          } else {
            if (phoneHasValid && codeHasValid) {
              LoginRequest.loginByPhone(phone, code).then((value) {
                log("value ----->>>>>> $value");
                if (value != null && value['code'] == 200) {
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
          color: userHasValid && pwdHasValid
              ? ColorUtil.mainColor()
              : ColorUtil.mainColor().withAlpha(100),
          width: 250,
          height: 44,
          child: Text(
            "登录",
            style: userHasValid && pwdHasValid
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
            onPressed: () {},
            child: const Text(
              "先去逛逛",
              style: TextStyle(color: Colors.white, fontSize: 13),
            ),
          ),
          TextButton(
            onPressed: () async {
              bool result = await Navigator.push(context,
                  MaterialPageRoute(builder: (context) {
                return const RegisterPage();
              }));
              if (result) {
                Navigator.pop(context, true);
              }
            },
            child: const Text(
              "没有账号立即注册",
              style: TextStyle(color: Colors.white, fontSize: 13),
            ),
          )
        ],
      ),
    );
  }
}
