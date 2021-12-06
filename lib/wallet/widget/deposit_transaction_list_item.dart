import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DepositTransactionListView extends StatefulWidget {
  const DepositTransactionListView({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _DepositTransactionListViewState();
}

class _DepositTransactionListViewState
    extends State<DepositTransactionListView> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(itemBuilder: (context, index) {
      return Padding(
        padding: EdgeInsets.only(left: 14, right: 14, bottom: 10),
        child: Container(
          height: 60,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: Color(0xff2C2C2E), borderRadius: BorderRadius.circular(4)),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(left: 10, right: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      height: 30,
                      alignment: Alignment.center,
                      child: Text(
                        "123",
                        style:
                            TextStyle(color: Color(0xffC1C2C4), fontSize: 12),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        height: 30,
                        alignment: Alignment.centerRight,
                        child: Text(
                          "123",
                          style: TextStyle(color: Colors.white, fontSize: 12),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 10, right: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      height: 30,
                      alignment: Alignment.center,
                      child: Text(
                        "123",
                        style:
                            TextStyle(color: Color(0xffC1C2C4), fontSize: 12),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        height: 30,
                        alignment: Alignment.centerRight,
                        child: Text(
                          "123",
                          style:
                              TextStyle(color: Color(0xff26C97F), fontSize: 12),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    },itemCount: 10,);
  }
}
