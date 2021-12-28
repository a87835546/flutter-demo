class UserSignInfoModel {
  num dayAmount;

  num sumAmount;

  List<TaskConfigs>? taskConfigs;

  UserSignInfoModel(
      {required this.dayAmount,
      required this.sumAmount,
      required this.taskConfigs});

  static UserSignInfoModel fromJson(Map<String, dynamic>? json) {
    List<TaskConfigs> _taskConfigs = [];
    if (json?['taskConfigs'] != null) {
      json?['taskConfigs'].forEach((v) {
        _taskConfigs.add(TaskConfigs.fromJson(v));
      });
    }
    UserSignInfoModel model = UserSignInfoModel(
        dayAmount: json?['dayAmount'],
        sumAmount: json?['sumAmount'],
        taskConfigs: _taskConfigs);
    return model;
  }

  @override
  String toString() {
    return 'UserSignInfoModel{dayAmount: $dayAmount, sumAmount: $sumAmount, taskConfigs: $taskConfigs}';
  }
}

class TaskConfigs {
  num id;
  String taskName;
  String financialCode;
  String modifyUser;
  String modifyTime;
  num available;
  String rule;
  String openingtime;
  Null financialCodeName;
  num isBlacklist;
  Null activityDtos;
  Null qdTime;
  Null qdNumber;
  Null upgradeAwards;
  Null accountInfoDto;
  Null taskTimeDto;
  RewardDto? rewardDto;

  TaskConfigs(
      {required this.id,
      required this.taskName,
      required this.financialCode,
      required this.modifyUser,
      required this.modifyTime,
      required this.available,
      required this.rule,
      required this.openingtime,
      required this.financialCodeName,
      required this.isBlacklist,
      required this.activityDtos,
      required this.qdTime,
      required this.qdNumber,
      required this.upgradeAwards,
      required this.accountInfoDto,
      required this.taskTimeDto,
      required this.rewardDto});

  static TaskConfigs fromJson(Map<String, dynamic> json) {
    RewardDto? dto = json['rewardDto'] != null
        ? RewardDto.fromJson(json['rewardDto'])
        : null;

    TaskConfigs configs = TaskConfigs(
        id: json['id'],
        taskName: json['taskName'],
        financialCode: json['financialCode'],
        modifyUser: json['modifyUser'],
        modifyTime: json['modifyTime'],
        available: json['available'],
        rule: json['rule'],
        openingtime: json['openingtime'],
        financialCodeName: json['financialCodeName'],
        isBlacklist: json['isBlacklist'],
        activityDtos: json['activityDtos'],
        qdTime: json['qdTime'],
        qdNumber: json['qdNumber'],
        upgradeAwards: json['upgradeAwards'],
        accountInfoDto: json['accountInfoDto'],
        taskTimeDto: json['taskTimeDto'],
        rewardDto: dto);
    return configs;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['taskName'] = taskName;
    data['financialCode'] = financialCode;
    data['modifyUser'] = modifyUser;
    data['modifyTime'] = modifyTime;
    data['available'] = available;
    data['rule'] = rule;
    data['openingtime'] = openingtime;
    data['financialCodeName'] = financialCodeName;
    data['isBlacklist'] = isBlacklist;
    data['activityDtos'] = activityDtos;
    data['qdTime'] = qdTime;
    data['qdNumber'] = qdNumber;
    data['upgradeAwards'] = upgradeAwards;
    data['accountInfoDto'] = accountInfoDto;
    data['taskTimeDto'] = taskTimeDto;
    if (rewardDto != null) {
      data['rewardDto'] = rewardDto!.toJson();
    }
    return data;
  }

  @override
  String toString() {
    return 'TaskConfigs{id: $id, taskName: $taskName, financialCode: $financialCode, modifyUser: $modifyUser, modifyTime: $modifyTime, available: $available, rule: $rule, openingtime: $openingtime, financialCodeName: $financialCodeName, isBlacklist: $isBlacklist, activityDtos: $activityDtos, qdTime: $qdTime, qdNumber: $qdNumber, upgradeAwards: $upgradeAwards, accountInfoDto: $accountInfoDto, taskTimeDto: $taskTimeDto, rewardDto: $rewardDto}';
  }
}

class RewardDto {
  bool isName;
  bool isBank;
  bool isMobile;
  bool isMail;
  num? multipleWater;
  num? cycle;
  List<FilesDtos> filesDtos;
  String memo;
  String day;
  num? number;
  num? dayDepositAmount;
  num? dayValidbet;
  AccountInfoDto? accountInfoDto;
  List<TaskBonuses> taskBonuses;

  RewardDto(
      {required this.isName,
      required this.isBank,
      required this.isMobile,
      required this.isMail,
      required this.multipleWater,
      required this.cycle,
      required this.filesDtos,
      required this.memo,
      required this.day,
      required this.number,
      required this.dayDepositAmount,
      required this.dayValidbet,
      required this.accountInfoDto,
      required this.taskBonuses});

  static RewardDto fromJson(Map<String, dynamic> json) {
    List<FilesDtos> _filesDtos = [];
    if (json['filesDtos'] != null) {
      json['filesDtos'].forEach((v) {
        _filesDtos.add(FilesDtos.fromJson(v));
      });
    }

    AccountInfoDto? _accountInfoDto = json['accountInfoDto'] != null
        ? AccountInfoDto.fromJson(json['accountInfoDto'])
        : null;

    List<TaskBonuses> _taskBonuses = [];
    if (json['taskBonuses'] != null) {
      json['taskBonuses'].forEach((v) {
        _taskBonuses.add(TaskBonuses.fromJson(v));
      });
    }
    RewardDto dto = RewardDto(
        isName: json['isName'],
        isBank: json['isBank'],
        isMobile: json['isMobile'],
        isMail: json['isMail'],
        multipleWater: json['multipleWater'],
        cycle: json['cycle'],
        filesDtos: _filesDtos,
        memo: json['memo'],
        day: json['day'],
        number: json['num'],
        dayDepositAmount: json['dayDepositAmount'],
        dayValidbet: json['dayValidbet'],
        accountInfoDto: _accountInfoDto,
        taskBonuses: _taskBonuses);
    return dto;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['isName'] = isName;
    data['isBank'] = isBank;
    data['isMobile'] = isMobile;
    data['isMail'] = isMail;
    data['multipleWater'] = multipleWater;
    data['cycle'] = cycle;
    if (filesDtos != null) {
      data['filesDtos'] = filesDtos.map((v) => v.toJson()).toList();
    }
    data['memo'] = memo;
    data['day'] = day;
    data['num'] = num;
    data['dayDepositAmount'] = dayDepositAmount;
    data['dayValidbet'] = dayValidbet;
    if (accountInfoDto != null) {
      data['accountInfoDto'] = accountInfoDto!.toJson();
    }
    if (taskBonuses != null) {
      data['taskBonuses'] = taskBonuses.map((v) => v.toJson()).toList();
    }
    return data;
  }

  @override
  String toString() {
    return 'RewardDto{isName: $isName, isBank: $isBank, isMobile: $isMobile, isMail: $isMail, multipleWater: $multipleWater, cycle: $cycle, filesDtos: $filesDtos, memo: $memo, day: $day, num: $num, dayDepositAmount: $dayDepositAmount, dayValidbet: $dayValidbet, accountInfoDto: $accountInfoDto, taskBonuses: $taskBonuses}';
  }
}

class FilesDtos {
  num number;
  num depositAmount;
  num validBet;
  List<DayDtoList> dayDtoList;

  FilesDtos(
      {required this.number,
      required this.depositAmount,
      required this.validBet,
      required this.dayDtoList});

  static FilesDtos fromJson(Map<String, dynamic> json) {
    List<DayDtoList> _dayDtoList = [];
    if (json['dayDtoList'] != null) {
      json['dayDtoList'].forEach((v) {
        _dayDtoList.add(DayDtoList.fromJson(v));
      });
    }
    FilesDtos dtos = FilesDtos(
        number: json['num'],
        depositAmount: json['depositAmount'],
        validBet: json['validBet'],
        dayDtoList: _dayDtoList);
    return dtos;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['num'] = num;
    data['depositAmount'] = depositAmount;
    data['validBet'] = validBet;
    if (dayDtoList != null) {
      data['dayDtoList'] = dayDtoList.map((v) => v.toJson()).toList();
    }
    return data;
  }

  @override
  String toString() {
    return 'FilesDtos{num: $num, depositAmount: $depositAmount, validBet: $validBet, dayDtoList: $dayDtoList}';
  }
}

class DayDtoList {
  num day;
  num bonusAmount;

  DayDtoList({required this.day, required this.bonusAmount});

  static DayDtoList fromJson(Map<String, dynamic> json) {
    DayDtoList list =
        DayDtoList(day: json['day'], bonusAmount: json['bonusAmount']);
    return list;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['day'] = day;
    data['bonusAmount'] = bonusAmount;
    return data;
  }

  @override
  String toString() {
    return 'DayDtoList{day: $day, bonusAmount: $bonusAmount}';
  }
}

class AccountInfoDto {
  bool isName;
  bool isBank;
  bool isMobile;
  bool isMail;

  AccountInfoDto(
      {required this.isName,
      required this.isBank,
      required this.isMobile,
      required this.isMail});

  static AccountInfoDto fromJson(Map<String, dynamic> json) {
    AccountInfoDto dto = AccountInfoDto(
      isName: json['isName'],
      isBank: json['isBank'],
      isMobile: json['isMobile'],
      isMail: json['isMail'],
    );
    return dto;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['isName'] = isName;
    data['isBank'] = isBank;
    data['isMobile'] = isMobile;
    data['isMail'] = isMail;
    return data;
  }

  @override
  String toString() {
    return 'AccountInfoDto{isName: $isName, isBank: $isBank, isMobile: $isMobile, isMail: $isMail}';
  }
}

class TaskBonuses {
  num id;
  num accountId;
  String loginName;
  num bonusAmount;
  num discountAudit;
  num configId;
  String time;
  num number1;
  String orderNo;
  Null taskName;
  Null receiveNum;
  Null number;
  Null cagencyId;
  Null startTime;
  Null endTime;
  Null isCagency;
  Null agyAccount;
  Null financialcode;

  TaskBonuses(
      {required this.id,
      required this.accountId,
      required this.loginName,
      required this.bonusAmount,
      required this.discountAudit,
      required this.configId,
      required this.time,
      required this.number1,
      required this.orderNo,
      required this.taskName,
      required this.receiveNum,
      required this.number,
      required this.cagencyId,
      required this.startTime,
      required this.endTime,
      required this.isCagency,
      required this.agyAccount,
      required this.financialcode});

  static TaskBonuses fromJson(Map<String, dynamic> json) {
    TaskBonuses taskBonuses = TaskBonuses(
      id: json['id'],
      accountId: json['accountId'],
      loginName: json['loginName'],
      bonusAmount: json['bonusAmount'],
      discountAudit: json['discountAudit'],
      configId: json['configId'],
      time: json['time'],
      number1: json['num'],
      orderNo: json['orderNo'],
      taskName: json['taskName'],
      receiveNum: json['receiveNum'],
      number: json['number'],
      cagencyId: json['cagencyId'],
      startTime: json['startTime'],
      endTime: json['endTime'],
      isCagency: json['isCagency'],
      agyAccount: json['agyAccount'],
      financialcode: json['financialcode'],
    );
    return taskBonuses;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['accountId'] = accountId;
    data['loginName'] = loginName;
    data['bonusAmount'] = bonusAmount;
    data['discountAudit'] = discountAudit;
    data['configId'] = configId;
    data['time'] = time;
    data['num'] = num;
    data['orderNo'] = orderNo;
    data['taskName'] = taskName;
    data['receiveNum'] = receiveNum;
    data['number'] = number;
    data['cagencyId'] = cagencyId;
    data['startTime'] = startTime;
    data['endTime'] = endTime;
    data['isCagency'] = isCagency;
    data['agyAccount'] = agyAccount;
    data['financialcode'] = financialcode;
    return data;
  }

  @override
  String toString() {
    return 'TaskBonuses{id: $id, accountId: $accountId, loginName: $loginName, bonusAmount: $bonusAmount, discountAudit: $discountAudit, configId: $configId, time: $time, num: $num, orderNo: $orderNo, taskName: $taskName, receiveNum: $receiveNum, number: $number, cagencyId: $cagencyId, startTime: $startTime, endTime: $endTime, isCagency: $isCagency, agyAccount: $agyAccount, financialcode: $financialcode}';
  }
}
