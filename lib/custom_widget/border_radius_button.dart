import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

typedef BorderRadiusButtonClick = void Function();

class BorderRadiusButton extends StatelessWidget {
  final Widget title;
  final BorderRadiusButtonClick? click;
  double width = 10;
  double height = 10;

  BorderRadiusButton(this.width,this.height,{required this.title, Key? key, this.click})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double _radius = width > height ? height/2 : width/2;
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(_radius),
        border: Border.all(color: Colors.redAccent,width: 1),
      ),
      child: GestureDetector(
        onTap: click,
        child: Container(
          alignment: Alignment.center,
          child: title,
        ),
      ),
    );
  }
}
