import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo/sport/widget/tip_text_view.dart';

/**
 * 体育的跑马灯
 */
class SportNotificationView extends StatefulWidget {
  final List<String> maquaa;

  const SportNotificationView({Key? key, required this.maquaa})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _SportNotificationViewState();
}

class _SportNotificationViewState extends State<SportNotificationView> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          margin: EdgeInsets.only(left: 45, right: 20, top: 7, bottom: 5),
          color: Colors.black,
          height: 20.0,
          child: TipSwitchText(
            widget.maquaa,
            scrollDirection: Axis.vertical,
            style: TextStyle(color: Color(0XFFC1C2C4), fontSize: 14),
            textAlign: TextAlign.left,
          ),
        ),
        Positioned(
            child: Container(
                margin: EdgeInsets.only(left: 20, right: 20, top: 5, bottom: 5),
                child: Image.asset(
                  "imgs/mine/images/tx_icon@3x.png",
                  height: 20,
                ),),)
      ],
    );
  }
}
