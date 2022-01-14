import 'dart:developer';

import 'package:flutter_demo/entity/base_model.dart';

class BasePageModel<T extends BaseModel> {
  num total;
  num size;
  num current;
  List<T> records;

  BasePageModel(this.total, this.size, this.current, this.records);

  static BasePageModel fromJson<obj extends BaseModel>(Map<String, dynamic> json) {
    log("message --- >>> $json");
    List<Map<String,dynamic>> records = json["records"];
    List temp =  [];
    records.forEach((element) {
      temp.add(BaseModel.fromJson(element));
    });
    return BasePageModel( json['total'], json['size'], json['current'], temp as List<BaseModel>);
  }
}