
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UserInfoButton extends StatefulWidget {
  final Widget title;
  final String iconName;
  final double? width;
  final VoidCallback? click;
  const UserInfoButton({Key? key, required this.title, required this.iconName, this.width, this.click}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _UserInfoButtonState();

}

class _UserInfoButtonState extends State<UserInfoButton>{
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        widget.click!();
      },
      child: Center(
        widthFactor: 1,
        child: Container(
          height: 20,
          padding: const EdgeInsets.only(left: 0),
          color: Colors.transparent,
          alignment: Alignment.center,
          child: Row(
            children: [
              widget.title,
              const Padding(padding: EdgeInsets.only(left: 3)),
              Image.asset(
                widget.iconName,
                height: 16,
                width: 16,
              )
            ],
          ),
        ),
      ),
    );
  }

}