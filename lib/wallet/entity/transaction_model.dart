import 'dart:developer';

import 'package:flutter_demo/base_page/base_pagina_model.dart';
import 'package:flutter_demo/entity/base_model.dart';

// class TransactionPageModel extends BasePageModel<TransactionModel>{
//   TransactionPageModel({required num total,required num size,required num current,required TransactionModel data}) : super(total, size,current,records);
//
//   static TransactionPageModel fromJson(Map<String, dynamic> json) {
//     TransactionModel _model = TransactionModel.fromJson(json['data']);
//     TransactionPageModel model = TransactionPageModel(
//       total : json['total'],
//       size : json['size'],
//       current : json['current'],
//       data :_model
//     );
//     return model;
//   }
// }

class TransactionModel extends BaseModel{
  final num amount;
  final String description;
  final String showName;
  final bool resultType;
  final num type;
  final String createTime;


  TransactionModel(
      {required this.amount,
        required this.showName,
        required this.description,
        required this.resultType,
        required this.createTime,
        required this.type});

  static TransactionModel fromJson(Map<String, dynamic> json) {
    TransactionModel model = TransactionModel(
      amount: json['amount'],
      description: json['description'],
      showName: json['userName'],
      resultType: json['resultType'],
      type: json['type'],
      createTime: json['createTime'],
    );
    return model;
  }
}