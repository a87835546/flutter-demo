import 'package:flutter/cupertino.dart';
import 'package:flutter_demo/wallet/widget/deposit_button.dart';

import 'deposit_style_page.dart';

class DepositSelectTypeView extends StatefulWidget {
  final DepositStylePageType type;

  const DepositSelectTypeView({Key? key,required this.type}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _DepositSelectTypeViewState();
}

class _DepositSelectTypeViewState extends State<DepositSelectTypeView> {
  bool _selected = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              DepositButton(
                title: "人民币充值",
                selected: _selected,
                click: (value) {
                  setState(() {
                    _selected = value == "人民币充值";
                  });
                },
              ),
              DepositButton(
                  title: "人民币充值1",
                  selected: !_selected,
                  click: (value) {
                    setState(() {
                      _selected = value != "人民币充值1";
                    });
                  })
            ],
          )
        ],
      ),
    );
  }
}
