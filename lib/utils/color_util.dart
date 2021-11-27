
import 'package:flutter/material.dart';

class ColorUtil{
 static Color hexColor(String color){
   int c = int.parse(color);
   int r = (c & 0xff0000) >> 16;
   int g = (c & 0xff00) >> 8;
   int b = (c & 0xff);
    return Color.fromARGB(255, r, g, b);
  }

  static Color mainColor(){
   return ColorUtil.hexColor('0xD0C3A6');
  }
}