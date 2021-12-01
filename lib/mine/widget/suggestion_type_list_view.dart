import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo/utils/color_util.dart';
typedef SuggestionTypeListViewSelected = Function(String);
class SuggestionTypeListView extends StatefulWidget {
  final bool visible;
  final SuggestionTypeListViewSelected click;
  const SuggestionTypeListView({Key? key, required this.visible,required this.click}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _SuggestionTypeListView();
}

class _SuggestionTypeListView extends State<SuggestionTypeListView> {
  late int _index = 1111111;
  List titles = [
    '存款问题',
    '存款问题',
    '存款问题',
    '存款问题',
    '存款问题',
    '存款问题',
    '存款问题',
    '存款问题',
    '存款问题'
  ];

  @override
  Widget build(BuildContext context) {
    double left = (MediaQuery.of(context).size.width - 240) / 2;
    return Visibility(
        visible: widget.visible,
        child: Positioned(
          left: left,
          top: 70,
          child: Container(
              height: 240,
              width: 250,
              color: ColorUtil.hexColor('0x333539'),
              child: ListView.separated(
                itemBuilder: (_, index) {
                  return GestureDetector(child: Container(
                      height: 30,
                      alignment: Alignment.center,
                      color: _index == index ? ColorUtil.mainColor():Colors.transparent,
                      child: Text("${titles[index]}",style: TextStyle(
                        color:_index == index ? Colors.black : ColorUtil.mainTitleColor(),
                        fontSize: 14
                      ),)
                  ),onTap: (){
                    widget.click(titles[index]);
                    setState(() {
                      _index = index;
                    });
                  },);
                },
                separatorBuilder: (_, index) {
                  return Divider(color: Colors.transparent, height: 0);
                },

                itemCount: titles.length,
                shrinkWrap: true,
              )),
        ));
  }
}
