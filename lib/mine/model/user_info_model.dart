
class UserInfoModel {
  late final bool gender;
  final DateTime birthday;
  final int userId;
  final String loginName;
  final String nickName;
  final String depositLock;
  final String realName;
  final String registerTime;
  final int available;
  final double balance;
  final String mobile;
  final String email;
  final String weChat;
  final String qq;
  final String userInfoMeasure;
  final String groupName;
  final String mbrLevel;
  final String levelName;
  final String freeWalletSwitch;
  final String settlementSwitch;
  final String settlementBtnShow;
  final String egSanGongFlg;
  final String egSanGong;
  final String egSanGongPromotionUrl;
  final String depositCondition;
  final String withdrawCondition;
  final String withDrawalAudit;

  UserInfoModel({
      required this.gender,
      required this.birthday,
      required this.userId,
      required this.loginName,
      required this.nickName,
      required this.depositLock,
      required this.realName,
      required this.registerTime,
      required this.balance,
      required this.available,
      required this.mobile,
      required this.email,
      required this.weChat,
      required this.qq,
      required this.userInfoMeasure,
      required this.groupName,
      required this.mbrLevel,
      required this.levelName,
      required this.freeWalletSwitch,
      required this.settlementSwitch,
      required this.settlementBtnShow,
      required this.egSanGongFlg,
      required this.egSanGong,
      required this.egSanGongPromotionUrl,
      required this.depositCondition,
      required this.withdrawCondition,
      required this.withDrawalAudit});
  
  static UserInfoModel jsonToObject(Map<String,dynamic> map){
    UserInfoModel model = UserInfoModel(
      gender: map['gender'],
      birthday: map['birthday'],
      userId: map['userId'],
      loginName: map['loginName'],
      nickName: map['nickName'],
      depositLock: map['depositLock'],
      realName: map['realName'],
      registerTime: map['registerTime'],
      balance : map['balance'],
      available: map['available'],
      mobile: map['mobile'],
      email: map['email'],
      weChat: map['weChat'],
      qq: map['qq'],
      userInfoMeasure: map['userInfoMeasure'],
      groupName: map['groupName'],
      mbrLevel: map['mbrLevel'],
      levelName: map['levelName'],
      freeWalletSwitch: map['freeWalletSwitch'],
      settlementSwitch: map['settlementSwitch'],
      settlementBtnShow: map['settlementBtnShow'],
      egSanGongFlg: map['egSanGongFlg'],
      egSanGong: map['egSanGong'],
      egSanGongPromotionUrl: map['egSanGongPromotionUrl'],
      depositCondition: map['depositCondition'],
      withdrawCondition: map['withdrawCondition'],
      withDrawalAudit: map['withDrawalAudit'],
    );
    return model;
  }
}