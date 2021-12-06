import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DepositTransactionOtherListView extends StatefulWidget {
  const DepositTransactionOtherListView({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _DepositTransactionOtherListViewState();
}

class _DepositTransactionOtherListViewState
    extends State<DepositTransactionOtherListView> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(itemBuilder: (context, index) {
      return Padding(
        padding: EdgeInsets.only(left: 14, right: 14, bottom: 10),
        child: Container(
          height: 40,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: Color(0xff2C2C2E), borderRadius: BorderRadius.circular(4)),
          child:Padding(
            padding: EdgeInsets.only(left: 10, right: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  height: 30,
                  alignment: Alignment.center,
                  child: Text(
                    "${DateTime.now()}",
                    style:
                    TextStyle(color: Color(0xffC1C2C4), fontSize: 12),
                  ),
                ),
                Expanded(
                  child: Container(
                    height: 30,
                    alignment: Alignment.center,
                    child: Text(
                      "123",
                      style: TextStyle(color: Colors.white, fontSize: 12),
                    ),
                  ),
                ),
                Container(
                  height: 30,
                  alignment: Alignment.center,
                  child: Text(
                    "123",
                    style:
                    TextStyle(color: Color(0xffC1C2C4), fontSize: 12),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    },itemCount: 10,);
  }
}
