import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

typedef BorderRadiusButtonClick = void Function();

class BorderRadiusButton extends StatelessWidget {
  final Widget title;
  final BorderRadiusButtonClick? click;
  final double width ;
  final double height ;

  const BorderRadiusButton({this.width = 10,this.height = 10,required this.title, Key? key, this.click})
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
