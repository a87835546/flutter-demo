import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

enum UserInfoButtonImageDirection { left, right }

class UserInfoButton extends StatefulWidget {
  final Widget title;
  final String iconName;
  final double? width;
  final VoidCallback? click;
  final UserInfoButtonImageDirection? direction; // 默认图片在右侧
  const UserInfoButton(
      {Key? key,
        required this.title,
        required this.iconName,
        this.width,
        this.click,
        this.direction = UserInfoButtonImageDirection.right})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _UserInfoButtonState();
}

class _UserInfoButtonState extends State<UserInfoButton> {
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
          alignment: Alignment.centerLeft,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              widget.direction == UserInfoButtonImageDirection.left
                  ? Image.asset(
                widget.iconName,
                height: 16,
                width: 16,
              )
                  : widget.title,
              widget.direction == UserInfoButtonImageDirection.right
                  ? Image.asset(
                widget.iconName,
                height: 16,
                width: 16,
              )
                  : widget.title,
            ],
          ),
        ),
      ),
    );
  }
}