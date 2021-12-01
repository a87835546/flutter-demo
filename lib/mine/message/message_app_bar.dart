import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MessageAppBar extends StatefulWidget {
  /// 顶部导航栏的安全区
  final double topPadding;
  const MessageAppBar({Key? key,required this.topPadding}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _M();
}

class _M extends State<MessageAppBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.topPadding + 49,
      color: const Color(0xff252626),
      child: Padding(
        padding: EdgeInsets.only(top: widget.topPadding - 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
                width: 40,
                height: 40,
                // color: Colors.redAccent,
                child: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Image.asset(
                      "imgs/mine/images/icon-customer-service@3x.png",
                      width: 40,
                      height: 24,
                    ))),
            Container(
              child: Text(
                "消息中心",
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
            Container(
              child: IconButton(
                  onPressed: () {},
                  icon: Image.asset(
                    "imgs/mine/images/icon-customer-service@3x.png",
                    width: 40,
                    height: 24,
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
