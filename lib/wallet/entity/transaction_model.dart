import 'dart:developer';

class TransactionModel {
  final num amount;
  final String description;
  final String showName;
  final num resultType;
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