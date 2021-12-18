import 'package:flutter/cupertino.dart';

class BankItemView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _BankItemViewState();

}

class _BankItemViewState extends State<BankItemView>{
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Padding(
            padding: EdgeInsets.only(left: 0),
            child: Container(
              height: 34,
              width: 34,
              child: Image.asset(
                  "imgs/deposit/images/wechat@3x.png"),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 5, top: 12),
            child: Column(
              children: [
                Container(
                  child: Text(
                    '中国银行    大师傅看看',
                    style: TextStyle(
                        color: Color(0xffC1C2C4),
                        fontSize: 14),
                  ),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    '1234**********4567',
                    style: TextStyle(
                        color: Color(0xff919699),
                        fontSize: 12),
                    textAlign: TextAlign.left,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

}