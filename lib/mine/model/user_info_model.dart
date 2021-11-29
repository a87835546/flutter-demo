class UserInfoModel {
  late final bool? gender;
  final num? birthday;
  final num? userId;
  final String? loginName;
  final String? nickName;
  final String? depositLock;
  final String? realName;
  final num? registerTime;
  final String? available;
  final String? balance;
  final String? mobile;
  final String? email;
  final String? weChat;
  final String? qq;
  final String? userInfoMeasure;

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
  });

  static UserInfoModel jsonToObject(Map<String, dynamic> map) {
    UserInfoModel model = UserInfoModel(
      gender: map['gender'],
      birthday: map['birthday'],
      userId: map['id'],
      loginName: map['username'],
      nickName: map['nickName'],
      depositLock: map['depositLock'],
      realName: map['realName'],
      registerTime: map['createTime'],
      balance: map['balance'],
      available: map['available'],
      mobile: map['mobile'],
      email: map['email'],
      weChat: map['weChat'],
      qq: map['qq'],
      userInfoMeasure: map['userInfoMeasure'],
    );
    return model;
  }

  @override
  String toString() {
    return 'UserInfoModel{gender: $gender, birthday: $birthday, userId: $userId, loginName: $loginName, nickName: $nickName, depositLock: $depositLock, realName: $realName, registerTime: $registerTime, available: $available, balance: $balance, mobile: $mobile, email: $email, weChat: $weChat, qq: $qq, userInfoMeasure: $userInfoMeasure}';
  }
}
