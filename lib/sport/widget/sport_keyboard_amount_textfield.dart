import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SportKeyboardAmountTextField extends StatelessWidget {
  final TextEditingController? controller;

  const SportKeyboardAmountTextField({Key? key, required this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: TextField(
      controller: controller,
      enabled: false,
      style:const TextStyle(
        color: Color(0xffC1C2C4)
      ),
      decoration:const InputDecoration(
        contentPadding: EdgeInsets.only(left: 10),
        hintText: "请输入金额",
        hintStyle: TextStyle(
          color: Colors.white38,
        ),
        disabledBorder: InputBorder.none,
        enabledBorder: InputBorder.none,
        border: InputBorder.none,
      ),
    ));
  }
}
