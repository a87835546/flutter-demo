class BankModel {
  String? msg;
  int? code;
  List<Banks>? banks;

  BankModel({this.msg, this.code, this.banks});

  BankModel.fromJson(Map<String, dynamic> json) {
    msg = json['msg'];
    code = json['code'];
    if (json['banks'] != null) {
      banks = new List<Banks>.empty(growable: true);
      json['banks'].forEach((v) {
        banks?.add(new Banks.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['msg'] = this.msg;
    data['code'] = this.code;
    if (this.banks != null) {
      data['banks'] = this.banks?.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Banks {
  int? id;
  String? bankName;
  String? bankCode;
  String? bankLog;
  String? backBankImg;
  int? clientType;
  var category;
  int? wdenable;

  Banks(
      {this.id,
        this.bankName,
        this.bankCode,
        this.bankLog,
        this.backBankImg,
        this.clientType,
        this.category,
        this.wdenable});

  Banks.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    bankName = json['bankName'];
    bankCode = json['number'];
    bankLog = json['bankIconUrl'];
    clientType = json['clientType'];
    category = json['category'];
    wdenable = json['wdenable'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['bankName'] = this.bankName;
    data['bankCode'] = this.bankCode;
    data['bankLog'] = this.bankLog;
    data['backBankImg'] = this.backBankImg;
    data['clientType'] = this.clientType;
    data['category'] = this.category;
    data['wdenable'] = this.wdenable;
    return data;
  }
}