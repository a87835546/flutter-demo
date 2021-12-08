import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo/mine/model/user_info_model.dart';
import 'package:flutter_demo/utils/app_singleton.dart';
import 'package:flutter_demo/utils/color_util.dart';
import 'package:flutter_demo/utils/http_manager.dart';

class UserInfoPage extends StatefulWidget {
  final UserInfoModel? model;
  const UserInfoPage({Key? key,this.model}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _UserInfoPageState();
}

class _UserInfoPageState extends State<UserInfoPage> {
  List _list1 = ['用户名','昵称','真实姓名','性别'];
  List _list2 = ['出生日期','手机号码','邮箱'];
  var _avatar = '';
  var _nickname = '';
  var _realName = '';
  bool _gender = true;
  var _birthday = '';
  var _phone = '';
  var _email = '';
  var _pwd = '';
  @override
  Widget build(BuildContext context) {
    log('app user info ${AppSingleton.userInfoModel}');
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '个人资料',
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xff252626),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Image.asset(
              "imgs/mine/images/icon-customer-service@3x.png",
              width: 40,
              height: 24,
            ),
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
            gradient:
                LinearGradient(colors: [Color(0xff1A1A1C), Color(0xff202123)])),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(left: 14, right: 14, top: 10),
              child: GestureDetector(
                child: Container(
                    height: 68,
                    decoration: BoxDecoration(
                      color: Color(0xff2C2C2E),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child:  Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 12),
                          child: Text(
                            "头像",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.only(right: 12),
                            child: GestureDetector(
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: Container(
                                  alignment: Alignment.centerRight,
                                  child:(AppSingleton.userInfoModel?.avatar.length != 1) ? Image.network("${AppSingleton.userInfoModel?.avatar}",width: 40,
                                    height: 40,):Image.asset(
                                    "imgs/mine/images/tx_icon@3x.png",
                                    width: 40,
                                    height: 40,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    )
                ),
                onTap: (){
                  log('modify avatar');modifyAvatar();
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 14, right: 14, top: 10),
              child: Container(
                height: 183,
                decoration: BoxDecoration(
                  color: Color(0xff2C2C2E),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: ListView.separated(
                    itemBuilder: (_, index) {
                      return GestureDetector(child: Container(
                        height: 180 / 4,
                        child: Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(left: 12),
                              child: Text(
                                _list1[index],
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                padding: EdgeInsets.only(right: 10),
                                alignment: Alignment.centerRight,
                                child: Text([AppSingleton.userInfoModel?.loginName??_nickname,AppSingleton.userInfoModel?.realName??_realName,AppSingleton.userInfoModel?.realName??_realName,AppSingleton.userInfoModel?.gender??_gender?"男":"女"][index],style: TextStyle(color: Colors.white),),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(right: 12),
                              child: GestureDetector(
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: Container(
                                    alignment: Alignment.centerRight,
                                    child: Image.asset(
                                      "imgs/mine/images/iocn-Unfold@3x.png",
                                      width: 10,
                                      height: 18,
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),onTap: (){
                        log(_list1[index]);
                        switch (index){
                          case 0:{
                            modifyNickName();
                            break;
                          }
                          case 1:{
                            break;
                          }
                          case 2:{
                            modifyRealName();
                            break;
                          }
                          case 3:{
                            modifyGender();
                            break;
                          }
                        }
                      },);
                    },
                    separatorBuilder: (_, index) {
                      return Divider(
                        color: Colors.white38,
                        height: 1,
                      );
                    },
                    itemCount: 4,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics()),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 14, right: 14, top: 10),
              child: Container(
                height: 45 * 3 + 2,
                decoration: BoxDecoration(
                  color: Color(0xff2C2C2E),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: ListView.separated(
                    itemBuilder: (_, index) {
                      return GestureDetector(child: Container(
                        height: 45,
                        child: Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(left: 12),
                              child: Text(
                                _list2[index],
                                style: TextStyle(color: Colors.white),
                              ),
                            ),

                            Expanded(
                              child: Container(
                                padding: EdgeInsets.only(right: 10),
                                alignment: Alignment.centerRight,
                                child: Text([AppSingleton.userInfoModel?.birthday??_birthday,AppSingleton.userInfoModel?.mobile??_phone,AppSingleton.userInfoModel?.email??_email][index],style: TextStyle(color: Colors.white)),
                              )
                            ),
                            Padding(
                              padding: EdgeInsets.only(right: 12),
                              child: GestureDetector(
                                child: ClipRRect(
                                  child: Container(
                                    alignment: Alignment.centerRight,
                                    child: Image.asset(
                                      "imgs/mine/images/iocn-Unfold@3x.png",
                                      width: 10,
                                      height: 18,
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),onTap: (){
                        log(_list2[index]);
                        switch (index) {
                          case 0:{
                            modifyBirthday();
                            break;
                          }
                          case 1:{
                            modifyPhone();
                            break;
                          }
                          case 2:{
                            modifyEmail();
                            break;
                          }
                        }
                      },
                        behavior: HitTestBehavior.opaque,
                      );
                    },
                    separatorBuilder: (_, index) {
                      return Divider(
                        color: Colors.white38,
                        height: 1,
                      );
                    },
                    itemCount: 3,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics()),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 14, right: 14, top: 10),
              child: GestureDetector(
                child: Container(
                  height: 40,
                  decoration: BoxDecoration(
                    color: Color(0xff2C2C2E),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 12),
                        child: Text(
                          "修改密码",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(right: 12),
                          child: GestureDetector(
                            child: ClipRRect(
                              child: Container(
                                alignment: Alignment.centerRight,
                                child: Image.asset(
                                  "imgs/mine/images/iocn-Unfold@3x.png",
                                  width: 10,
                                  height: 18,
                                ),
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                onTap: (){
                  log('modify password');
                  modifyPwd();
                },
              ),
            ),
            Padding(padding: EdgeInsets.only(left: 10,right: 10,top: 10),child: RichText(
              text: TextSpan(
                text: '为了您的隐私安全，信息在确认后将无法修改需要帮助，请联系客服',
                style: TextStyle(
                  color: Color(0xffC1C2C4)
                ),
                children: [
                  TextSpan(text: '联系客服',style: TextStyle(color: ColorUtil.mainColor()))
                ]
              ),
            ),),
            Padding(padding: EdgeInsets.only(top: 20,left: 35,right: 35),child: GestureDetector(child: Container(
              height: 45,
              alignment: Alignment.center,
              width: double.maxFinite,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(22.5),
                // gradient: LinearGradient(
                //   colors: [Color(0xff1A1A1C),Color(0xff202123)]
                // ),
                  color:Color(0xff2C2C2E)
              ),
              child: Text("退出",style: TextStyle(color: Colors.white),),
            ),onTap: (){
              log('log out');
            },behavior: HitTestBehavior.opaque,),),
          ],
        ),
      ),
    );
  }
  void modifyAvatar() async{
    await HttpManager.post(url: "user/modifyAvatar", params: {'url':'https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fimg.zcool.cn%2Fcommunity%2F01218f554229710000019ae9631440.jpg'}).then((value){
      if(value['code'] == 200){
        UserInfoModel model = UserInfoModel.jsonToObject(value['data']);
        setState(() {
          _avatar = model.avatar;
        });
        getUserInfo();
        log("$model");
      }
    });
  }

  void modifyNickName() async{
    await HttpManager.post(url: "user/modifyNickName", params: {'nickname':'12312'}).then((value){
      if(value['code'] == 200){
        UserInfoModel model = UserInfoModel.jsonToObject(value['data']);
        setState(() {
          _nickname = model.nickName??"";
        });
        log("$model");
      }
    });
  }

  void modifyRealName() async{
    await HttpManager.post(url: "user/modifyRealName", params: {'url':''}).then((value){
      if(value['code'] == 200){
        UserInfoModel model = UserInfoModel.jsonToObject(value['data']);
        setState(() {
          _realName = model.realName??"";
        });
        log("$model");
      }
    });
  }

  void modifyGender() async{
    await HttpManager.post(url: "user/modifyGender", params: {'gender':_gender.toString()}).then((value){
      if(value['code'] == 200){
        UserInfoModel model = UserInfoModel.jsonToObject(value['data']);
        setState(() {
          _gender = model.gender??true;
        });
        log("$model");
      }
    });
  }

  void modifyBirthday() async{
    await HttpManager.post(url: "user/modifyBirthday", params: {'birthday':_birthday}).then((value){
      if(value['code'] == 200){
        UserInfoModel model = UserInfoModel.jsonToObject(value['data']);
        setState(() {
          _birthday = model.birthday??"";
        });
        log("$model");
      }
    });
  }

  void modifyPhone() async{
    await HttpManager.post(url: "user/modifyPhone", params: {'phone':'13800138000'}).then((value){
      if(value['code'] == 200){
        UserInfoModel model = UserInfoModel.jsonToObject(value['data']);
        setState(() {
          _phone = model.mobile??"";
        });
        log("$model");
      }
    });
  }

  void modifyEmail() async{
    await HttpManager.post(url: "user/modifyEmail", params: {'url':''}).then((value){
      if(value['code'] == 200){
        UserInfoModel model = UserInfoModel.jsonToObject(value['data']);
        setState(() {
          _email = model.email??"";
        });
        log("$model");
      }
    });
  }

  void modifyPwd() async{
    await HttpManager.post(url: "user/modifyPwd", params: {'password':''}).then((value){
      if(value['code'] == 200){
        UserInfoModel model = UserInfoModel.jsonToObject(value['data']);
        getUserInfo();
        log("$model");
      }
    });
  }

  void getUserInfo(){
    HttpManager.get(url:"/user/queryUserInfo")
        .then((result) {
      try {
        UserInfoModel model = UserInfoModel.jsonToObject(result['data']);
        setState(() {
          AppSingleton.userInfoModel = model;
          AppSingleton.setUserInfoModel(model);
        });
      } catch (err) {
        log("parser user sign info err:${err.toString()}");
      } finally {
      }
    }).whenComplete(() {
    });
  }
}

