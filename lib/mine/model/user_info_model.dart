class UserInfoModel {
  late bool? gender;
  final String? birthday;
  final String avatar;
  final num? userId;
  final String? loginName;
  final String? nickName;
  final String? depositLock;
  final String? realName;
  final String? registerTime;
  final String? available;
  final String? balance;
  final String? mobile;
  final String? email;
  final String? weChat;
  final String? qq;
  final String? userInfoMeasure;
  final String? token;

  UserInfoModel({
    required this.avatar,
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
    this.token
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
      token: map['token'],
      avatar: map['avatar'],
    );
    return model;
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = userId;
    data['gender'] = gender;
    data['birthday'] = birthday;
    data['username'] = loginName;
    data['depositLock'] = depositLock;
    data['available'] = available;
    data['realName'] = realName;
    data['createTime'] = registerTime;
    data['balance'] = balance;
    data['mobile'] = mobile;
    data['email'] = email;
    data['weChat'] = weChat;
    data['qq'] = qq;
    data['userInfoMeasure'] = userInfoMeasure;
    data['token'] = token;
    data['avatar'] = avatar;
    return data;
  }

  @override
  String toString() {
    return 'UserInfoModel{gender: $gender, birthday: $birthday, avatar: $avatar, userId: $userId, loginName: $loginName, nickName: $nickName, depositLock: $depositLock, realName: $realName, registerTime: $registerTime, available: $available, balance: $balance, mobile: $mobile, email: $email, weChat: $weChat, qq: $qq, userInfoMeasure: $userInfoMeasure, token: $token}';
  }
}
