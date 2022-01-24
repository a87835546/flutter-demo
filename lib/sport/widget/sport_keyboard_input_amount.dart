import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo/sport/widget/sport_keyborad_number_button.dart';

class SportKeyboardInputAmountView extends StatefulWidget {
  final double width;

  const SportKeyboardInputAmountView({Key? key, required this.width})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _SportKeyboardInputAmountViewState();
}

class _SportKeyboardInputAmountViewState
    extends State<SportKeyboardInputAmountView> {
  final ScrollController _controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      color: Colors.transparent,
      child: GridView.count(
        shrinkWrap: true,
        crossAxisSpacing: 2,
        crossAxisCount: 1,
        mainAxisSpacing: 2,
        padding: EdgeInsets.all(2),
        childAspectRatio: 1.9,
        children: ["100", "200", "500", "MAX"].map((e) {
          return SportKeyboardNumberButton(
            title: e,
            click: () {},
          );
        }).toList(),
        controller: _controller,
      ),
    );
  }
}
