import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo/sport/widget/sport_keyboard_input_number.dart';

class SportKeyboard extends StatefulWidget {
  const SportKeyboard({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _SportKeyboardState();
}

class _SportKeyboardState extends State<SportKeyboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black.withAlpha(20),
      body: MediaQuery.removePadding(
        context: context,
        removeTop: true,
        removeBottom: true,
        child: Opacity(
            opacity: 1,
            child: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              behavior: HitTestBehavior.opaque,
              child: Padding(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height -
                        375 -
                        MediaQuery.of(context).padding.bottom -
                        kBottomNavigationBarHeight),
                child: Container(
                  decoration: BoxDecoration(color: Color(0xff2c2c2e)),
                  width: MediaQuery.of(context).size.width,
                  height: 375,
                  child: ListView(
                    physics: const NeverScrollableScrollPhysics(),
                    children: const [
                      SportKeyboardInputNumber(),
                    ],
                  ),
                ),
              ),
            )),
      ),
    );
  }
}
