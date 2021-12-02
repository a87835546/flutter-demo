import 'dart:developer';

class Message {
  int id;
  num? infoId;
  bool isDelete;
  String createUse;
  bool isPush;
  bool isMessage;
  bool isRead;
  int messageType;
  String? textContent;
  num createTime;//时间戳
  String? title;
  // 由时间戳转成的时间
  String? date;
  String? time;
  Message(
      {required this.id,
        required this.title,
      required this.infoId,
      required this.isDelete,
      required this.createUse,
      required this.isPush,
      required this.isMessage,
      required this.isRead,
      required this.messageType,
      required this.createTime,
      required this.textContent});

  static Message fromJson(Map<String, dynamic> json) {
    Message message = Message(
      title: json['title'],
        id: json['id'],
        infoId: json['infoId'],
        isDelete: json['isDelete'],
        createUse: json['createUse'],
        isPush: json['isPush'],
        isMessage: json['isMessage'],
        isRead: json['isRead'],
        messageType: json['messageType'],
        createTime: json['createTime'],
        textContent: json['textContent']);
    if(message.createTime != 0) {
      message.date = Message.getDate(message.createTime).first;
      message.time = Message.getDate(message.createTime).last;
    }
    return message;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['infoId'] = infoId;
    data['isDelete'] = isDelete;
    data['createUse'] = createUse;
    data['isPush'] = isPush;
    data['isMessage'] = isMessage;
    data['isRead'] = isRead;
    data['messageType'] = messageType;
    data['createTime'] = createTime;
    data['textContent'] = textContent;
    data['title'] = title;
    return data;
  }


  @override
  String toString() {
    return 'Message{id: $id, infoId: $infoId, isDelete: $isDelete, createUse: $createUse, isPush: $isPush, isMessage: $isMessage, isRead: $isRead, messageType: $messageType, textContent: $textContent, createTime: $createTime, title: $title, date: $date, time: $time}';
  }

  static List<String?> getDate(num time){
    try{
      DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(time.toInt());
      String s = dateTime.toString();
      var _date =  s.substring(0,10);
      var _time = s.substring(11,19);
      return [_date,_time];
    }catch(err){
      log("parse date err $err");
      return ["",""];
    }
  }
}
