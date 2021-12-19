class DepositStyleModel {
  final num id;
  final String name;
  final String url;
  final String showName;
  final num paymentType;
  final num maxAmount;
  final num minAmount;
  final num amountType;

  DepositStyleModel(
      {required this.name, required this.url, required this.showName, required this.paymentType, required this.maxAmount, required this.minAmount, required this.amountType, required this.id});

  static DepositStyleModel fromJson(Map<String, dynamic> json) {
    DepositStyleModel model = DepositStyleModel(
        id: json['id'],
        name: json['name'],
        url: json['logoUrl'],
        showName: json['showName'],
        paymentType: json['paymentType'],
        maxAmount: json['maxAmount'],
        minAmount: json['minAmount'],
        amountType: json['amountType']
    );
    return model;
  }

  @override
  String toString() {
    return 'DepositStyleModel{id: $id, name: $name, url: $url, showName: $showName, paymentType: $paymentType, maxAmount: $maxAmount, minAmount: $minAmount, amountType: $amountType}';
  }
}