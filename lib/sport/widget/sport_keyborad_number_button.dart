import 'dart:developer';

import 'package:flutter/cupertino.dart';

class SportKeyboardNumberButton extends StatelessWidget {
  final String title;
  final Function click;

  const SportKeyboardNumberButton(
      {Key? key, required this.title, required this.click})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        click();
        log(title);
      },
      child: Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(2)),
          color: Color(0xff404043),
        ),
        alignment: Alignment.center,
        child: Text(
          title,
          style: const TextStyle(
            color: Color(0xffC1C2C4),
            fontSize: 16,
          ),
        ),
      ),
      behavior: HitTestBehavior.opaque,
    );
  }
}
