import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo/sport/widget/sport_keyboard_input_amount.dart';
import 'package:flutter_demo/sport/widget/sport_keyborad_number_button.dart';

const double left_margin = 14;
const double right_margin = 14;
const double center_padding = 10;

class SportKeyboardInputNumber extends StatefulWidget {
  const SportKeyboardInputNumber({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _SportKeyboardInputNumberState();
}

class _SportKeyboardInputNumberState extends State<SportKeyboardInputNumber> {
  final ScrollController _controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    double item_width = (MediaQuery.of(context).size.width -
            left_margin -
            right_margin -
            center_padding) /
        4;
    return Container(
      margin: EdgeInsets.only(left: left_margin, right: right_margin),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                  width: item_width * 3,
                  color: Colors.transparent,
                  child: GridView.count(
                    shrinkWrap: true,
                    crossAxisSpacing: 2,
                    crossAxisCount: 3,
                    mainAxisSpacing: 2,
                    padding: EdgeInsets.all(2),
                    childAspectRatio: 2,
                    children: [
                      "1",
                      "2",
                      "3",
                      "4",
                      "5",
                      "6",
                      "7",
                      "8",
                      "9",
                      ".",
                      "0",
                      "-"
                    ].map((e) {
                      return SportKeyboardNumberButton(
                        title: e,
                        click: () {},
                      );
                    }).toList(),
                    controller: _controller,
                  )),
              SizedBox(
                width: center_padding,
              ),
              SportKeyboardInputAmountView(
                width: item_width,
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Container(
              height: 45,
              child: Row(
                children: [
                  Container(
                    width: 3 * item_width,
                    child: Container(
                      height: 42,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(4)),
                        color: Colors.yellowAccent,
                      ),
                      alignment: Alignment.center,
                      child: SportKeyboardNumberButton(
                        title: "投注",
                        click: () {},
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: center_padding,
                  ),
                  Container(
                    width: item_width,
                    alignment: Alignment.center,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(4)),
                      color: Colors.transparent,
                    ),
                    child: SportKeyboardNumberButton(
                      title: "+串关",
                      click: () {},
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
