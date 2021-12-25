class DepositStyleModel {
  final num id;
  final String name;
  final String url;
  final String showName;
  final num paymentType;
  final num maxAmount;
  final num minAmount;
  final num amountType;
  final List<DepositChannel> channels;

  DepositStyleModel(
      {required this.name,
      required this.url,
      required this.showName,
      required this.paymentType,
      required this.maxAmount,
      required this.minAmount,
      required this.amountType,
      required this.id,
      required this.channels});


  static DepositStyleModel fromJson(Map<String, dynamic> json) {
    List<DepositChannel> _channels = [];
    if (json["channelVoList"] != null) {
      List list = json["channelVoList"] as List;
      list.forEach((element) {
        _channels.add(DepositChannel.fromJson(element));
      });
    }
    DepositStyleModel model = DepositStyleModel(
        id: json['id'],
        name: json['name'],
        url: json['logoUrl'],
        showName: json['showName'],
        paymentType: json['paymentType'],
        maxAmount: json['maxAmount'],
        minAmount: json['minAmount'],
        amountType: json['amountType'],
        channels: _channels);
    return model;
  }

  @override
  String toString() {
    return 'DepositStyleModel{id: $id, name: $name, url: $url, showName: $showName, paymentType: $paymentType, maxAmount: $maxAmount, minAmount: $minAmount, amountType: $amountType, channels: $channels}';
  }
}

class DepositChannel {
  final num id;
  final String name;
  final String url;
  final String showName;
  final num maxAmount;
  final num minAmount;
  final num depositTypeId;
  final List<String> fixedAmount;

  DepositChannel({
    required this.name,
    required this.url,
    required this.showName,
    required this.maxAmount,
    required this.minAmount,
    required this.id,
    required this.fixedAmount,
    required this.depositTypeId
  });

  static DepositChannel fromJson(Map<String, dynamic> json) {
    List<String> temp = [];
    if(json["fixedAmount"] !=null){
      temp = (json["fixedAmount"] as String).split(",");
    }
    DepositChannel model = DepositChannel(
      id: json['id'],
      name: json['name'],
      url: json['logoUrl'],
      showName: json['showName'],
      fixedAmount: temp,
      maxAmount: json['maxAmount'],
      minAmount: json['minAmount'],
        depositTypeId:json["depositTypeId"],
    );
    return model;
  }

  @override
  String toString() {
    return 'DepositChannel{id: $id, name: $name, url: $url, showName: $showName, maxAmount: $maxAmount, minAmount: $minAmount, fixedAmount: $fixedAmount}';
  }
}
