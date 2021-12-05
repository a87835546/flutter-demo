import 'package:flutter/cupertino.dart';
import 'package:flutter_demo/wallet/widget/deposit_button.dart';

class DepositSelectTypeView extends StatefulWidget {
  const DepositSelectTypeView({Key? key}) : super(key: key);

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
