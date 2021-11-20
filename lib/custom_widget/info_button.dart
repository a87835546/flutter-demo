import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

typedef InfoButtonTapCallback = void Function();

class InfoButton extends StatelessWidget {
  InfoButton(
      {this.key,
      required this.title,
      this.width,
      required this.iconName,
      this.clickBtn})
      : assert(
          title != null,
        ),
        super(key: key);

  Key? key;
  final Widget title;
  final double? width;
  final String iconName;
  final InfoButtonTapCallback? clickBtn;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(color: Colors.red),
      child: GestureDetector(
        onTap: () async {
          print(clickBtn.runtimeType);
          clickBtn!();
        },
        child: Center(
          widthFactor: 1,
          child: Container(
            height: 20,
            width: width ?? 100,

            padding: const EdgeInsets.only(left: 0),
            // margin:const EdgeInsets.only(top: 5, bottom: 5),
            color: Colors.transparent,
            alignment: Alignment.center,
            child: Row(
              children: [
                title,
                Image.asset(
                  iconName,
                  height: 16,
                  width: 16,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
