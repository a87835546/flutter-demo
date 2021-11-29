class UserVipInfoModel {
  late final int accountLevel;

  late final int downgradePromotion;

  late final int downgradePromotionDay;

  late final String tierName;
  late final String loginName;

  UserVipInfoModel({required
      this.accountLevel, required this.downgradePromotion,required this.downgradePromotionDay,required this.tierName,required this.loginName});

  static UserVipInfoModel jsonToObject(Map<String,dynamic>? map){
    UserVipInfoModel model = UserVipInfoModel(
      accountLevel: map?['accountLevel'],
      downgradePromotion: map?['downgradePromotion'],
      downgradePromotionDay: map?['downgradePromotionDay'],
      tierName: map?['tierName'],
      loginName: map?['loginName'],
    );
    return model;
  }

  @override
  String toString() {
    return 'UserVipInfoModel{accountLevel: $accountLevel, downgradePromotion: $downgradePromotion, downgradePromotionDay: $downgradePromotionDay, tierName: $tierName, loginName: $loginName}';
  }
}