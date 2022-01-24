class BannerAndMaqueeModel {
  String? msg;
  NoticeList? noticeList;
  int? code;
  List<Page>? page;
//  List<Null>? popUpList;

  BannerAndMaqueeModel(
      {this.msg, this.noticeList, this.code, this.page});

  BannerAndMaqueeModel.fromJson(Map<String, dynamic> json) {
    msg = json['msg'];
    noticeList = json['noticeList'] != null
        ? new NoticeList.fromJson(json['noticeList'])
        : null;
    code = json['code'];
    if (json['page'] != null) {
      page = new List<Page>.empty(growable: true);
      json['page'].forEach((v) {
        page?.add(new Page.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['msg'] = this.msg;
    if (this.noticeList != null) {
      data['noticeList'] = this.noticeList?.toJson();
    }
    data['code'] = this.code;
    if (this.page != null) {
      data['page'] = this.page?.map((v) => v.toJson()).toList();
    }
//    if (this.popUpList != null) {
//      data['popUpList'] = this.popUpList?.map((v) => v.toJson()).toList();
//    }
    return data;
  }

  @override
  String toString() {
    return 'BannerAndMaqueeModel{msg: $msg, noticeList: $noticeList, code: $code, page: $page}';
  }
}

class NoticeList {
  int? totalCount;
  int? pageSize;
  int? totalPage;
  int? currPage;
  List<List1>? list;
  int? pageTotalCount;

  NoticeList(
      {this.totalCount,
        this.pageSize,
        this.totalPage,
        this.currPage,
        this.list,
        this.pageTotalCount});

  NoticeList.fromJson(Map<String, dynamic> json) {
    totalCount = json['totalCount'];
    pageSize = json['pageSize'];
    totalPage = json['totalPage'];
    currPage = json['currPage'];
    if (json['list'] != null) {
      list = new List<List1>.empty(growable: true);
      json['list'].forEach((v) {
        list?.add(new List1.fromJson(v));
      });
    }
    pageTotalCount = json['pageTotalCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['totalCount'] = this.totalCount;
    data['pageSize'] = this.pageSize;
    data['totalPage'] = this.totalPage;
    data['currPage'] = this.currPage;
    if (this.list != null) {
      data['list'] = this.list?.map((v) => v.toJson()).toList();
    }
    data['pageTotalCount'] = this.pageTotalCount;
    return data;
  }

  @override
  String toString() {
    return 'NoticeList{totalCount: $totalCount, pageSize: $pageSize, totalPage: $totalPage, currPage: $currPage, list: $list, pageTotalCount: $pageTotalCount}';
  }
}

class List1 {
  int? id;
  Null ids;
  String? noticeTitle;
  String? noticeContent;
  String? startTime;
  String? endTime;
  String? showType;
  int? available;
  String? createUser;
  String? createTime;
  String? updateUser;
  String? updateTime;
  Null createStart;
  Null createEnd;
  Null availables;
  Null showTypes;

  List1(
      {this.id,
        this.ids,
        this.noticeTitle,
        this.noticeContent,
        this.startTime,
        this.endTime,
        this.showType,
        this.available,
        this.createUser,
        this.createTime,
        this.updateUser,
        this.updateTime,
        this.createStart,
        this.createEnd,
        this.availables,
        this.showTypes});

  List1.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    ids = json['ids'];
    noticeTitle = json['noticeTitle'];
    noticeContent = json['noticeContent'];
    startTime = json['startTime'];
    endTime = json['endTime'];
    showType = json['showType'];
    available = json['available'];
    createUser = json['createUser'];
    createTime = json['createTime'];
    updateUser = json['updateUser'];
    updateTime = json['updateTime'];
    createStart = json['createStart'];
    createEnd = json['createEnd'];
    availables = json['availables'];
    showTypes = json['showTypes'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['ids'] = this.ids;
    data['noticeTitle'] = this.noticeTitle;
    data['noticeContent'] = this.noticeContent;
    data['startTime'] = this.startTime;
    data['endTime'] = this.endTime;
    data['showType'] = this.showType;
    data['available'] = this.available;
    data['createUser'] = this.createUser;
    data['createTime'] = this.createTime;
    data['updateUser'] = this.updateUser;
    data['updateTime'] = this.updateTime;
    data['createStart'] = this.createStart;
    data['createEnd'] = this.createEnd;
    data['availables'] = this.availables;
    data['showTypes'] = this.showTypes;
    return data;
  }

  @override
  String toString() {
    return 'List1{id: $id, ids: $ids, noticeTitle: $noticeTitle, noticeContent: $noticeContent, startTime: $startTime, endTime: $endTime, showType: $showType, available: $available, createUser: $createUser, createTime: $createTime, updateUser: $updateUser, updateTime: $updateTime, createStart: $createStart, createEnd: $createEnd, availables: $availables, showTypes: $showTypes}';
  }
}

class Page {
  Null evebNum;
  int? clientShow;
  Null advType;
  int? picTarget;
  Null actId;
  Null activityId;
  Null outStation;
  Null path;
  String? picPcPath;
  String? picMbPath;
  Null title;
  Null inType;
  Null inPageType;

  Page(
      {this.evebNum,
        this.clientShow,
        this.advType,
        this.picTarget,
        this.actId,
        this.activityId,
        this.outStation,
        this.path,
        this.picPcPath,
        this.picMbPath,
        this.title,
        this.inType,
        this.inPageType});

  Page.fromJson(Map<String, dynamic> json) {
    evebNum = json['evebNum'];
    clientShow = json['clientShow'];
    advType = json['advType'];
    picTarget = json['picTarget'];
    actId = json['actId'];
    activityId = json['activityId'];
    outStation = json['outStation'];
    path = json['path'];
    picPcPath = json['picPcPath'];
    picMbPath = json['picMbPath'];
    title = json['title'];
    inType = json['inType'];
    inPageType = json['inPageType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['evebNum'] = this.evebNum;
    data['clientShow'] = this.clientShow;
    data['advType'] = this.advType;
    data['picTarget'] = this.picTarget;
    data['actId'] = this.actId;
    data['activityId'] = this.activityId;
    data['outStation'] = this.outStation;
    data['path'] = this.path;
    data['picPcPath'] = this.picPcPath;
    data['picMbPath'] = this.picMbPath;
    data['title'] = this.title;
    data['inType'] = this.inType;
    data['inPageType'] = this.inPageType;
    return data;
  }

  @override
  String toString() {
    return 'Page{evebNum: $evebNum, clientShow: $clientShow, advType: $advType, picTarget: $picTarget, actId: $actId, activityId: $activityId, outStation: $outStation, path: $path, picPcPath: $picPcPath, picMbPath: $picMbPath, title: $title, inType: $inType, inPageType: $inPageType}';
  }
}